terraform {
 required_version = ">= 0.13"
}

variable "token" {}

#var with VMs names
variable "devs" {
  type    = list(string)
  default = ["swarm1", "swarm2", "swarm3"]
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.token
}

resource "digitalocean_tag" "module" {
  name = "docker_ex36"
}
resource "digitalocean_tag" "email" {
  name = "krasnosvar_gmail_com"
}

resource "digitalocean_ssh_key" "my_own_ex14do_key" {
  name       = "my_pub_ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")
}


# Create a new Droplet using the SSH key
resource "digitalocean_droplet" "ex14do" {
  count = length(var.devs)
  name      = var.devs[count.index]
  image    = "ubuntu-20-04-x64"
  region   = "fra1"
  tags   = [digitalocean_tag.module.name, digitalocean_tag.email.name]
  size     = "s-1vcpu-1gb" #Size slugs are human-readable strings used to specify the type of Droplet in certain API requests
  ssh_keys = [digitalocean_ssh_key.my_own_ex14do_key.fingerprint]
  #ssh_keys = [27800025, 27565561]
    connection {
      type        = "ssh"
      private_key = file("~/.ssh/id_rsa")
      user        = "root"
      timeout     = "2m"
      host        = self.ipv4_address
      #host        = digitalocean_droplet.*.ipv4_address
  }
   #Copies the rebrain ssh key to remote droplet
    provisioner "file" {
    source      = "/home/den/git_projects/rebrain_praktikum/docker/36_dkr_swarm_3_service_mesh"
    destination = "/root/ex36"
  }
    provisioner "file" {
    source      = "/home/den/git_projects/rebrain_praktikum/docker/36_dkr_swarm_3_service_mesh/install_docker.sh"
    destination = "/root/install_docker.sh"
  }
  #execute script
  #https://www.terraform.io/docs/provisioners/remote-exec.html#script-arguments
    provisioner "remote-exec" {
      inline = [
        "chmod +x /root/install_docker.sh",
        "/root/install_docker.sh",
      ]
  }
}


# Display the IP address
output "ipv4_addreses" {
  value = digitalocean_droplet.ex14do.*.ipv4_address
}



#check syntax
#terraform plan -var-file="keys/do_token.tfvars"

#terraform apply -var-file="keys/do_token.tfvars"
