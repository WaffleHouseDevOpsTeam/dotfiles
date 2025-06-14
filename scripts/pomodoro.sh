#!/bin/sh

format_time() {
    min=$(( $1 / 60 ))
    sec=$(( $1 % 60 ))
    printf "%02d:%02d" "$min" "$sec"
}

timer() {
    TIME=$1
    LABEL=$2
    SECONDS_PER_MINUTE=60
    TOTAL_SECONDS=$(( TIME * SECONDS_PER_MINUTE ))

    notify-send "$LABEL!"

    I=1
    while [ "$I" -le "$TOTAL_SECONDS" ]; do
        if [ "$(cat /tmp/pom_enable.txt 2>/dev/null)" != "1" ]; then
            echo "no timer" > /tmp/pomo_status.txt
            return
        fi
        sleep 1
        TIME_LEFT=$(( TOTAL_SECONDS - I ))
        echo "$LABEL $(format_time "$I") | $(format_time "$TOTAL_SECONDS")" > /tmp/pomo_status.txt
        I=$(( I + 1 ))
    done

    notify-send "Timer Done!"
}

# Load or initialize pomodoro count
if [ -f /tmp/pom_count.txt ]; then
    COUNT=$(cat /tmp/pom_count.txt)
else
    COUNT=0
fi

# Ensure status file exists
if [ ! -f /tmp/pomo_status.txt ]; then
    echo "no timer" > /tmp/pomo_status.txt
fi

case "$1" in
    0)
        echo "0" > /tmp/pom_enable.txt
        echo "no timer" > /tmp/pomo_status.txt
        echo "timer stopped"
        ;;
    1)
        echo "1" > /tmp/pom_enable.txt
        while [ "$(cat /tmp/pom_enable.txt)" = "1" ]; do
            timer 55 "Study"
            if [ "$COUNT" -eq 4 ]; then
                COUNT=0
                timer 15 "Break"
            else
                COUNT=$(( COUNT + 1 ))
                timer 5 "Break"
            fi
            echo "$COUNT" > /tmp/pom_count.txt
        done
        ;;
    2)
        cat /tmp/pomo_status.txt
        ;;
    *)
        echo "Usage: $0 {0|1|2}"
        ;;
esac

