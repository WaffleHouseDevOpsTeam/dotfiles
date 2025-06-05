#!/bin/bash

session=$1
kill_check=$2

# Requires jq. Kills all visible window containers.
kill_all () {
    i3-msg -t get_tree \
      | jq '.. | objects | select(.type? == "con" and .window?) | .id' \
      | xargs -r -n1 -I {} i3-msg "[con_id={}] kill"
}

launch_desktop () {
    # $1 -> desktop number
    # $2 -> desktop name 
    # $3 -> application (optional)

    local desktop_num="$1"
    local desktop_name="$2"
    local app_command="${3:-$2}"  # Use $2 if $3 not provided

    i3-msg "workspace ${desktop_num}:${desktop_name}; exec --no-startup-id bash -c \"$app_command\""
    sleep 0.5
}

# Kill all windows if second arg is 1
case "$kill_check" in
    1)
        kill_all
        ;;
esac

# Launch desktop layout based on session type
case "$session" in
    develop)
        launch_desktop 1 "terminal" "kitty"
        launch_desktop 2 "work-firefox" "firefox -p work"
        launch_desktop 3 "discord"
        launch_desktop 4 "spotify" "gtk-launch spotify"
        launch_desktop 5 "personal-firefox" "firefox -p personal"
        ;;
    basic)
        launch_desktop 1 "terminal" "kitty -- bash -c 'tmux'"
        launch_desktop 2 "personal-firefox" "firefox -p personal"
        ;;
    hw)
        launch_desktop 1 "hw" "firefox https://canvas.georgefox.edu -p work"
        launch_desktop 1 "hw" "gtk-launch octave"
        launch_desktop 2 "resources" "dolphin ~/Documents/College"
        launch_desktop 3 "spotify" "gtk-launch spotify"
        ;;
    *)
        echo "Unknown session type: $session"
        exit 1
        ;;
esac

