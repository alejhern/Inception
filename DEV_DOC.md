# Developer Documentation

This document describes how a developer can set up, build, run, and maintain
the Inception project.

## 1. Prerequisites

- A Linux virtual machine (the project must run inside a VM, not on bare
  metal).
- `docker` and the `docker compose` plugin installed.
- `make`.
- Root/sudo access to create the data directories on the host.

## 2. Repository layout

```
.
├── Makefile
└── srcs
    ├── docker-compose.yml
    ├── .env                     # not committed — created manually
    └── requirements
        ├── nginx/
        │   ├── Dockerfile
        │   ├── conf/default.cnf
        │   └── tools/setup.sh
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/www.conf
        │   └── tools/setup.sh
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/default.cnf
        │   ├── conf/uptime_kuma.sql
        │   └── tools/setup.sh
        ├── ftp/                 # bonus
        ├── redis/                # bonus
        ├── static/               # bonus
        ├── adminer/              # bonus
        └── uptime-kuma/          # bonus
```

Every service directory contains its own `Dockerfile`, and, when needed, a
`conf/` folder (static configuration copied into the image) and a `tools/`
folder holding a `setup.sh` entrypoint script (runtime initialization: waiting
for dependencies, first-run install, permissions, then `exec`-ing the real
foreground process as PID 1).

## 3. Setting up the environment from scratch

### 3.1 Create the `.env` file

`srcs/.env` is intentionally git-ignored and must be created manually. Based
on the variables read by the setup scripts, it must define at least:

```dotenv
# Domain
DOMAIN_NAME=alejhern.42.fr

# MariaDB
MYSQL_ROOT_PASSWORD=change_me
MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
MYSQL_PASSWORD=change_me
MYSQL_HOSTNAME=mariadb

# WordPress
WORDPRESS_TITLE=Inception
WORDPRESS_ADMIN=alejhern_boss
WORDPRESS_ADMIN_PASS=change_me
WORDPRESS_ADMIN_EMAIL=admin@example.com
WORDPRESS_USER=editor
WORDPRESS_USER_PASS=change_me
WORDPRESS_EMAIL=editor@example.com

# FTP
FTP_USER=ftpuser
FTP_PASSWORD=change_me

# Uptime Kuma (bonus)
UPTIME_KUMA_DATABASE=uptime_kuma
```

> The WordPress administrator username must **not** contain
> `admin`/`Admin`/`administrator`/`Administrator` (42 subject requirement).

### 3.2 Prepare the host data directories

The `Makefile` creates them for you (`make prepare`, run automatically by
`make all`), but they can also be created manually:

```bash
mkdir -p ~/data/wordpress ~/data/mariadb
```

These paths are bind-mounted as the `device` of the named volumes declared in
`docker-compose.yml` (`wordpress_data`, `mariadb_data`), so WordPress files and
the MariaDB datadir persist on the host across container restarts/rebuilds.

## 4. Building and launching the project

```bash
make            # = make prepare + docker compose up -d --build
```

Other Makefile targets:

| Target | Effect |
|---|---|
| `make prepare` | Creates the `~/data/wordpress` and `~/data/mariadb` directories |
| `make up` | Starts the containers without rebuilding images |
| `make build` | Rebuilds every image with `--no-cache` |
| `make down` | Stops and removes the containers (keeps volumes/data) |
| `make clean` | `docker compose down --volumes --rmi all --remove-orphans` + removes `~/data` |
| `make re` | `clean` followed by `all` (full reset and rebuild) |

Under the hood, every target wraps `docker compose -f ./srcs/docker-compose.yml`.

## 5. Managing containers and volumes

Common commands during development:

```bash
docker compose -f srcs/docker-compose.yml ps          # container status
docker compose -f srcs/docker-compose.yml logs -f nginx
docker compose -f srcs/docker-compose.yml restart wordpress
docker exec -it mariadb bash                            # shell into a container
docker volume ls                                         # list named volumes
docker volume inspect srcs_wordpress_data                # inspect a volume
```

To rebuild a single service after editing its Dockerfile or scripts:

```bash
docker compose -f srcs/docker-compose.yml build wordpress
docker compose -f srcs/docker-compose.yml up -d wordpress
```

## 6. Where data is stored and how it persists

- **WordPress files** (core, themes, plugins, uploads) live in the named
  volume `wordpress_data`, physically stored at `/home/alejhern/data/wordpress`
  on the host, and mounted at `/var/www/html` in the `wordpress`, `nginx`, and
  `ftp` containers.
- **MariaDB data** (all databases: WordPress and Uptime Kuma) lives in the
  named volume `mariadb_data`, physically stored at
  `/home/alejhern/data/mariadb`, mounted at `/var/lib/mysql` in the `mariadb`
  container.
- Both volumes use the `local` driver with `type: none` / `o: bind` options,
  which lets Docker manage them as named volumes while pinning their actual
  location to a fixed path on the host, as required by the subject — no plain
  bind mount is declared directly in a service's `volumes:` section.
- Because the data lives outside the containers, running `make down` / `make
  up` (or rebuilding images) does **not** erase WordPress content or the
  database. Only `make clean` removes `~/data` and therefore wipes persisted
  data.

## 7. Notes on service startup order

Each `setup.sh` script implements a simple readiness check instead of a fixed
`sleep`:

- `mariadb/tools/setup.sh` initializes the datadir and creates the
  databases/users only once (guarded by a `.initialized` marker file), then
  execs `mariadbd` as the container's foreground (PID 1) process.
- `wordpress/tools/setup.sh` polls MariaDB with `mariadb -e "SELECT 1;"`
  until it responds, then runs the WP-CLI install only on first boot, and
  finally execs `php-fpm8.4 -F` in the foreground.
- `nginx/tools/setup.sh` waits for `wp-config.php`... (WordPress files) to
  exist on the shared volume before generating its self-signed TLS
  certificate and starting `nginx -g "daemon off;"` in the foreground.
- `ftp/tools/setup.sh` creates the FTP system user on first boot and execs
  `vsftpd` in the foreground.

`docker-compose.yml`'s `depends_on` only controls container **start order**,
not real readiness — these polling loops are what make the stack reliably
come up in the right order, without resorting to prohibited hacks like
`sleep infinity` or `tail -f`.