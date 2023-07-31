echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories

apk search --no-cache cloud-init
