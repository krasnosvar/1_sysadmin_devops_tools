#https://dev.to/bitleaf_io/creating-a-digitalocean-droplet-with-terraform-part-3-of-3-cloud-init-358d
terraform {
  required_providers {
    digitalocean = {
      source = "terraform-providers/digitalocean"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}


#var with VMs names
variable "devs" {
  type    = list(string)
  default = ["minikube01"]
}


variable "token" {}
data "template_file" "cloud-init-yaml" {
  template = file("${path.module}/cloud_init_ubuntu.cfg")
  # vars = {
  #   init_ssh_public_key = file(var.ssh_public_key)
  # }
}
# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.token
}

resource "digitalocean_tag" "module" {
  name = "kub08"
}
resource "digitalocean_tag" "email" {
  name = "krasnosvar_gmail_com"
}

# resource "digitalocean_ssh_key" "my_own_kub08_key" {
#   name       = "my_pub_ssh_key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }


# Create a new Droplet using the SSH key
resource "digitalocean_droplet" "kub08" {
  count     = length(var.devs)
  name      = var.devs[count.index]
  image     = "ubuntu-20-04-x64"
  #image     = "centos-8-x64"
  region    = "fra1"
  tags      = [digitalocean_tag.module.name, digitalocean_tag.email.name]
  size      = "s-2vcpu-2gb" #Size slugs are human-readable strings used to specify the type of Droplet in certain API requests
  #ssh_keys = [digitalocean_ssh_key.my_own_kub08_key.fingerprint]
  user_data = data.template_file.cloud-init-yaml.rendered
  ssh_keys  = [28738321]
    connection {
      type        = "ssh"
      private_key = file("~/.ssh/id_rsa")
      user        = "root"
      timeout     = "2m"
      host        = self.ipv4_address
      #host        = digitalocean_droplet.*.ipv4_address
  }
   #Copies the rebrain ssh key to remote droplet
  #   provisioner "file" {
  #   source      = "/home/den/git_projects/rebrain_praktikum/docker/36_dkr_swarm_3_service_mesh"
  #   destination = "/root/ex6"
  # }
  #   provisioner "file" {
  #   source      = "install_docker_with_minikube.sh"
  #   destination = "/root/install_docker_with_minikube.sh"
  # }
  #execute script
  #https://www.terraform.io/docs/provisioners/remote-exec.html#script-arguments
  #   provisioner "remote-exec" {
  #     inline = [
  #       "chmod +x /root/install_docker_with_minikube.sh",
  #       "/root/install_docker_with_minikube.sh",
  #     ]
  # }
}


# Display the IP address
output "ipv4_addreses" {
  value = digitalocean_droplet.kub08.*.ipv4_address
}

#check syntax
#terraform plan -var-file="keys/do_token.tfvars"
#terraform apply -var-file="keys/do_token.tfvars"
