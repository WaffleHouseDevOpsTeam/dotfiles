#!/bin/bash
# all of my fuzzy find functions

# fuzzy change directory
fcd() {
    local dir
    dir=$(find ~/Documents ~/dotfiles ~ -mindepth 1 -maxdepth 3 \
        -type d -not -path '*/\.*' 2>/dev/null | \
        fzf --margin 10% --color="bw")

    [[ -n "$dir" ]] && cd "$(readlink -f "$dir")"
}

# tree select
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

#fuzzy vim edit
fvi() {
    $file="$(fzf)"
    "$VISUAL" "$file"
}
