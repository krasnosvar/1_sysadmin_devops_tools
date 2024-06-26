# Guide on how to use regex in Nginx location block section
https://stackoverflow.com/questions/59846238/guide-on-how-to-use-regex-in-nginx-location-block-section



#config examples
https://techexpert.tips/ru/nginx-ru/nginx-%D0%BE%D1%82%D0%BA%D0%BB%D1%8E%D1%87%D0%B8%D1%82%D1%8C-ssl-tls-1-0-%D0%B8-tls-1-1/


https://github.com/insspb/nginx-config

#print all modules
nginx -V 2>&1|xargs -n1|grep module


# Nginx Rewrite
https://serverfault.com/questions/1076360/how-do-i-redirect-a-location-to-another-but-not-changing-its-url-in-nginx
https://www.digitalocean.com/community/tutorials/nginx-rewrite-url-rules
https://andreyex.ru/operacionnaya-sistema-linux/7-pravil-rewrite-v-nginx-s-primerami-reg-ex-i-flags/


#allow send logs directly from nginx to rsyslog server
http {
  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;
  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for" "$upstream_addr"';

  access_log  /var/log/nginx/access.log;
  
  #####################################################
  #########section with allow logging to remote server
  access_log syslog:server=10.8.62.44:514,facility=local7,tag=nginx,severity=info;
  error_log syslog:server=10.8.62.44:514,facility=local7,tag=nginx,severity=info;
  #####################################################
  #########section with allow logging to remote server
  
  sendfile    on;

  server_tokens off;

  types_hash_max_size 1024;
  types_hash_bucket_size 512;

  server_names_hash_bucket_size 64;
  server_names_hash_max_size 512;

  keepalive_timeout  65;
  tcp_nodelay        on;

  gzip         on;
  gzip_disable "MSIE [1-6]\.(?!.*SV1)";

  client_body_temp_path   /var/nginx/client_body_temp;
  client_max_body_size    1024m;
  client_body_buffer_size 4m;
  proxy_redirect          off;
  proxy_temp_path         /var/nginx/proxy_temp;
  proxy_connect_timeout   28800;
  proxy_send_timeout      28800;
  proxy_read_timeout      28800;
  proxy_buffers           8 256k;
  proxy_buffer_size       64k;
  #####################################################
  #########section with allow logging (showing real ip in log-string)
  set_real_ip_from        10.8.61.0/24;
  real_ip_header          X-Forwarded-For;
  proxy_set_header        Host $host:$server_port;
  proxy_set_header        X-Real-IP $remote_addr;
  proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_headers_hash_bucket_size 64;
  #####################################################
  #########section with allow logging to remote server
  proxy_busy_buffers_size    256k;
  proxy_cache_path           /var/cache/nginx levels=2 keys_zone=pagecache:100m inactive=60m max_size=2048m;
  proxy_temp_file_write_size 10m;
  large_client_header_buffers 8 16k;
  client_header_buffer_size 4k;
#  include /etc/nginx/mime.types;
  include /etc/nginx/conf.d/*.conf;
  include /etc/nginx/sites-enabled/*;
}
