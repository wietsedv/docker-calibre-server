#!/usr/bin/env bash

calibre --version

[ ! -f "/config/users.sqlite" ] && calibre-server --userdb /config/users.sqlite --manage-users -- add "${USERNAME:-admin}" "${USERNAME:-admin}"
[ ! -f "/library/metadata.db" ] && touch /library/metadata.db

XDG_RUNTIME_DIR=/tmp/runtime-root calibre-server \
    --disable-use-bonjour \
    --enable-local-write \
    --userdb=/config/users.sqlite \
    "/library"
