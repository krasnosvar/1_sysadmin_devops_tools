#https://dev.to/bitleaf_io/creating-a-digitalocean-droplet-with-terraform-part-3-of-3-cloud-init-358d
#https://cloudskills.io/blog/terraform-azure-01
#1. install "az"
#2. in vars - hostnames and IPs
terraform {
  required_version = ">= 0.13"
}


#var with VMs names
variable "hostname_helper_masters" {
  type    = list(string)
  default = ["helpernode", "hibootstrap", "master01", "master02", "master03"]
}
variable "hostname_workers" {
  type    = list(string)
  default = ["worker01", "worker02", "worker03"]
}
#IPs help_masters
variable "ips_helper_masters" {
  type    = list(string)
  default = ["10.9.23.70", "10.9.23.71", "10.9.23.72", "10.9.23.73", "10.9.23.74"]
}
variable "ips_workers" {
  type    = list(string)
  default = ["10.9.23.75", "10.9.23.76", "10.9.23.77"]
}


# Configure the Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = true
}


# Create public IP
# resource "azurerm_public_ip" "publicip" {
#   name                = "helpernode-ip"
#   location            = "westeurope"
#   resource_group_name = "Openshift" #declared by name in Azure, because resource is already created
#   allocation_method   = "Static"
# }


# Create network security group rule
resource "azurerm_network_security_rule" "openshift_nsg_rule_outbound" {
  name                        = "openshift-to-inet"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.9.23.64/27"
  destination_address_prefix  = "*"
  resource_group_name         = "RG-OPT" #declared by name in Azure, because resource is already created
  network_security_group_name = "NSG-OPT" #declared by name in Azure, because resource is already created
}

#resources helper-masters
################################################################################
resource "azurerm_network_interface" "helpernode-masters-network-interface" {
  count               = length(var.hostname_helper_masters)
  name                = "${var.hostname_helper_masters[count.index]}-nic"
  location            = "westeurope"
  resource_group_name = "Openshift" #declared by name in Azure, because resource is already created

  ip_configuration {
    name                          = "${var.hostname_helper_masters[count.index]}-internal"
    #show subnet id
    #az network vnet subnet list -g RG-OPT --vnet-name RG-VNET-OPT| jq '.[] | .name, .id'
    subnet_id                     = "/subscriptions/111-2222-333333-44444/resourceGroups/RG-OPT/providers/Microsoft.Network/virtualNetworks/RG-VNET-OPT/subnets/VNET-OPT-Subnet-Openshift"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.ips_helper_masters[count.index]
    #public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_linux_virtual_machine" "helpernode-masters" {
  count               = length(var.hostname_helper_masters)
  name                = var.hostname_helper_masters[count.index] 
  #name                = "example-machine"
  resource_group_name = "Openshift"
  location            = "westeurope"
  size                = "Standard_D4s_v3"
  admin_username      = "admin"
  admin_password      = "Password@#$"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.helpernode-masters-network-interface[count.index].id]

  os_disk {
    name                 = "${var.hostname_helper_masters[count.index]}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = "120"
  }

  admin_ssh_key {
    username   = "admin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}


#resources workers
################################################################################
resource "azurerm_network_interface" "workers-network-interface" {
  count               = length(var.hostname_workers)
  name                = "${var.hostname_workers[count.index]}-nic"
  location            = "westeurope"
  resource_group_name = "Openshift" #declared by name in Azure, because resource is already created

  ip_configuration {
    name                          = "${var.hostname_workers[count.index]}-internal"
    subnet_id                     = "/subscriptions/111-2222-333333-44444/resourceGroups/RG-OPT/providers/Microsoft.Network/virtualNetworks/RG-VNET-OPT/subnets/VNET-OPT-Subnet-Openshift"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.ips_workers[count.index]
    #public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_linux_virtual_machine" "workers-vms" {
  count               = length(var.hostname_workers)
  name                = var.hostname_workers[count.index]
  #name                = "example-machine"
  resource_group_name = "Openshift"
  location            = "westeurope"
  size                = "Standard_D8s_v3"
  admin_username      = "admin"
  admin_password      = "Password@#$"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.workers-network-interface[count.index].id]

  os_disk {
    name                 = "${var.hostname_workers[count.index]}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = "120"
  }

  admin_ssh_key {
    username   = "admin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}


# Display the IP address
# output "public_ip_address" {
#   value = azurerm_public_ip.publicip.*.ip_address
# }

#check syntax
#terraform plan -var-file="keys/do_token.tfvars"
#terraform apply -var-file="keys/do_token.tfvars"
#create resource group
