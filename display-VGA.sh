#!/bin/sh

if xrandr -q | grep "VGA-1 connected"; then
    xrandr --output LVDS-1 --auto
    xrandr --output VGA-1 --auto --above LVDS-1
    pkill -9 -f redshift
    ~/bin/wall.sh &
    ~/bin/redshift_2screen.sh &
fi
