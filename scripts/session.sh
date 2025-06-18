
#!/bin/bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Documents ~/dotfiles -mindepth 1 -maxdepth 1 -type d | \
        sed "s|^$HOME/||" | \
        fzf --margin 10% --color="bw")

    if [[ -n "$selected" ]]; then
        selected="$HOME/$selected"
    fi
fi

if [[ -z $selected ]]; then
    exit 0
fi

# Create a tmux-safe session name by stripping slashes and other chars
session_name=$(basename "$selected" | tr -c '[:alnum:]' '_' | tr '[:upper:]' '[:lower:]')

# Check if we're already inside tmux or if tmux is running
tmux_running=$(pgrep tmux)
selected_name=$(basename "$selected" | tr . _)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then 
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
else
    # Check if session already exists
    if  tmux has-session -t "$selected_name" 2>/dev/null; then
        tmux switch-client -t "$selected_name"
    else
        tmux new-session -ds "$selected_name" -c "$selected"
    fi
fi

