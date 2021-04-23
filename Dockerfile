FROM --platform=linux/amd64 debian:buster-slim

RUN apt-get update && apt-get install -y xz-utils libgl-dev libfontconfig

ARG VERSION="5.16.1"
ARG URL="https://download.calibre-ebook.com/${VERSION}/calibre-${VERSION}-x86_64.txz"

ADD $URL /tmp/calibre-tarball.txz

RUN mkdir -p /opt/calibre && \
    tar xvf /tmp/calibre-tarball.txz -C /opt/calibre && \
    /opt/calibre/calibre_postinstall && \
    rm -rf /tmp/*

# TODO Enable and test authentication (as an alternative to whitelisting ips)
# ARG DEFAULT_USER=admin
# ARG DEFAULT_PASS=admin
# RUN calibre-server --userdb /users.sqlite --manage-users -- add "$DEFAULT_USER" "$DEFAULT_PASS"

COPY start-calibre-server.sh /bin/start-calibre-server

EXPOSE 8080

ENV LIBRARY_PATH "/library"
ENV TRUSTED_IPS "172.17.0.1"
# ENV ENABLE_AUTH false

CMD [ "start-calibre-server" ]
