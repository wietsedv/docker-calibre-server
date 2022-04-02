#!/usr/bin/env bash

calibre --version

[ ! -f "/config/users.sqlite" ] && calibre-server --userdb /config/users.sqlite --manage-users -- add "${USERNAME:-admin}" "${USERNAME:-admin}"
[ ! -f "/books/metadata.db" ] && touch /books/metadata.db

XDG_RUNTIME_DIR=/tmp/runtime-root calibre-server \
    --disable-use-bonjour \
    --enable-local-write \
    --userdb=/config/users.sqlite \
    --enable-auth \
    "/books"
