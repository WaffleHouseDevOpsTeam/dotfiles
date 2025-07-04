#!/bin/bash

TOGGLE="$HOME/.toggle_eink"
STATUS_FILE="/tmp/eink_status.txt"

case $1 in
    0)
        if [ ! -e "$TOGGLE" ]; then
            touch "$TOGGLE"
            notify-send "Normal"
            vibrant-cli DP-0 1 ; redshift -x ; echo "n" > "$STATUS_FILE"
        else 
            rm "$TOGGLE"
            notify-send "Einked"
            vibrant-cli DP-0 0.5 ; redshift -P -O 3500 ; echo "e" > "$STATUS_FILE"
        fi
        ;;
    1)
        if [ -f "$STATUS_FILE" ]; then
            cat "$STATUS_FILE"
        else
            echo "n"
            touch "$TOGGLE"
            echo "e" > "$STATUS_FILE"
        fi
        ;;
esac

polybar-msg hook powermode 1

