#! /bin/sh
# disable with redshift -x

#Spain
#LOC=40.4163798:-3.6967864
# Germany
#LOC=52:13
# CA
LOC=35:-115

export DISPLAY=:0.0

redshift-gtk -l ${LOC} &
