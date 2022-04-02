#!/usr/bin/with-contenv bash

umask ${UMASK:-022}

calibre --version

[ ! -f "/config/users.sqlite" ] && s6-setuidgid abc calibre-server --userdb /config/users.sqlite --manage-users -- add "${USERNAME:-admin}" "${USERNAME:-admin}"
[ ! -f "/books/metadata.db" ] && s6-setuidgid abc touch /books/metadata.db

XDG_RUNTIME_DIR=/tmp/runtime-root s6-setuidgid abc calibre-server \
    --disable-use-bonjour \
    --enable-local-write \
    --userdb=/config/users.sqlite \
    --enable-auth \
    "/books"
