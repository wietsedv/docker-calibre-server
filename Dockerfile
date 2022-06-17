FROM --platform=linux/amd64 alpine:latest

RUN apk --no-cache add curl xz

ARG CALIBRE_RELEASE="5.44.0"

RUN curl -o /tmp/calibre-tarball.txz -L "https://download.calibre-ebook.com/${CALIBRE_RELEASE}/calibre-${CALIBRE_RELEASE}-x86_64.txz" && \
    mkdir -p /opt/calibre && \
    tar xvf /tmp/calibre-tarball.txz -C /opt/calibre && \
    rm -rf /tmp/*


FROM --platform=linux/amd64 debian:buster-slim

RUN apt-get update && apt-get install -y \
    dnsutils \
    iproute2 \
    libfontconfig \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=0 /opt/calibre /opt/calibre
RUN /opt/calibre/calibre_postinstall && \
    mkdir /library && \
    touch /library/metadata.db

COPY start-calibre-server.sh .

EXPOSE 8080
CMD [ "/start-calibre-server.sh" ]
