#KUBECTL
#https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/
#KUBECTL REFERENCE
#https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#label
#Автодополнение ввода для Kubectl
sudo yum install bash-completion -y
source <(kubectl completion bash) # настройка автодополнения в текущую сессию bash, предварительно должен быть установлен пакет bash-completion .
echo "source <(kubectl completion bash)" >> ~/.bashrc # добавление автодополнения autocomplete постоянно в командную оболочку bash.
#HELP kubectl
kubectl --help
kubectl api-resources
kubectl explain pods
#main cluster info show
kubectl get no
kubectl cluster-info 
kubectl config view
#list all namespaces
kubectl get namespaces
kubectl get pods --all-namespaces
#show pods of namespace "kube-system"
kubectl get pods -n kube-system
#show all resources in namespace
kubectl get all -n kube-system
#show all containers in cluster
#https://kubernetes.io/docs/tasks/access-application-cluster/list-all-running-container-images/#list-container-images-by-pod
kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' |sort
#execute commnad "date" on every pod in cluster
for n in $(kubectl get ns| awk 'NR>1{print $1}'); \
do for i in $(kubectl -n $n get po | grep Running| awk '{print $1}'); \
do kubectl -n $n exec $i -- date; done; done 2>/dev/null
#execute commnad "date" on every pod in SPECIFIC NAMESPACE in cluster
nsc=test-ns; for i in $(kubectl -n $nsc get po | grep Running| awk '{print $1}'); do kubectl -n $nsc exec $i -- date; done


#NAMESPACES
#switch to namespace(and not neet to write in in deployments to apply)
kubectl config set-context --current --namespace=trial7d
#delete all from namespace
kubectl delete all --all -n rook-ceph
#delete-create namespace
kubectl delete namespace {namespace}
kubectl create namespace {namespace}
#if namespace stuck in terminating state
https://www.redhat.com/sysadmin/troubleshooting-terminating-namespaces
https://stackoverflow.com/questions/52369247/namespace-stuck-as-terminating-how-i-removed-it

#PODs
#check on what node is my pod in namespace default
kubectl get pods -o wide -n default
#same for all pods
kubectl get pods -o wide --all-namespaces
#bash into pod
kubectl exec -it podname -- /bin/bash
# delete pods forcefully
for i in $(kubectl get po -n kube-system| grep konnec| awk '{print $1}'); do kubectl delete pod $i --grace-period=0 --force --namespace kube-system; done

#LOGS
#pod logs by label
kubectl logs -l app=krasnosvar_at_gmail.com
#pod logs from all containers constantly( постоянно)
kubectl logs -f first-pod --all-containers=true --tail 10


#get container info(image name) in pod
#json and jq
kubectl get pods -l app=please-set-correct-label -o json | jq .items[].spec.containers[].image
"nginx:1.19.3-alpine"
#go-template
kubectl get pods -l app=please-set-correct-label -o go-template --template="{{range .items}}{{range .spec.containers}}{{.image}} {{end}}{{end}}"
nginx:1.19.3-alpine nginx:1.19.3-alpine nginx:1.19.3-alpine


#working with daemonsets
#label nodes to start pods only on labeled node
kubectl get nodes --show-labels
kubectl label nodes node1, node2 disktype=ssd
#label all nodes
kubectl label nodes --all disktype=ssd


#create resourse by command, not yaml
#create cronjob
kubectl edit cronjob test


#check for taints on node
kubectl get nodes -o jsonpath="{range .items[*]}{.metadata.name} {.spec.taints[?(@.effect=='NoSchedule')].effect}{\"\n\"}{end}"
#untaint master-worker nodes
kubectl taint nodes --all node-role.kubernetes.io/master:NoSchedule-


#CONFIGMAPS
#create from CLI
kubectl create configmap my-config --from-literal=key1=value1 --from-literal=key2=value2
#check
kubectl get configmaps my-config -o yaml
#create from file
kubectl create configmap game-config --from-file=myconfig
#grep specific value from configmap ( from all CMs in all NS)
kubectl get cm -o yaml --all-namespaces | grep "what_you_need"


#SECRETS
#create password as secret
kubectl create secret generic my-password --from-literal=password=mysqlpassword
#check
kubectl get secret my-password
#create secret for registry auth
kubectl create secret docker-registry regcred --docker-server=hub.docker.local --docker-username=docker_user --docker-password=12345 --docker-email=krasnosvar@gmail.com
#pin secret to default namespace
root@node1:~# cat secret.yml 
apiVersion: v1
kind: ServiceAccount
metadata:
  name: default
  namespace: default
imagePullSecrets:
- name: regcred




#write manifests to file
for i in $(kubectl get all -n default| grep -v NAME| awk '{print $1}'); do kubectl get $i -o yaml; echo "*******************"; done > manifests.yml


#if pod stuck in Terminating state
# https://stackoverflow.com/questions/35453792/pods-stuck-in-terminating-status
kubectl delete pod es-kestra-master-0 --grace-period=0 --force --namespace default
for i in $(k0s kubectl get po -n kube-system| grep konnec| awk '{print $1}'); do kubectl delete pod $i --grace-period=0 --force --namespace kube-system; done

#Clean pods ( Error, Completed, NodeShutdown)
for i in $(kubectl -n argocd get po | grep "0/1"| awk '{print $1}'); do kubectl -n argocd delete pod $i; done
