#! /bin/bash

# Script to perform weekly update upon user confirmation. Intended to be executed by cron
# Argument 1 is the command to run in a konsole

export DISPLAY=:0

kdialog --yesno "Emerge world scheduled" --yes-label "Continue" --no-label "Cancel"

if [ $? -eq 1 ]; then
    exit 1;
else
    echo "Emerging the world..."
    konsole -e $1
fi
