#!/usr/bin/env bash

# Resolve trusted IP addresses
TRUSTED_IPS="$(ip route | awk '/default/ { print $3 }')"
for h in $TRUSTED_HOSTS; do
    HOST_IP="$(nslookup -type=A $h | tail -n2 | awk '/Address:/ { print $2 }')"
    if [ -z "${HOST_IP}" ]; then
        >&2 echo "WARNING: host '$h' not found in network. container with that name will not get write access to the library"
    else
        TRUSTED_IPS="${TRUSTED_IPS},${HOST_IP}"
    fi
done
echo "trusted ips: ${TRUSTED_IPS}"

touch "/library/metadata.db"
XDG_RUNTIME_DIR=/tmp/runtime-root /usr/bin/calibre-server \
    --disable-use-bonjour \
    --enable-local-write \
    --trusted-ips="${TRUSTED_IPS}" \
    "$@" \
    "/library"
