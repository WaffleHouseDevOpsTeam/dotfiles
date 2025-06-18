#
# ~/.bashrc
# Author Daniel Blue

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
# PS1='\[\033[32m\]\u@\h \[\033[37m\]> \[\033[31m\]\w \[\033[1;37m\]%\[\033[0;37m\] '
# mac style prompt
PS1='\u@\h \W % '

shopt -s autocd # cd into directory by merely typing the directory
# beam
# echo -ne '\x1b[2 q'
#
# fuzzy finding cd!
fcd() {
    local dir
    dir=$(find ~/Documents ~/dotfiles ~ -mindepth 1 -maxdepth 3 \
        -type d -not -path '*/\.*' | \
        fzf --margin 10% --color="bw") && cd "$dir"
}

tsel() {
    local select
    local true_select
    local path

    select=$(tree | tac | sed '1,2d' | fzf --margin 10% --color="bw") || return
    true_select=$(echo "$select" | sed 's/.*[├─│] *//')

    path=$(find . -maxdepth 6 -name "$true_select" | head -n 1)

    if [[ -z "$path" ]]; then
        echo "Not found."
        return 1
    fi

    if [[ -d "$path" ]]; then
        cd "$path" || echo "Failed to cd into $path"
    elif [[ -f "$path" ]]; then
        "${VISUAL:-nano}" "$path"
    else
        echo "Not a file or directory: $path"
    fi
}
# uses my sessionizer scripter 
# (heavily inspired by the one made by the  primagen)
alias session="$HOME/dotfiles/scripts/session.sh"


export VISUAL=nvim
export EDITOR=nvim

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
tmux
clear
