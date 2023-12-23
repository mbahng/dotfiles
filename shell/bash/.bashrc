# neofetch

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set aliases and shortcuts for commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias vi='nvim'

# Customize the bash/terminal input 
export PS1="\e[1;36m\w>\e[0m"              # just directory name with cyan 

# add /opt/miniconda3/condabin to PATH
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# add /bin/custom_scripts to PATH
export PATH="/bin/custom_scripts:$PATH"

# history size and do not store duplicate commands
HISTSIZE=3000 
HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

