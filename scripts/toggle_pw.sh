
#!/bin/bash

TOGGLE="$HOME/.toggle_pw_state"
STATUS_FILE="/tmp/powermode_status.txt"

case $1 in
    0)
        if [ ! -e "$TOGGLE" ]; then
            touch "$TOGGLE"
            powerprofilesctl set power-saver
            notify-send "Power Saving"
            echo "Power Saving" > "$STATUS_FILE"
        else 
            rm "$TOGGLE"
            powerprofilesctl set performance
            notify-send "Performance"
            echo "Performance" > "$STATUS_FILE"
        fi
        ;;
    1)
        if [ -f "$STATUS_FILE" ]; then
            cat "$STATUS_FILE"
        else
            echo "Power Saving"
            touch "$TOGGLE"
            powerprofilesctl set power-saver
            notify-send "Power Saving"
            echo "Power Saving" > "$STATUS_FILE"
        fi
        ;;
esac

polybar-msg hook powermode 1

