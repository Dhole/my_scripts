#! /bin/sh

SLEEP_TIME=5   # Default time between checks.
SAFE_PERCENT=30  # Still safe at this level.
DANGER_PERCENT=16  # Warn when battery at this level.
CRITICAL_PERCENT=8  # Suspend when battery at this level.

export DISPLAY=:0.0

notify() {
        notify-send -u critical "Battery level is low: $1%<br>Suspending soon..."
}

while [ true ]; do

    state=$(acpi -b | grep -i discharging)
    if [ "$state" != "" ]; then
        rem_bat=$(acpi -b | grep -Eo "[0-9]+%" | grep -Eo "[0-9]+")

        if [ $rem_bat -gt $SAFE_PERCENT ]; then
            SLEEP_TIME=10
        else
            SLEEP_TIME=5
            if [ $rem_bat -le $DANGER_PERCENT ]; then
                SLEEP_TIME=2
                notify $rem_bat
            fi
            if [ $rem_bat -le $CRITICAL_PERCENT ]; then
                SLEEP_TIME=1
                systemctl suspend &
            fi
        fi
    else
        SLEEP_TIME=10
    fi

    sleep ${SLEEP_TIME}m

done
