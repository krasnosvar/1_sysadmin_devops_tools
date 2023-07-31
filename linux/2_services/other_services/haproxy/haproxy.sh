# install latest haproxy 2.* on Centos7
https://serverfault.com/questions/1002144/install-haproxy-2-on-centos-7
https://idolsgate.com/blog/how-to-install-the-latest-version-of-haproxy-on-centos-7/

LATEST_HAPROXY=$(wget -qO-  http://www.haproxy.org/download/2.4/src/ | egrep -o "haproxy-2\.[0-9]+\.[0-9]+" | head -1)
# Download and install the package:
cd /usr/src/
wget http://www.haproxy.org/download/2.4/src/${LATEST_HAPROXY}.tar.gz
tar xzvf ${LATEST_HAPROXY}.tar.gz
yum install gcc-c++ openssl-devel pcre-static pcre-devel systemd-devel -y
cd /usr/src/${LATEST_HAPROXY}
make TARGET=linux-glibc USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 USE_CRYPT_H=1 USE_LIBCRYPT=1 USE_SYSTEMD=1
mkdir /etc/haproxy
make install
