#!/usr/bin/env bash
set -e

TAG="$(curl 'https://api.github.com/repos/kovidgoyal/calibre/releases?per_page=1' | jq -r '.[0].tag_name')"

if [[ ! $TAG =~ ^v[0-9.]+$ ]]; then
    echo "skipping invalid tag: $TAG"
    exit 1
fi

sed -i "s/ARG CALIBRE_RELEASE\=.*/ARG CALIBRE_RELEASE\=\"${TAG:1}\"/" Dockerfile

if git diff --exit-code Dockerfile; then
    echo "already on tag: ${TAG}"
else
    git add Dockerfile
    git commit -m "update Calibre to ${TAG}"
    git push origin main
fi

git tag -f "${TAG}"
git push -f --tags
echo "updated tag: ${TAG}"
