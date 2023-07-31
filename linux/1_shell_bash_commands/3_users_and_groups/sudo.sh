#Check if user sudoer on server(if no, output: User apache is not allowed to run sudo on v00graphictst.)
sudo -l -U krasnosvarov_dn

#add user with sudo only in dir
sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
#make user sudoer
sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
#or oneliner
#if user exists, but no sudo
usr=den && echo "$usr ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$usr
#CREATE new user and sudo
usr=den && sudo useradd -s /bin/bash -mU $usr && echo "$usr ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$usr


#allow zabbix execute only systemctl stop-start httpd
[root@v00otrs01web ~]# cat /etc/sudoers.d/zabbixApache 
Cmnd_Alias APACHESVC=/usr/bin/systemctl stop httpd,/usr/bin/systemctl start httpd,/usr/bin/systemctl restart httpd,/usr/bin/systemctl reload httpd
zabbix ALL=(root) NOPASSWD:APACHESVC

#visudo set vim
sudo update-alternatives --config editor


#ПОВРЕЖДЕННЫЙ /ETC/SUDOERS — ОШИБКА В СИНТАКСИСЕ
#https://obu4alka.ru/resheno-povrezhdennyj-etc-sudoers-oshibka-v-sintaksise.html
#1. Откройте два сеанса ssh к серваку (или работа в двух терминалах или две вкладки в терминале).
echo $$
#2. Во второй запустите агент аутентификации с помощью:
pkttyagent --process Ваш_PID
#3. Вернувшись в первый сеанс, запустите:
pkexec visudo
#or
pkexec visudo -f /etc/sudoers.d/file
