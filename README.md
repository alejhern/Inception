*This project has been created as part of the 42 curriculum by alejhern.*

# Inception

## Description

**Inception** is a system administration project whose goal is to set up a small,
production‑style web infrastructure entirely with **Docker** and **Docker Compose**,
inside a dedicated virtual machine.

Every service runs in its own container, built from a **custom Dockerfile** (no
pre‑built images are pulled from Docker Hub, except the base `debian` image). The
mandatory stack is composed of:

- **NGINX** — the single entry point of the infrastructure, exposing HTTPS on port
  `443` only (TLSv1.3).
- **WordPress + php‑fpm** — the CMS, installed and configured automatically on first
  boot via WP‑CLI, without any bundled web server.
- **MariaDB** — the database engine used by WordPress (and, in the bonus part, by
  Uptime Kuma).

On top of that, two **named volumes** persist the WordPress files and the MariaDB
data on the host, under `/home/alejhern/data`, and a dedicated **bridge network**
(`alejhernet`) connects all the containers.

### Bonus services

- **Redis** — object cache for WordPress.
- **FTP server (vsftpd)** — access to the WordPress volume.
- **Static website** — a small HTML/CSS/JS showcase site served by its own NGINX,
  independent from PHP.
- **Adminer** — lightweight web UI to administer the MariaDB database.
- **Uptime Kuma** — monitoring service used to watch the status of the other
  containers (service of choice).

## Instructions

Full step-by-step instructions are available in:

- [`USER_DOC.md`](./USER_DOC.md) — how to start/stop the project, access the
  website and the admin panel, and check that everything is running.
- [`DEV_DOC.md`](./DEV_DOC.md) — how to set up the environment, build the images,
  and manage containers/volumes as a developer.

Quick start:

```bash
git clone https://github.com/alejhern/Inception.git
cd Inception
# create srcs/.env with the required variables (see DEV_DOC.md)
make
```

Then visit `https://alejhern.42.fr` (after adding it to `/etc/hosts` pointing to
the VM's IP address).

## Project description — design choices

### Virtual Machines vs Docker

A **virtual machine** virtualizes an entire computer, including its own kernel,
which makes it heavy to boot, resource-hungry, and slow to reproduce. **Docker**
containers, on the other hand, share the host kernel and only package the
application and its dependencies, which makes them lightweight, fast to start,
and easy to reproduce identically across machines. This project uses one VM as
the *host* (as required by the subject) and Docker *inside* it to isolate each
service (NGINX, WordPress, MariaDB, …) without the overhead of one VM per
service.

### Secrets vs Environment Variables

**Environment variables** (stored in `srcs/.env`, which is git-ignored) are used
here to configure non-sensitive and sensitive values alike (domain name,
database names/users, admin credentials, FTP credentials). They are simple to
use and are injected into containers via `env_file` in `docker-compose.yml`.
**Docker secrets** go a step further: instead of exposing values as process
environment variables (visible via `docker inspect` or `/proc`), they mount the
value as a file inside the container, only accessible to the processes that
need it. Secrets are the recommended approach for production-grade
confidentiality; in this project, `.env` is used and excluded from Git so that
no credential is ever committed to the repository.

### Docker Network vs Host Network

With `network: host`, a container shares the host's network namespace directly,
which removes isolation, can create port conflicts, and lets containers reach
the host network without restriction — it is explicitly forbidden by the
subject. This project instead defines a dedicated **bridge network**
(`alejhernet`) in `docker-compose.yml`. Containers communicate with each other
using their service name as hostname (e.g. `wordpress:9000`, `mariadb:3306`),
while staying isolated from the host network and from other Docker networks.
Only NGINX exposes a port to the host (`443`).

### Docker Volumes vs Bind Mounts

A **bind mount** links a container path directly to an arbitrary path on the
host filesystem, managed entirely outside Docker. A **named volume** is created
and managed by Docker itself, which handles its lifecycle, permissions, and
location, making it more portable and easier to back up. The subject requires
named volumes for the WordPress files and the MariaDB data; here they are
declared as `wordpress_data` and `mariadb_data` in `docker-compose.yml`, using
the `local` driver with `device` options so their actual data is stored under
`/home/alejhern/data` on the host, as required.

## Resources

- [Docker documentation](https://docs.docker.com/)
- [Docker Compose file reference](https://docs.docker.com/compose/compose-file/)
- [WordPress WP-CLI documentation](https://developer.wordpress.org/cli/commands/)
- [MariaDB documentation](https://mariadb.com/kb/en/documentation/)
- [NGINX documentation](https://nginx.org/en/docs/)
- [vsftpd documentation](https://security.appspot.com/vsftpd.html)
- [Redis documentation](https://redis.io/docs/latest/)
- [Adminer](https://www.adminer.org/)
- [Uptime Kuma](https://github.com/louislam/uptime-kuma)

**AI usage:** AI assistance was used to help debug Dockerfile and shell-script
issues (e.g. container startup order, PID 1 / entrypoint behavior), to clarify
Docker/Compose concepts (networks, named volumes, secrets vs env vars), and to
draft/structure this documentation (`README.md`, `USER_DOC.md`, `DEV_DOC.md`).
All generated suggestions were reviewed, tested, and adapted manually before
being kept in the project.