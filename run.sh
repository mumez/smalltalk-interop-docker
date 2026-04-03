#!/bin/bash

mkdir -p "$PWD/screenshots" "$PWD/repos"

docker rm -f sis-pharo01 2>/dev/null || true

docker build -t sis-pharo .
docker run --name sis-pharo01 -d \
    -p 5900:5900 \
    -p 6901:6901 \
    -p 8086:8086 \
    -e PHARO_SIS_PORT=8086 \
    -v "$PWD/screenshots:/root/screenshots" \
    -v "$PWD/repos:/root/repos" \
    sis-pharo
