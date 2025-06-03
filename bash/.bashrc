#
# ~/.bashrc
# Author Daniel Blue

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
# PS1='\[\033[32m\]\u@\h \[\033[37m\]> \[\033[31m\]\w \[\033[1;37m\]%\[\033[0;37m\] '
PS1='\u@\h \W % '

shopt -s autocd # cd into directory by merely typing the directory
alias xit='if [ -n "$TMUX" ]; then tmux kill-session && exit; else exit; fi'
# beam
echo -ne '\x1b[2 q' 

export PATH=/home/daniel/.cargo/bin:$PATH
export PATH=/home/daniel/.config/emacs/bin:$PATH
export QSYS_ROOTDIR="/home/daniel/.cache/yay/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/24.1/quartus/sopc_builder/bin"

tmux
clear
