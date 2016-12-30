#! /bin/sh
#set -e
#set -x

# disable with redshift -x

#Spain
#LOC=40.4163798:-3.6967864
# Germany
#LOC=52:13
# CA
LOC=35:-115

SLEEP_TIME=60

export DISPLAY=:0.0

while [ true ]; do
    redshift -m randr:crtc=0 -l ${LOC} -t 5500K:3700K -o
    redshift -m randr:crtc=1 -l ${LOC} -t 5000K:3700K -o
    sleep ${SLEEP_TIME}
done
