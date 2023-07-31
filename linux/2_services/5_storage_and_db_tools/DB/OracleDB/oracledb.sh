# OraDB image from marketplace
# https://cloudmarketplace.oracle.com/marketplace/en_US/adf.task-flow?tabName=O&adf.tfDoc=%2FWEB-INF%2Ftaskflow%2Fadhtf.xml&application_id=47726045&adf.tfId=adhtf

#instlal OraDB by YUM
# https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/running-rpm-packages-to-install-oracle-database.html#GUID-BB7C11E3-D385-4A2F-9EAF-75F4F0AACF02

#run preinstall
yum -y install oracle-database-preinstall-19c
#install local yum-DB
rsync -vuarP /media/den/1tb_wd/images/cloud_images/oracleLinux/oracle-database-ee-19c-1.0-1.x86_64.rpm den@192.168.122.40:/home/den
yum -y install oracle-database-ee-19c-1.0-1.x86_64.rpm

#install client(sqlplus)
sudo yum list installed | grep instantclient
sudo dnf install oracle-instantclient-release-el8
sudo dnf install oracle-instantclient-basic
sudo dnf install oracle-instantclient-sqlplus


Install Oracle Database 19c on CentOS 8
# curl -o oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm
#https://www.centlinux.com/2020/04/install-oracle-database-19c-on-centos-8.html
