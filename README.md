# Docker Calibre Server
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/wietsedv/calibre-server)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/wietsedv/calibre-server)
![Docker Pulls](https://img.shields.io/docker/pulls/wietsedv/calibre-server)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/wietsedv/calibre-server/latest)

Automatically updating Docker image for `calibre-server`. The image contains a minimal [Calibre](https://calibre-ebook.com/) installation and starts a Calibre server.

**Note:** This image is unofficial and not affiliated with Calibre.

The image on Docker Hub will automatically be rebuild on every new release of Calibre (may take up to 24 hours). If you're not sure whether this still holds (because last commit was 2 years ago or something like that), you can check whether the current `CALIBRE_RELEASE` argument in the [`Dockerfile`](https://hub.docker.com/r/wietsedv/calibre-server/dockerfile) on the Docker Hub still matches the [latest Calibre release](https://github.com/kovidgoyal/calibre/releases).

## Usage

Calibre server is a REST API + web interface for Calibre. For more information about usage of `calibre-server` itself, refer to the [user guide](https://manual.calibre-ebook.com/server.html) and the [CLI manual](https://manual.calibre-ebook.com/generated/en/calibre-server.html) of Calibre.

### Use case 1: Standalone container for local use

```
$ docker run wietsedv/calibre-server -p 8080:8080 -v /path/to/library:/library
```

Now you have read+write access to your library via `localhost:8080`.

### Use case 2: Access from other containers within network

The command of "Use case 1" gives r+w access to your library on the host machine, but other containers in the network have readonly access. Calibre does not allow giving global r+w access without whitelisting or authentication. To give write access to other containers you should use the Docker `host` network type (not recommended) or you can whitelist containers within the bridge network:

```
$ docker run wietsedv/calibre-server -p 8080:8080 -v /path/to/library:/library -e TRUSTED_HOSTS="web1 web2"
```

**Note:** IP addresses of whitelisted containers (`web1` and `web2`) are resolved when `calibre-server` starts. So containers that need to access `calibre-server` have to start _before_ `calibre-server`.

### Use case 3: Docker compose (recommended)

You can get the same setup as "Use case 2" with this `docker-compose.yaml`:

```yaml
services:
    calibre:
        image: wietsedv/calibre-server
        volumes:
            - /path/to/library:/library
        ports: 
            - "8080:8080"
        depends_on:  # start web1 and web2 before calibre
            - web1
            - web2
        environment:
            TRUSTED_HOSTS: web1 web2  # whitelist web1 and web2
    
    web1:
        image: nginx:alpine

    web2:
        image: nginx:alpine
```
