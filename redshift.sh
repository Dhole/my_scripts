#! /bin/sh
# disable with redshift -x

LOC=40.4163798:-3.6967864

export DISPLAY=:0.0

redshift-gtk -l ${LOC} &
