#!/bin/bash

docker build -t sis-pharo .
docker run --name sis-pharo01 -d \
    -p 5900:5900 \
    -p 6901:6901 \
    -p 8086:8086 \
    -e PHARO_SIS_PORT=8086 \
    -v sis-screenshots:/root/screenshots \
    sis-pharo
