terraform {
 required_version = ">= 0.13"
}


variable "do_token" {}
variable "droplet1-name" {}
variable "droplet2-name" {}
variable "gitlab_token" {}
variable "gl_proj_name" {}

resource "null_resource" "create_ssh_for_servers" {
  provisioner "local-exec" {
    command = "ssh-keygen -b 2048 -t rsa -f keys/ex_key -q -N ''"
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}
resource "digitalocean_tag" "module" {
  name = "devops_ex19do"
}
resource "digitalocean_tag" "email" {
  name = "krasnosvar_gmail_com"
}
# Create a new Droplet for gitlab-runner using the SSH key
resource "digitalocean_droplet" "droplet1" {
  image    = "ubuntu-20-04-x64"
  name     = var.droplet1-name
  region   = "fra1"
  tags     = [digitalocean_tag.module.name, digitalocean_tag.email.name]
  size     = "s-1vcpu-1gb"
  ssh_keys = [27800025, 27565561]
    connection {
      type        = "ssh"
      private_key = file("~/.ssh/id_rsa")
      user        = "root"
      timeout     = "2m"
      host        = digitalocean_droplet.droplet1.ipv4_address
    }
   #Copies the ssh ssh key to remote droplet
    provisioner "file" {
    source      = "keys/ex_key.pub"
    destination = "/etc/ssh/ex_key.pub"
    }
    #copies script for install runner
    provisioner "file" {
    source      = "scripts/install_gitlab_runner.sh"
    destination = "/root/install_gitlab_runner.sh"
    }
    provisioner "file" {
    source      = "scripts/install_docker.sh"
    destination = "/root/install_docker.sh"
    }
    #execute script
    #https://www.terraform.io/docs/provisioners/remote-exec.html#script-arguments
    provisioner "remote-exec" {
      inline = [
        "chmod +x /root/install_gitlab_runner.sh",
        "chmod +x /root/install_docker.sh",
        "/root/install_gitlab_runner.sh",
        "/root/install_docker.sh",
        "cat /etc/ssh/ex_key.pub >> /root/.ssh/authorized_keys"
      ]
  }
}
# Create a new Droplet for deploy golang
resource "digitalocean_droplet" "droplet2" {
  image    = "ubuntu-20-04-x64"
  name     = var.droplet2-name
  region   = "fra1"
  tags     = [digitalocean_tag.module.name, digitalocean_tag.email.name]
  size     = "s-1vcpu-1gb"
  ssh_keys = [27800025, 27565561]
    connection {
      type        = "ssh"
      private_key = file("~/.ssh/id_rsa")
      user        = "root"
      timeout     = "2m"
      host        = digitalocean_droplet.droplet2.ipv4_address
    }
   #Copies the ssh ssh key to remote droplet
    provisioner "file" {
    source      = "keys/ex_key.pub"
    destination = "/etc/ssh/ex_key.pub"
    }
    provisioner "remote-exec" {
      inline = [
        "cat /etc/ssh/ex_key.pub >> /root/.ssh/authorized_keys"
      ]
  }
}

#create gitlab project
provider "gitlab" {
    base_url = "https://gitlab.rebrainme.com/api/v4/"
    token = var.gitlab_token
}
# Add a project owned by the user
resource "gitlab_project" "project_for_ex19do" {
    name = var.gl_proj_name
}
# Add a variable to the project
resource "gitlab_project_variable" "SSH_PRIVATE_KEY" {
    project           = "${gitlab_project.project_for_ex19do.id}"
    environment_scope = "*"
    key               = "SSH_PRIVATE_KEY"
    value             = file("keys/ex_key")
}
resource "gitlab_project_variable" "SSH_PUB_KEY" {
    project = "${gitlab_project.project_for_ex19do.id}"
    key = "SSH_PUB_KEY"
    value = file("keys/ex_key.pub")
}
resource "gitlab_project_variable" "USER" {
    project = "${gitlab_project.project_for_ex19do.id}"
    environment_scope = "*"
    key = "USER"
    value = "root"
}
resource "gitlab_project_variable" "HOST" {
    project = "${gitlab_project.project_for_ex19do.id}"
    environment_scope = "*"
    key = "HOST"
    value = "${digitalocean_droplet.droplet2.ipv4_address}"
}
resource "gitlab_project_variable" "TARGET_DIR_ON_HOST" {
    project = "${gitlab_project.project_for_ex19do.id}"
    environment_scope = "*"
    key = "TARGET_DIR_ON_HOST"
    value = "/usr/share/nginx/files/"
}
#push git repo to gitlab
resource "null_resource" "deploy_project_source_to_gitlab" {
  provisioner "local-exec" {
      working_dir = "/home/den/git_projects/rebrain_praktikum/5_devops/19_gitlabci_2"
      command = <<EOT
        git init;
        git add .;
        git commit -m 'commit by terraform';
        git remote add origin ${gitlab_project.project_for_ex19do.ssh_url_to_repo};
        git push -u origin --all
      EOT      
  }
}


# Display the IP address
output "runner_ipv4_address" {
  value = digitalocean_droplet.droplet1.ipv4_address
}
output "client_ipv4_address" {
  value = digitalocean_droplet.droplet2.ipv4_address
}
output "gitlab_project_ssh_url" {
  value = gitlab_project.project_for_ex19do.ssh_url_to_repo
}


#terraform init
#terraform apply -var-file="keys/do_token.tfvars"
