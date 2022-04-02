# [Docker Calibre Server](https://hub.docker.com/r/wietsedv/calibre-server)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/wietsedv/calibre-server?sort=semver)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/wietsedv/calibre-server)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/wietsedv/calibre-server)
![Docker Pulls](https://img.shields.io/docker/pulls/wietsedv/calibre-server)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/wietsedv/calibre-server/latest)

Automatically updating Docker image for `calibre-server`. The image contains a minimal [Calibre](https://calibre-ebook.com/) installation and starts a Calibre server. The current version should correspond with the [latest Calibre release](https://github.com/kovidgoyal/calibre/releases).

**Note:** This image is unofficial and not affiliated with Calibre.

## Usage

Calibre server is a REST API + web interface for Calibre. For more information about usage of `calibre-server` itself, refer to the [user guide](https://manual.calibre-ebook.com/server.html) and the [CLI manual](https://manual.calibre-ebook.com/generated/en/calibre-server.html) of Calibre.

The default login credentials are `admin` / `admin`. They are stored in `/config/users.sqlite` and can be changed [via the cli](https://manual.calibre-ebook.com/server.html#managing-user-accounts-from-the-command-line-only).

### Docker CLI

```
$ docker run -it -p 8080:8080 -v /path/to/config:/config -v /path/to/books:/books wietsedv/calibre-server
```

### Docker Compose

```yaml
services:
  calibre:
    image: wietsedv/calibre-server:arch
    container_name: calibre-server
    volumes:
      - /path/to/config:/config
      - /path/to/books:/books
    ports: 
      - 8080:8080
    restart: unless-stopped
```
