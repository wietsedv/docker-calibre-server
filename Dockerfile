FROM ghcr.io/linuxserver/baseimage-arch:arm64v8-latest

ARG CALIBRE_RELEASE="5.40.0"

ENV HOME="/config"

RUN \
  pacman -Sy --noconfirm --needed calibre=${CALIBRE_RELEASE} && \
  dbus-uuidgen > /etc/machine-id && \
  rm -rf \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*

EXPOSE 8080

VOLUME [ "/config", "/books" ]

COPY entrypoint.sh .
CMD [ "/entrypoint.sh" ]
