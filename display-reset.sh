#!/bin/sh

xrandr --output LVDS1 --auto
xrandr --output HDMI1 --off
xrandr --output VGA1 --off
pkill redshift
~/bin/redshift.sh &
