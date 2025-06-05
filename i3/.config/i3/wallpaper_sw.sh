
#!/bin/bash
wallpaper_dir="$HOME/dotfiles/wallpapers"
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
    3) selnum=1 ;;
    *) ;;
esac
total=$(ls "$wallpaper_dir" | wc -l)
# check for overflow and underflow
if [ "$selnum" -gt "$total" ]; then
    selnum=1
fi

if [ "$selnum" -lt "1" ]; then
    selnum=$(ls "$wallpaper_dir"| wc -l)
fi

# Save state
echo "$selnum" > "$STATE_FILE"

# Get filename at line $selnum
selfile=$(ls "$HOME/dotfiles/wallpapers" | awk -v n="$selnum" 'NR==n')

# Exit if no file found
if [ -z "$selfile" ]; then
    echo "No such file at position $selnum"
    exit 1
fi


# Set wallpaper
feh --bg-scale "$HOME/dotfiles/wallpapers/$selfile"

