#https://code-ready.github.io/crc/
#http://www.mastertheboss.com/soa-cloud/openshift/getting-started-with-code-ready-containers


#Download crc( with redhat login)
https://cloud.redhat.com/openshift/install/crc/installer-provisioned


#access web-console
crc-console
https://console-openshift-console.apps-crc.testing/dashboards

To access the cluster, first set up your environment by following 'crc oc-env' instructions.
Then you can access it by running 'oc login -u developer -p developer https://api.crc.testing:6443'.
To login as an admin, run 'oc login -u kubeadmin -p Ddbvk-odz4g-NghN8-TiFC8 https://api.crc.testing:6443'.
To access the cluster, first set up your environment by following 'crc oc-env' instructions.

You can now run 'crc console' and use these credentials to access the OpenShift web console.
