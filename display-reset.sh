#!/bin/sh

xrandr --output LVDS-1 --auto
xrandr --output HDMI-1 --off
xrandr --output VGA-1 --off
pkill -9 -f redshift
~/bin/redshift.sh &
