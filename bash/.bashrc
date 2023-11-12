#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# brukdjh
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Customize the bash/terminal input 
#export PS1="\e[1;36m\u@\h \w> \e[0m"       # for ubuntu default like
export PS1="\e[1;36m\w >\e[0m"              # just directory name with cyan 

# add /opt/miniconda3/condabin to PATH
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# add /bin/custom_scripts to PATH
export PATH="/bin/custom_scripts:$PATH"
