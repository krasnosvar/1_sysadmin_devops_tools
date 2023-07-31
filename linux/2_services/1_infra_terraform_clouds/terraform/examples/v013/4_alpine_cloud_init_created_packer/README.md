###Alpine Linux for KVM

1. alpine-docker forked from ```https://github.com/lightcode/packer-templates```
```
cd alpine-cloud-init-with-docker/
packer build packer_fixed.json
```

2. Repository contains two directories:
- ```alpine-cloud-init-with-docker``` - create image with Hashicorp Packer
```
packer build packer_fixed.json
```
- ```libvirt terraform``` - deploy and scale VMs with Terraform


2. Cloud-init cannot in Alpine(03.10.20):
* install packages ( do it with script before create packer-image)
* configure ssh( can create user and add key, but cannot set password)
