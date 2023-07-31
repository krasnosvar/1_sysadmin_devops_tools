#!/bin/bash
cpu_count=$(lscpu| grep 'CPU(s)'| awk 'NR==1{print $2}')
#echo $cpu_count

#start loop
for (( redis_instance_num=2; redis_instance_num <= $cpu_count; redis_instance_num++ ))
do 
#echo $redis_instance_num
mkdir -p /var/lib/redis$redis_instance_num/
chown -R redis:redis /var/lib/redis$redis_instance_num/

#filling redis configs
cat <<EOF > /etc/redis$redis_instance_num.conf
#bind 127.0.0.1
protected-mode yes
port $((6379 + $redis_instance_num))
tcp-backlog 511
timeout 0
tcp-keepalive 300
daemonize no
supervised no
pidfile /var/run/redis$redis_instance_num.pid
loglevel notice
logfile /var/log/redis/redis$redis_instance_num.log
databases 16
always-show-logo yes
save 900 1
save 300 10
save 60 10000
stop-writes-on-bgsave-error yes
rdbcompression yes
rdbchecksum yes
dbfilename dump.rdb
dir /var/lib/redis$redis_instance_num
replica-serve-stale-data yes
replica-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-disable-tcp-nodelay no
replica-priority 100
lazyfree-lazy-eviction no
lazyfree-lazy-expire no
lazyfree-lazy-server-del no
replica-lazy-flush no
appendonly no
appendfilename "appendonly.aof"
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
aof-use-rdb-preamble yes
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
latency-monitor-threshold 0
notify-keyspace-events ""
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-size -2
list-compress-depth 0
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
hll-sparse-max-bytes 3000
stream-node-max-bytes 4096
stream-node-max-entries 100
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit replica 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
dynamic-hz yes
aof-rewrite-incremental-fsync yes
rdb-save-incremental-fsync yes
requirepass \$REDIS_PASS
EOF


cat <<EOF > /usr/lib/systemd/system/redis$redis_instance_num.service
[Service]
ExecStart=/usr/bin/redis-server /etc/redis$redis_instance_num.conf --daemonize no
ExecStop=/usr/bin/redis-shutdown redis$redis_instance_num
EOF
done
