#
# ~/.bashrc
# Author Daniel Blue

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
alias gitlabc='./gitlabc.sh'
PS1='\[\033[1;34m\][\t] \[\033[32m\]\u@\h \[\033[37m\]> \[\033[31m\]\w \[\033[1;37m\]\n$\[\033[0;37m\] '

export PATH=/home/daniel/.cargo/bin:$PATH
export PATH=/home/daniel/.config/emacs/bin:$PATH

fortune | cowsay -f tux | lolcat

