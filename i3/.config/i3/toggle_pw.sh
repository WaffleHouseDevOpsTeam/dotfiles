#!/bin/bash

TOGGLE=$HOME/.toggle_pw_state

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    powerprofilesctl set power-saver
    notify-send "Power Saving"
    echo "Power Saving" > /tmp/powermode_status.txt

else 
    rm $TOGGLE
    powerprofilesctl set performance
    notify-send "Performance"
    echo "Performance" > /tmp/powermode_status.txt

fi

polybar-msg hook powermode 1
