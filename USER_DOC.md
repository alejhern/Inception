# User Documentation

This document explains, in simple terms, how to use the Inception stack once it
has been deployed: what it does, how to start/stop it, how to access the
website and its admin panels, where credentials live, and how to check that
everything is healthy.

## 1. What services are provided by the stack

| Service | What it does | How you reach it |
|---|---|---|
| **NGINX** | Single entry point of the whole infrastructure (HTTPS only) | `https://alejhern.42.fr` |
| **WordPress** | The blog / website (CMS) | `https://alejhern.42.fr` |
| **MariaDB** | Database used by WordPress and Uptime Kuma | Internal only, not reachable from outside |
| **Redis** | Speeds up WordPress by caching data | Internal only, used automatically by WordPress |
| **FTP (vsftpd)** | Lets you transfer files into the WordPress folder | `ftp://alejhern.42.fr` (ports 21, 21000-21010) |
| **Static website** | A small standalone showcase site (not PHP) | `https://alejhern.42.fr/website/` |
| **Adminer** | Web interface to browse/manage the database | `https://alejhern.42.fr/adminer/` |
| **Uptime Kuma** | Monitoring dashboard for the other services | `https://uptime.alejhern.42.fr` |

## 2. Before you start: point the domain to the VM

Add the following line to your machine's hosts file so the domain name
resolves to the virtual machine's IP address:

```
<VM_IP_ADDRESS>   alejhern.42.fr uptime.alejhern.42.fr
```

- Linux/macOS: edit `/etc/hosts`.
- Windows: edit `C:\Windows\System32\drivers\etc\hosts`.

Replace `<VM_IP_ADDRESS>` with the actual IP of the VM running Docker.

## 3. Starting and stopping the project

From the root of the repository, on the virtual machine:

```bash
make        # builds the images (first run) and starts every container
```

To stop everything without deleting your data:

```bash
make down
```

To restart the stack after it has already been built once:

```bash
make up
```

To completely reset the project (containers, images, volumes, and local data):

```bash
make clean
```

## 4. Accessing the website and the administration panel

- **Website (front-end):** `https://alejhern.42.fr`
- **WordPress administration panel:** `https://alejhern.42.fr/wp-admin`
- **Database administration (Adminer):** `https://alejhern.42.fr/adminer/`
- **Monitoring dashboard (Uptime Kuma):** `https://uptime.alejhern.42.fr`

Since the TLS certificate used by NGINX is self-signed, your browser will show
a security warning the first time you connect — this is expected in this local
setup; accept/continue past the warning to reach the site.

## 5. Locating and managing credentials

All credentials are defined as environment variables in `srcs/.env`, a file
that is **not committed to Git** (it is listed in `.gitignore`) for security
reasons. It contains, among others:

- `DOMAIN_NAME` — the site's domain (`alejhern.42.fr`).
- `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD` — the
  MariaDB root and application credentials.
- `WORDPRESS_ADMIN`, `WORDPRESS_ADMIN_PASS`, `WORDPRESS_ADMIN_EMAIL` — the
  WordPress administrator account (its username never contains
  "admin"/"administrator").
- `WORDPRESS_USER`, `WORDPRESS_USER_PASS`, `WORDPRESS_EMAIL` — a second,
  regular WordPress user.
- `FTP_USER`, `FTP_PASSWORD` — the FTP account used to transfer files.

To view or change a credential, open `srcs/.env` directly on the host machine.
After editing it, restart the affected container(s) with `make up` (or
`make re` to fully rebuild) for the change to take effect.

## 6. Checking that the services are running correctly

List all running containers and their status:

```bash
docker ps
```

All eight containers (`nginx`, `wordpress`, `mariadb`, `redis`, `ftp`,
`static`, `adminer`, `uptime`) should be listed with a status of `Up`. Every
container is configured with `restart: always`, so if one crashes, Docker
restarts it automatically.

You can also open the monitoring dashboard at
`https://uptime.alejhern.42.fr` to see the live status of each monitored
service, or check an individual container's logs with:

```bash
docker logs <container_name>
```

For example, `docker logs wordpress` shows whether WordPress finished
installing correctly and is waiting for requests.