oc get configs.samples.operator.openshift.io/cluster -o yaml
#
oc edit configs.samples.operator.openshift.io/cluster -o yaml
managementState: Managed
#list ImageStreams
oc get is -n openshift

#list versions with full link
[root@v00opshift08tst openshift-disconnected-operators]# oc get is nginx -n openshift -o json | jq .spec.tags[].from.name
"v00opshift08tst.ocp4.corp.domain.ru:5000/rhscl/nginx-110-rhel7:latest"
"v00opshift08tst.ocp4.corp.domain.ru:5000/rhscl/nginx-114-rhel7:latest"
"v00opshift08tst.ocp4.corp.domain.ru:5000/rhscl/nginx-116-rhel7:latest"
"1.16"

oc image mirror -a /root/pull2.txt registry.redhat.io/rhscl/nginx-110-rhel7:latest v00opshift08tst.ocp4.corp.domain.ru:5000/rhscl/nginx-110-rhel7:latest
oc image mirror -a /root/pull2.txt registry.redhat.io/rhscl/nginx-116-rhel7:latest v00opshift08tst.ocp4.corp.domain.ru:5000/rhscl/nginx-116-rhel7:latest
oc image mirror -a /root/pull2.txt registry.redhat.io/rhscl/nginx-114-rhel7:latest v00opshift08tst.ocp4.corp.domain.ru:5000/rhscl/nginx-114-rhel7:latest

#create configmap with sert
oc create configmap registry-config --from-file=v00opshift08tst.ocp4.corp.domain.ru..5000=/opt/registry/certs/v00opshift08tst.ocp4.corp.domain.ru.cer -n openshift-config

#
oc patch image.config.openshift.io/cluster --patch '{"spec":{"additionalTrustedCA":{"name":"registry-config"}}}' --type=merge

#edit operator
#https://docs.openshift.com/container-platform/4.5/openshift_images/configuring-samples-operator.html
oc edit configs.samples.operator.openshift.io 
  managementState: Managed
  samplesRegistry: v00opshift08tst.ocp4.corp.domain.ru:5000
