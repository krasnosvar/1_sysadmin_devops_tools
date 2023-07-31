#OpenShift 4 in an Air Gap (disconnected) environment (Part 2 — installation)
https://medium.com/@two.oes/openshift-4-in-an-air-gap-disconnected-environment-part-2-installation-1dd8bf085fdd
#link ip to out
https://docs.openshift.com/container-platform/4.5/networking/configuring_ingress_cluster_traffic/configuring-ingress-cluster-traffic-ingress-controller.html
https://cloud.ibm.com/docs/openshift?topic=openshift-openshift_routes
#ocp cheatsheets
https://gist.github.com/rafaeltuelho/111850b0db31106a4d12a186e1fbc53e
http://www.mastertheboss.com/soa-cloud/openshift/openshift-cheatsheet


#list all pods in cluster
oc get pods --all-namespaces


#USERS
#make user project-admin(not cluster)
oc adm policy add-role-to-user admin USER -n NAMESPACENAME

#make user krasnosvarov_dn cluster-admin
oc adm add-cluster-role cluster-admin krasnosvarov_dn
oc adm policy add-cluster-role-to-user cluster-admin krasnosvarov_dn
#change pass for ldap-system-user(change ldap-secret in ldap config yaml in web)
oc create secret generic ldap-secret --from-literal=bindPassword=qazwsxedc123 -n openshift-config


#allow custom users create pods
#https://medium.com/@songxibin/openshift-run-pod-as-root-7195bec6f8fe
oc adm policy add-scc-to-user anyuid -z default
oc adm policy remove-scc-from-user anyuid -z default


#WORK WITH REGISTRY
#add registry to cluster
podman login registry.ru --tls-verify=false

#CLUSTER
#login to cluster from bastion
oc login --token=token_from_web --server=https://api.ocp4.cluster.ru:6443

#PROJECT(NAMESPACE)
#create new project
oc new-progect kras
#list all resources in namespace ( Replace ${NAMESPACE} with the correct namespace (or omit -n ${NAMESPACE} for the current namespace))
oc get $(oc api-resources --namespaced=true --verbs=list -o name | awk '{printf "%s%s",sep,$0;sep=","}')  --ignore-not-found -n ${NAMESPACE} -o=custom-columns=KIND:.kind,NAME:.metadata.name --sort-by='kind'


###################################################################################
#LOGS debug
#https://access.redhat.com/solutions/4100741
oc edit authentications.operator.openshift.io
oc get pod -n openshift-authentication
oc logs oauth-openshift-76bbd9475b-sp8z6 -n openshift-authentication
for i in $(oc get pod -n openshift-authentication| awk '{print $1}'); do oc logs $i -n openshift-authentication; done| grep medvedev





#
for i in $(oc get po| awk 'NR>1{print $1}'); do oc describe po $i; done


#OPERATORS
https://redhat-connect.gitbook.io/certified-operator-guide/ocp-deployment/installing-openshift