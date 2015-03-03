#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash_profile ]] && source ~/.bash_profile

# terminal related options
export TERM=xterm-color
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export LS_OPTIONS='--color=auto'
export EDITOR=emacs

# customize prompts
# PS1='\e[33;1m[\u@\h: \e[31m\W]\e[0m\$ '
export PS1="\[$(tput bold)\]\[$(tput setaf 3)\][\u@\h: \[$(tput setaf 1)\]\W]\\$ \[$(tput sgr0)\]"

# aliases
alias keylargo='ssh hmcmillen@keylargo.rkgoffice'

alias untar='tar -xvf'
alias ls="ls $LS_OPTIONS"
alias ll="ls -al $LS_OPTIONS"
alias emacs-clean='find . -name "*~" -exec rm {} \; -or -name ".*~" -exec rm {} \;'

# version of a Perl module
function version() {
   /usr/bin/perl -M$1 -e "print \"\$$1::VERSION\n\";"
}

function irctunnel() {
    channel="$1"
    port=$(findRandomTcpPort);
    echo $channel
    ssh -i ~/.ssh/artemis_rsa -N hunter@$ARTEMIS -L $port:$channel:6667 &
    disown -r
    echo "IRC connected to $channel on port $port"
}

findRandomTcpPort() {
	port=$(( 1024+( $(od -An -N2 -i /dev/random) )%(1023+1) ))
	while :
	do
		(echo >/dev/tcp/localhost/$port) &>/dev/null &&  port=$(( 100+( $(od -An -N2 -i /dev/random) )%(1023+1) )) || break
	done
	echo "$port"
}

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# grep coloring
alias grep='grep $GREP_OPTIONS'
alias egrep='egrep $GREP_OPTIONS'

