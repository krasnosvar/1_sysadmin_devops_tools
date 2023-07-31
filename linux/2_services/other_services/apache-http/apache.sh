#install in centos
yum install httpd
#or in centos8
yum groups install “Basic Web Server”

#main config
vi /etc/httpd/conf/httpd.conf

#Count Apache’s (Httpd) Current Connections in Linux
ss -ant | grep :80 | wc -l
netstat -ant | grep :80 | wc -l
