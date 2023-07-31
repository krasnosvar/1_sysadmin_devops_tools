#https://computingforgeeks.com/deploy-kubernetes-cluster-on-ubuntu-with-kubeadm/

#Install kubelet, kubeadm and kubectl
sudo apt update
sudo apt -y install curl apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt -y install vim git curl wget kubelet kubeadm kubectl
#sudo apt-mark hold kubelet kubeadm kubectl

#Disable Swap
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a


#Configure sysctl
sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system


#instlal docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y containerd.io docker-ce docker-ce-cli
  docker
  sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker


sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates


sudo kubeadm config images pull
# kubectl get po
# export KUBECONFIG=/etc/kubernetes/admin.conf

# kubectl get po --all-namespaces
# kubectl cluster-info
# kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
