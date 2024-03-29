grep -v '^#' /etc/apcupsd/apcupsd.conf | sed '/^$/d' 

#управление сервисом
systemctl start apcupsd.service
systemctl status apcupsd.service

#логи
cat /var/log/apcupsd.events

#общий статус
apcaccess status
apcaccess | grep 'STATUS' | cut -d : -f 2
apcaccess

#check only Battery
service apcupsd status| grep -E "BATT|^B"
