#https://docs.fedoraproject.org/en-US/fedora-coreos/producing-ign/
#create ignition
docker pull quay.io/coreos/fcct:release
docker run -i --rm quay.io/coreos/fcct:release --pretty --strict < example.fcc > example.ign

#download coreos image
https://getfedora.org/coreos/download?tab=metal_virtualized&stream=stable
