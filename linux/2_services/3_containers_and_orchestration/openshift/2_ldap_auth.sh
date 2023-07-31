#delete kubeadmin
oc delete secrets kubeadmin -n kube-system

#create local user with admin priveleges
htpasswd -c -B -b users.htpasswd operator qazwsx12345
oc create secret generic htpass-secret --from-file=htpasswd=users.htpasswd -n openshift-config
oc adm policy add-cluster-role-to-user cluster-admin operator


#resctict users to create namespaces
oc patch clusterrolebinding.rbac self-provisioners -p '{"subjects": null}'
oc edit clusterrolebinding.rbac self-provisioners
      rbac.authorization.kubernetes.io/autoupdate: "false"


##############################################################################################
#LDAP
#с одинарными кавычками в пароле может быть даже пробел
oc create secret generic ldap-secret --from-literal=bindPassword='password' -n openshift-config
oc delete secret ldap-secret -n openshift-config
vi ldap-config.yaml
oc apply -f ldap-config.yaml
oc get pod -n openshift-authentication


#Enable debug loglevel for Authentication Operator in OpenShift Container Platform 4 Cluster
#https://access.redhat.com/solutions/4100741



#see auth logs in pods
for i in $(oc get pod -n openshift-authentication| awk 'NR>1{print $1}'); do oc logs $i -n openshift-authentication; done| grep krasnosvarov

##############################################################################################
#ldap-config.yaml allow users by search string
#https://access.redhat.com/solutions/3510401
      url: "ldap://adtest1.corp.domain.ru/OU=Users,OU=gk,DC=corp,DC=domain,DC=ru?sAMAccountName(&(objectclass=*)(|(memberOf=CN=nix_adm,OU=Groups,OU=gk,DC=corp,DC=domain,DC=ru)(memberOf=CN=medvedev_a,OU=Users,OU=ITLab,OU=gk,DC=corp,DC=domain,DC=ru)))"



ldapsearch -h dc1 -D "CN=Administrator,CN=Users,DC=test,DC=local" -b "DC=test,DC=local" -W -s sub "(cn=Guest)"


