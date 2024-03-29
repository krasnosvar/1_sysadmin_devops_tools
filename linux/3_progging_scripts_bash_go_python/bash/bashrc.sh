###############DEPRECATED
# #nopasswd function
# function kras() {
#         sshpass -p krasspasswd -v ssh -o StrictHostKeychecking=no krasnosvarov_dn@${1}
# }
# export -f kras

# #
# function loc() {
#         sshpass -p localpasswd -v ssh -o StrictHostKeychecking=no local@${1}
# }
# export -f loc

# function toor() {
#         sshpass -p toorpasswd -v ssh -o StrictHostKeychecking=no toor@${1}
# }
# export -f toor
###############DEPRECATED



#shorting commands 
alias menu="bash /usr/git/work/scripts/menu.sh"
alias ls="ls -lah"
alias df="df -hT"
alias netstat="netstat -ntulp"
alias push="git add . && git commit -m "usual-commit" && git push"


#pip install through usual command "pip install PACKET", using function to determine if intall, then use long proxy-command, else- read input.
#python pip install
pip() {
    if [[ $1 == "install" ]]; then
        command sudo pip install --index-url http://pypi.corp.domain.ru:10081/root/pypi/+simple/ --trusted-host pypi.corp.domain.ru $2
    else
        command sudo pip "$@"
    fi
}

#python pip3 install
pip3() {
    if [[ $1 == "install" ]]; then
        command sudo pip3 install --index-url http://pypi.corp.domain.ru:10081/root/pypi/+simple/ --trusted-host pypi.corp.domain.ru $2
    else
        command sudo pip3 "$@"
    fi
}

#bash-history inproving variables:
#https://www.shellhacks.com/ru/tune-command-line-history-bash/
#date and time in history
export HISTTIMEFORMAT="%h %d %H:%M:%S "
#emmidiatly record command-history
PROMPT_COMMAND='history -a'

#can be "turned ON" on ubuntu
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=2000
# don't put duplicate lines or lines starting with space in the history(do not save command started with space and do not save last duplicating commands).
HISTCONTROL=ignoreboth
