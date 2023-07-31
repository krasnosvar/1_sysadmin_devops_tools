#d1. download role helperdode
git clone https://github.com/RedHatOfficial/ocp4-helpernode.git
#2. fill vars.yaml

#3. fill in install-config.yaml

#4.fetch proper openshift-install
export OCP_RELEASE="4.5.6" 
export LOCAL_REGISTRY='v00opshift08tst.ocp4.corp.domain.ru:5000' 
export LOCAL_REPOSITORY='ocp456/openshift' 
export PRODUCT_REPO='openshift-release-dev' 
export LOCAL_SECRET_JSON='/root/pull2.txt' 
export RELEASE_NAME="ocp-release"
export ARCHITECTURE="x86_64"
#проверка переменных
echo $OCP_RELEASE 
echo $LOCAL_REGISTRY 
echo $LOCAL_REPOSITORY
echo $PRODUCT_REPO
echo $LOCAL_SECRET_JSON
echo $RELEASE_NAME
echo $ARCHITECTURE
#
oc adm -a ${LOCAL_SECRET_JSON} release extract --command=openshift-install "${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}-${ARCHITECTURE}"

#чтобы не пересоздавать по новой диски в vmware, команда для затирки boot-сектора, после нее рестарт ВМ и она по новой начнет инсталлиться через PXE
ssh -i /root/.ssh/id_rsa core@v00opshift01tst-bootstrap 'sudo dd if=/dev/zero of=/dev/sda bs=1M count=100'
ssh -i /root/.ssh/id_rsa core@v00opshift02tst-master0 'sudo dd if=/dev/zero of=/dev/sda bs=1M count=100'
ssh -i /root/.ssh/id_rsa core@v00opshift03tst-master1 'sudo dd if=/dev/zero of=/dev/sda bs=1M count=100'
ssh -i /root/.ssh/id_rsa core@v00opshift04tst-master2 'sudo dd if=/dev/zero of=/dev/sda bs=1M count=100'
ssh -i /root/.ssh/id_rsa core@v00opshift05tst-worker0 'sudo dd if=/dev/zero of=/dev/sda bs=1M count=100'
ssh -i /root/.ssh/id_rsa core@v00opshift06tst-worker1 'sudo dd if=/dev/zero of=/dev/sda bs=1M count=100'
ssh -i /root/.ssh/id_rsa core@v00opshift07tst-worker2.ocp4.corp.domain.ru 'sudo dd if=/dev/zero of=/dev/sda bs=1M count=100'



#сборка ingnition из install-config.yml
openshift-install create manifests
#
vi manifests/cluster-scheduler-02-config.yml
  mastersSchedulable: false
#
openshift-install create ignition-configs
cp *.ign /var/www/html/ignition/ 
restorecon -vR /var/www/html/ 
chmod o+r /var/www/html/ignition/*.ign

#теперь в Vcenter влючить ВМки с затертым boot-sector
#проверка состояния сборки через bootstrap
ssh -i StrictHostKeyChecking=no core@v00opshift01tst-bootstrap 'journalctl -b -f -u bootkube.service'
#более подробный вывод
ssh -i StrictHostKeyChecking=no core@v00opshift01tst-bootstrap 'journalctl -b -f'

#export auth for executing "oc" commands
export KUBECONFIG=/root/ocp45_install/INSTALL_DIR/auth/kubeconfig

#апрув сертов, уже забыл зачем
oc get csr
for i in $(oc get csr -o name); do oc adm certificate approve $i; done

#проверка что кластер поднялся
export KUBECONFIG=/root/ocp45_install/INSTALL_DIR/auth/kubeconfig 
oc get no
watch -n5 oc get clusteroperators
cd /root/ocp45_install/INSTALL_DIR
openshift-install wait-for install-complete
