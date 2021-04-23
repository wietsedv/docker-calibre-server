#!/usr/bin/env bash

mkdir -p "${LIBRARY_PATH}"
touch "${LIBRARY_PATH}/metadata.db"

XDG_RUNTIME_DIR=/tmp/runtime-root /usr/bin/calibre-server \
    --disable-use-bonjour \
    --enable-local-write \
    --trusted-ips="${TRUSTED_IPS}" \
    "${LIBRARY_PATH}" \
    "$@"

# TODO Set --enable-auth if ENABLE_AUTH = true:
# XDG_RUNTIME_DIR=/tmp/runtime-root /usr/bin/calibre-server \
#     --disable-use-bonjour \
#     --userdb /users.sqlite \
#     --enable-auth \
#     --enable-local-write \
#     --trusted-ips="${TRUSTED_IPS}" \
#     "${LIBRARY_PATH}" \
#     "$@"
