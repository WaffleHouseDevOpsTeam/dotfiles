#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH=/home/daniel/.cargo/bin:$PATH
export PATH=/home/daniel/.config/emacs/bin:$PATH
fortune | cowsay -r | lolcat

