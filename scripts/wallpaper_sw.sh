
#!/bin/sh

WALLPAPER_DIR="$HOME/dotfiles/wallpapers"
STATE_FILE="$HOME/scripts_tmp/wallpaper_selnum.txt"
selnum=1

# Read saved value if it exists
if [ -f "$STATE_FILE" ]; then
    selnum=$(cat "$STATE_FILE")
else 
    touch "$STATE_FILE"
fi

# Update based on input
case "$1" in
    1) selnum=$((selnum + 1)) ;;
    2) selnum=$((selnum - 1)) ;;
    3) echo "exec" ;;
    4) ;;
    *) ;;
esac

# Count total wallpapers
total=$(find "$WALLPAPER_DIR" -type f | wc -l)

# Wrap around
if [ "$selnum" -gt "$total" ]; then
    selnum=1
fi

if [ "$selnum" -lt 1 ]; then
    selnum=$total
fi

# Save current selection
echo "$selnum" > "$STATE_FILE"

# Get the selected wallpaper
selfile=$(find "$WALLPAPER_DIR" -type f | sort | sed -n "${selnum}p")

# Set wallpaper
[ -n "$selfile" ] && feh --bg-fill "$selfile"


