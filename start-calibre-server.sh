#!/usr/bin/env bash

# Resolve trusted IP addresses
TRUSTED_IPS="$(ip route | awk '/default/ { print $3 }')"
for h in $TRUSTED_HOSTS; do
    HOST_IP="$(nslookup -type=A $h | tail -n2 | awk '/Address:/ { print $2 }')"
    TRUSTED_IPS="${TRUSTED_IPS},${HOST_IP}"
done
echo "trusted ips: ${TRUSTED_IPS}"

# Initialize library
mkdir -p "${LIBRARY_PATH}"
touch "${LIBRARY_PATH}/metadata.db"

XDG_RUNTIME_DIR=/tmp/runtime-root /usr/bin/calibre-server \
    --disable-use-bonjour \
    --enable-local-write \
    --trusted-ips="${TRUSTED_IPS}" \
    "${LIBRARY_PATH}" \
    "$@"
