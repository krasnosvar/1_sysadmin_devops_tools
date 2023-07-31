#install in Ubuntu

#ZSH
apt install zsh -y

#Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#zsh fonts
sudo apt-get install fonts-powerline zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions home/den/.zsh/zsh-autosuggestions


cat <<EOF > /home/den/.zshrc
export ZSH="/home/den/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(docker git)
source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin
alias work_sshuttle="sshuttle --dns -r den@10.104.12.123:3389 10.0.0.0/8"
alias work_ssh="ssh -p3389 den@10.104.12.123"
alias work_dns="sudo resolvectl dns ppp0 10.8.13.11 && sudo resolvectl domain ppp0 corp.domain.local email.domain.local"
alias kras="expect /home/den/git_projects/1_sysadmin_devops_tools/linux/3_scripts/bash/env_menu/ssh-auto-login/ssh-kras.exp.sh"
alias toor="expect /home/den/git_projects/1_sysadmin_devops_tools/linux/3_scripts/bash/env_menu/ssh-auto-login/ssh-toor.exp.sh"
alias push="git add . && git commit -m \"script auto commit\" && git push"
alias rm='echo "Use <<trash-put>> instead rm, to override alias use \"\\rm file-to-del\" "; false'
complete -C /usr/bin/terraform terraform
alias BackupTo1tb="backup_dir='/media/den/2BAFCC725240051D/backup/'; rsync -vuarP /home/den/git_projects $backup_dir && cp ~/.bashrc $backup_dir && cp /etc/environment $backup_dir && cp ~/.vimrc $backup_dir && cp ~/.zshrc $backup_dir && cp -r ~/.byobu $backup_dir"
EOF

#shorten prompt
https://shandou.medium.com/how-to-shorten-zsh-prompt-oh-my-zsh-14185f3e7ab7
https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/

https://blog.devgenius.io/customize-the-macos-terminal-zsh-4cb387e4f447