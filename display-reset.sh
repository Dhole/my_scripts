#!/bin/sh

xrandr --output eDP1 --auto
xrandr --output DP1 --off
xrandr --output HDMI1 --off
pkill -9 -f redshift
~/bin/redshift.sh &
