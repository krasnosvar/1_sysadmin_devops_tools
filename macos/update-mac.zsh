# sudo scutil --set HostName denAir

#install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/den/.zprofile eval "$(/opt/homebrew/bin/brew shellenv)"

#inprove zsh
#show only last dir
#https://github.com/agnoster/agnoster-zsh-theme/issues/19

#zsh article
#https://blog.amd-nick.me/iterm-oh-my-zsh/
brew install oh-my-zsh
#install fonts for Terminal
#https://medium.com/@genealabs/agnoster-theme-on-os-x-391d60effaf6
#install fonts for vSCode
#https://gist.github.com/480/3b41f449686a089f34edb45d00672f28
#plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

brew install byobu

brew install --cask visual-studio-code
cat << EOF >> ~/.zprofile\
# Add Visual Studio Code (code)\
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"\
EOF

brew install git
git config --global user.email "krasnosvar@gmail.com"
git config --global user.name "krasnosvar"

#Main OS apps
brew install --cask keepassxc
brew install --cask copyq
brew install --cask dbeaver-community
brew install --cask gimp
brew install --cask telegram
brew install --cask libreoffice
brew install --cask audacity
brew install --cask veracrypt
brew install --cask vlc
brew install gnu-sed

#browsers
brew install --cask vivaldi
brew install --cask firefox
brew install --cask brave-browser
brew install --cask microsoft-edge
brew install --cask google-chrome
brew install --cask tor-browser
brew install --cask opera

#Utils
brew install sevenzip
brew install smartmontools
brew install wget
brew install expect
brew install vault
brew install watch

#displaylink
brew tap homebrew/cask-drivers
brew install --cask displaylink

#netttols
#https://medium.com/@edgar/use-openconnect-as-a-replacement-for-cisco-anyconnect-vpn-client-in-mac-36eab0812718
# brew install openconnect
# sudo sh -c 'echo "%admin ALL=(ALL) NOPASSWD: /opt/homebrew/opt/openconnect/bin/openconnect" >> /etc/sudoers.d/den'
brew install --cask forticlient-vpn
brew install --cask wireshark
brew install sshuttle
brew install openfortivpn
# brew install sshpass
brew install esolitos/ipa/sshpass
brew install --cask remote-desktop-manager-free

#devops-tools
brew install ansible
brew install docker docker-compose terraform
brew install --cask docker
brew install jq yq
brew install awscli
brew install podman
brew install --cask podman-desktop
brew install --cask rancher
brew install kubectl
brew install openjdk
brew install helm
brew install sops age
#psql without postgres db
brew install libpq
echo 'export PATH="/usr/local/opt/libpq/bin:$PATH"' >> ~/.zshrc
brew install pip3

#for VMs
brew install golang
brew install qemu gcc libvirt
brew install virt-manager
