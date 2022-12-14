# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
HISTSIZE=1000000
HISTFILESIZE=1000000

# To enable your ssh-agent, touch the .ssh-agent file.
# To disable your ssh-agent, delete the file and stop the ssh-agent process.
if [ -f ~/.ssh-agent ]; then
    if ! pgrep -U $USER -x ssh-agent > /dev/null; then
        ssh-agent | grep -v ^echo > ~/.ssh-agent
        . ~/.ssh-agent
        ssh-add
    else
        . ~/.ssh-agent
    fi
fi

alias cdoms='cd /home/AD/chihhan.hung/Documents/dragonlair/mamamia/oms'
alias worknote='vim /home/AD/chihhan.hung/Documents/worknote'
alias dk='docker'
alias dkp='docker container ps -a'
alias cdashbringer='cd /home/AD/chihhan.hung/Documents/ashbringer'
alias ss='gnome-control-center --overview'
#alias code='/home/AD/chihhan.hung/Applications/VSCode-linux-x64/code .'
alias cdashbringer='cd /home/AD/chihhan.hung/Documents/dragonlair/ashbringer'
alias hh='history'

alias gg='git graph --all'
alias code='~/Applications/VSCode-linux-x64/code'
#alias redis-server='/home/AD/chihhan.hung/Applications/redis-5.0.5/src/redis-server'
alias cc='clear'
alias bb='cargo build'
alias bbn='cargo +nightly build'
alias rrn='cargo +nightly run'
alias vimlog='vim -c "%s/\e\[[0-9;]\+[mK]//g" -c ":set nowrap" -c ":set number" -c ":set cursorline"'


PATH=/home/AD/chihhan.hung/Documents/dragonlair/tokyoguru/vim/bin/:$PATH
PATH=/opt/rh/devtoolset-7/root/usr/bin/:$PATH
PATH=/opt/rh/rh-python36/root/usr/bin/:$PATH
PATH=/opt/rh/rh-ruby25/root/usr/bin/:$PATH
PATH=/opt/rh/rh-ruby25/root/usr/local/bin/:$PATH
LD_LIBRARY_PATH=/opt/rh/rh-python36/root/usr/lib64/:$LD_LIBRARY_PATH
LD_LIBRARY_PATH=/opt/rh/rh-ruby25/root/usr/lib64/:$LD_LIBRARY_PATH

export http_proxy=
export https_proxy=
export no_proxy=

#export http_proxy=http://proxy.jp.sbibits.com:8080
#export https_proxy=http://proxy.jp.sbibits.com:8080
#export no_proxy=.jp.sbibits.com,.sbisec.int

source /opt/rh/rh-ruby25/enable 

export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/home/AD/chihhan.hung/Documents/dragonlair/u_have_no_idea_how_Im_capable_of/aws_install/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

eval `ssh-agent -s`
ssh-add

complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make



## Colors?  Used for the prompt.
#Regular text color
BLACK='\[\e[0;30m\]'
#Bold text color
BBLACK='\[\e[1;30m\]'
#background color
BGBLACK='\[\e[40m\]'

RED='\[\e[0;31m\]'
BRED='\[\e[1;31m\]'
BGRED='\[\e[41m\]'

GREEN='\[\e[0;32m\]'
BGREEN='\[\e[1;32m\]'
BGGREEN='\[\e[1;32m\]'

YELLOW='\[\e[0;33m\]'
BYELLOW='\[\e[1;33m\]'
BGYELLOW='\[\e[1;33m\]'

BLUE='\[\e[0;34m\]'
BBLUE='\[\e[1;34m\]'
BGBLUE='\[\e[1;34m\]'

MAGENTA='\[\e[0;35m\]'
BMAGENTA='\[\e[1;35m\]'
BGMAGENTA='\[\e[1;35m\]'
LMAGENTA='\e[1;95m'

CYAN='\[\e[0;36m\]'
BCYAN='\[\e[1;36m\]'
BGCYAN='\[\e[1;36m\]'

WHITE='\[\e[0;37m\]'
BWHITE='\[\e[1;37m\]'
BGWHITE='\[\e[1;37m\]'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PROMPT_COMMAND=smile_prompt

function smile_prompt
{
if [ "$?" -eq "0" ]
then
#smiley
SC="${BGBLUE}good-job"
else
#frowney
SC="${BRED}oops!"
fi
if [ $UID -eq 0 ]
then
#root user color
UC="${RED}"
else
#normal user color
UC="${BWHITE}"
fi
#hostname color
HC="${YELLOW}"
#regular color
RC="${BWHITE}"
#default color
DF='\[\e[0m\]'
#PS1="${BGREEN}[${BMAGENTA}\u${BRED}@${HC}\h ${BCYAN}\W${DF}${BGREEN}] ${SC}${DF} "
PS1="${BGREEN}[${BMAGENTA}\u${BRED}@${GREEN}\h ${BCYAN}\W${DF}${BGREEN}] ${SC}${DF}${HC}$(parse_git_branch)${DF} "
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
