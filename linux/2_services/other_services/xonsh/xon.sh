https://xon.sh/linux.html


#1. installation
sudo pip3 install xonsh[full] 
sudo pip3 install xontrib-avox

#2. create .xonshrc
cat <<EOF > ~/.xoshrc
aliases['g'] = 'git'
aliases['push'] = 'git add . && git commit -m \"script auto commit\" && git push' 
aliases['work'] = 'ssh -p2277 den@10.8.56.16'
aliases['ll'] = 'ls -lahi'

import os
local_bin = '{}/.local/bin'.format($HOME)
if os.path.isdir(local_bin):
    $PATH.append(local_bin)

$PYENV_ROOT = '%s/.pyenv' % $HOME
$PATH.insert(0, '%s/bin' % $PYENV_ROOT)

xontrib load vox
$PROJECT_DIRS = ["~/projects"]
xontrib load avox

$PROMPT = '{env_name}{BOLD_GREEN}{user}@{hostname}{BOLD_BLUE} {cwd_base}{branch_color}{curr_branch: {}}{RESET} {BOLD_BLUE}{prompt_end}{RESET}'
EOF

#3. set default shell without editing /etc/shells
cat <<EOF > ~/.bashrc
# set default shell without editing /etc/shells
if [ "${XONSH_VERSION:-unset}" = "unset" ] ; then
    export SHELL=$HOME/.local/bin/xonsh
    exec $HOME/.local/bin/xonsh -l
fi
EOF



#add aoutocomplete
#in bash
oc completion bash >/etc/bash_completion.d/oc
kubectl completion bash >/etc/bash_completion.d/kubectl


#deactivate venv
#https://xon.sh/python_virtual_environments.html
vox deactivate

