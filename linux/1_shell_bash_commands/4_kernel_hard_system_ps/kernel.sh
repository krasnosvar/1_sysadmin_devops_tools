#Centos kernel commands
#list of all installed kernels
rpm -q kernel
#remove kernel kernel-3.10.0-327.36.3.el7.x86_64
yum remove kernel-3.10.0-327.36.3.el7.x86_64
#if not installed
yum install yum-utils
#Remove old unused kernel automatically
package-cleanup --oldkernels --count=1

#update kernel on Centos7-8 to 5 ver
#centos7
# https://computingforgeeks.com/install-linux-kernel-5-on-centos-7/
sudo yum -y install https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo yum --disablerepo="*" --enablerepo="elrepo-kernel" list available | grep kernel-ml
sudo yum --disablerepo="*" --enablerepo="elrepo-kernel" list available | grep kernel-lt
sudo yum --enablerepo=elrepo-kernel install kernel-ml
sudo yum --enablerepo=elrepo-kernel install kernel-lt
#
sudo awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg
sudo grub2-set-default 0
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo reboot

#disconnected
elrepo.org/linux/kernel/el7/x86_64/RPMS
elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-5.4.197-1.el7.elrepo.x86_64.rpm

