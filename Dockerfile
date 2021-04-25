FROM --platform=linux/amd64 debian:buster-slim

RUN apt-get update && apt-get install -y \
    dnsutils \
    iproute2 \
    libfontconfig \
    libgl1 \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

ARG CALIBRE_RELEASE="5.16.1"
ADD https://download.calibre-ebook.com/${CALIBRE_RELEASE}/calibre-${CALIBRE_RELEASE}-x86_64.txz /tmp/calibre-tarball.txz

RUN mkdir -p /opt/calibre && \
    tar xvf /tmp/calibre-tarball.txz -C /opt/calibre && \
    /opt/calibre/calibre_postinstall && \
    rm -rf /tmp/*

RUN rm /opt/calibre/lib/libQt5WebEngineCore.so*

RUN mkdir /library && touch /library/metadata.db
COPY start-calibre-server.sh .

EXPOSE 8080
CMD [ "/start-calibre-server.sh" ]
