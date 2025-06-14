#!/bin/sh

# rofi scripts wrapper

SCRIPTS_DIR='$HOME/dotfiles/scripts'

chosen=$(ls "$SCRIPTS_DIR" | rofi -dmenu -p "Run Script: ")

if [ -n "$chosen" ]; then
    "$SCRIPTS_DIR/$chosen"
fi
