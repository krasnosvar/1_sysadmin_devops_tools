# https://github.com/rancher-sandbox/rancher-desktop/releases

echo 'deb http://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/ /' | sudo tee /etc/apt/sources.list.d/isv:Rancher:stable.list
curl -fsSL https://download.opensuse.org/repositories/isv:Rancher:stable/deb/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/isv_Rancher_stable.gpg > /dev/null
sudo apt update
sudo apt install rancher-desktop