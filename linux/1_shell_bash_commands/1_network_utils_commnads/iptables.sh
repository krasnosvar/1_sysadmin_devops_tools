#IPTABLES
#https://www.cyberciti.biz/tips/linux-iptables-examples.html
#show all rules
iptables -L -n -v
iptables -n -L -v --line-numbers
#display by chains
iptables -L INPUT -n -v
iptables -L OUTPUT -n -v --line-numbers

#allow 8000 port
sudo iptables -I INPUT -p tcp --dport 8000 -j ACCEPT
sudo service iptables save

#редирект с одного порта на другой( открыт vnc 5900, но зайти можно будет через 5901)
#https://habr.com/ru/post/324276/
#https://www.cyberciti.biz/faq/linux-iptables-delete-prerouting-rule-command/
iptables -t nat -A PREROUTING -p tcp --dport 5901 -j REDIRECT --to-port 5900
#редиректить будет, но порт через ss -ntulp виден не будет


#FIREWALL-CMD(firewalld)
firewall-cmd --list-ports
firewall-cmd --list-services
#allow port on centos8
sudo firewall-cmd --get-active-zones
#output
# public
#   interfaces: ens3
sudo firewall-cmd --zone=public --add-port=8000/tcp --permanent
sudo firewall-cmd --reload
#allow 80,443 ports by service 
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --add-service=https

#OracleLinux allow 1521
firewall-cmd --add-port=1521/tcp
#To specify that the port be opened in future restarts of the instance, add the --permanent option
firewall-cmd  --permanent --add-port=1521/tcp
