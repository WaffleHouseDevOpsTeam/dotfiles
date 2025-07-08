#
# ~/.bashrc
# Author Daniel Blue

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$HOME/dotfiles/scripts/fuzzy.sh" 
source "$HOME/secrets.sh"
alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
alias dmac='emacsclient -c -n'
# PS1='\[\033[32m\]\u@\h \[\033[37m\]> \[\033[31m\]\w \[\033[1;37m\]%\[\033[0;37m\] '
# mac style prompt
PS1='\u@\h \W % '

shopt -s autocd # cd into directory by merely typing the directory
# beam
# echo -ne '\x1b[2 q'
#

alias session="$HOME/dotfiles/scripts/session.sh"


export VISUAL=nvim
export EDITOR=nvim
export PATH=/home/daniel/dotfiles/scripts:$PATH
export PATH=/home/daniel/.cargo/bin:$PATH
export PATH=/home/daniel/.config/emacs/bin:$PATH
export QSYS_ROOTDIR="/home/daniel/.cache/yay/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/24.1/quartus/sopc_builder/bin"

# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }


# vim mode
set -o vi

source /home/daniel/Xilinx/Vivado/2024.2/settings64.sh
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    tmux new
fi
clear
