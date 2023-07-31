#install AZ in Linux
sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#logit with azure-cli
az login

#show IPs of Vms in specified resource-group
az vm list-ip-addresses --resource-group Openshift| jq .[].virtualMachine.network.privateIpAddresses

#list azure linux images
az vm image list --output table
#or
az vm image list --offer CentOS --all --output table


#NETWORK
#show subnets list(by name-id) in vnet RG-VNET-OPT
az network vnet subnet list -g RG-OPT --vnet-name RG-VNET-OPT| jq '.[] | .name, .id'
