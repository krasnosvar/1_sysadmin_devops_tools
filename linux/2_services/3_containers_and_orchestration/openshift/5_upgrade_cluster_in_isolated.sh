#https://docs.openshift.com/container-platform/4.5/updating/updating-restricted-network-cluster.html
oc registry login --to /root/pull2.txt --registry "v00opshift08tst.ocp4.corp.domain.ru:5000" --auth-basic=admin:admin



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

#холостая проверка
oc adm release mirror -a ${LOCAL_SECRET_JSON} --to-dir=${REMOVABLE_MEDIA_PATH}/mirror quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} --dry-run


oc adm release mirror -a ${LOCAL_SECRET_JSON} --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} \
  --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} --apply-release-image-signature



#Creating an image signature ConfigMap manually
#https://docs.openshift.com/container-platform/4.5/updating/updating-restricted-network-cluster.html#update-configuring-image-signature
export OCP_RELEASE_NUMBER="4.5.6"
export ARCHITECTURE="x86_64"
DIGEST="$(oc adm release info quay.io/openshift-release-dev/ocp-release:${OCP_RELEASE_NUMBER}-${ARCHITECTURE} | sed -n 's/Pull From: .*@//p')"
echo $DIGEST 
DIGEST_ALGO="${DIGEST%%:*}"
echo $DIGEST_ALGO
DIGEST_ENCODED="${DIGEST#*:}"
echo $DIGEST_ENCODED
SIGNATURE_BASE64=$(curl -s "https://mirror.openshift.com/pub/openshift-v4/signatures/openshift/release/${DIGEST_ALGO}=${DIGEST_ENCODED}/signature-1" | base64 -w0 && echo)
echo $SIGNATURE_BASE64
mkdir release_upgrade
cd release_upgrade/

cat >checksum-${OCP_RELEASE_NUMBER}.yaml <<EOF
 apiVersion: v1
 kind: ConfigMap
 metadata:
   name: release-image-${OCP_RELEASE_NUMBER}
   namespace: openshift-config-managed
   labels:
     release.openshift.io/verification-signatures: ""
 binaryData:
   ${DIGEST_ALGO}-${DIGEST_ENCODED}: ${SIGNATURE_BASE64}
EOF

ll
cat checksum-4.5.5.yaml 
#
oc apply -f checksum-${OCP_RELEASE_NUMBER}.yaml
export LOCAL_REGISTRY='v00opshift08tst.ocp4.corp.domain.ru:5000' 
export LOCAL_REPOSITORY='ocp454/openshift454' 
oc adm upgrade --allow-explicit-upgrade --allow-upgrade-with-warnings --to-image ${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}@sha256:0147ab7622969c1cde71e8e5eb8
oc get clusterversion
oc get co,no,clusterversion
