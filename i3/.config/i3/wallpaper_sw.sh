#!/bin/bash

WALLPAPER_DIR="$HOME/dotfiles/wallpapers"
STATE_FILE="/tmp/wallpaper_selnum.txt"
selnum=1

# Read saved value if it exists
if [ -f "$STATE_FILE" ]; then
    selnum=$(<"$STATE_FILE")
else 
    touch "$STATE_FILE"
fi

# Update based on input
case "$1" in
    1) selnum=$((selnum+1)) ;;
    2) selnum=$((selnum-1)) ;;
    3) echo "exec";;
esac

total=$(ls "$WALLPAPER_DIR" | wc -l)

# check for overflow and underflow, and allow wrap around
if [ "$selnum" -gt "$total" ]; then
    selnum=1
fi

if [ "$selnum" -lt "1" ]; then
    selnum=$(ls "$WALLPAPER_DIR"| wc -l)
fi

# Save state
echo "$selnum" > "$STATE_FILE"

# Get filename at line $selnum
selfile=$(ls "$HOME/dotfiles/wallpapers" | awk -v n="$selnum" 'NR==n')

# only switch if the file exists
if [ -f "$selfile" ]; then
    # Set wallpaper
    feh --bg-scale "$HOME/dotfiles/wallpapers/$selfile"
else
    echo "file not exits, skill issue"
    exit 1
fi


