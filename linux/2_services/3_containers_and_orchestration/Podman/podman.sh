podman pull --tls-verify=false v00rpm-dr.corp.domain.ru/openshift4/registry.fedoraproject.org-fedora:latest

# Check the published ports:
podman port <container_id>

# PODMAN with docker-compose
# https://www.redhat.com/sysadmin/podman-docker-compose

#UBUNTU
#podman with docker-compose in Ubuntu(podman and docker-compose installed)
# purge docker - docker can affect network port-mapping
# https://github.com/containers/podman/issues/8027
apt purge docker*
# link podman socket for docker-compose
ln -s /var/run/podman/podman.sock /var/run/docker.sock
# to build images in compose file
# https://stackoverflow.com/questions/67926618/how-to-run-a-docker-compose-file-in-ubuntu-system-which-has-podman-as-the-contai
export COMPOSE_DOCKER_CLI_BUILD=0
