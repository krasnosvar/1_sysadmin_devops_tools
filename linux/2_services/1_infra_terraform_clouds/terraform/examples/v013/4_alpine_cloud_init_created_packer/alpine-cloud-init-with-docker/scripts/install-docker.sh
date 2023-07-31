#!/bin/sh

echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/main" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/community" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

apk update --quiet
apk add --quiet docker cloud-init
rc-update add cloud-init boot
rc-update add docker boot
