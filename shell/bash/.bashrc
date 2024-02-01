# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set aliases and shortcuts for commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias vi='nvim'

# Customize the bash/terminal input 
export PS1="\e[1;36m\w>\e[0m"              # just directory name with cyan 

# add /bin/custom_scripts to PATH
export PATH="/bin/custom_scripts:$PATH"

# history size and do not store duplicate commands
HISTSIZE=3000 
HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups


