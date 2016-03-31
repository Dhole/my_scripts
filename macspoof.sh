#! /bin/sh

MAC=$1
DEV=wlan0

sudo service network-manager stop
sudo ip link set dev $DEV down
if [ "$1" = "reset" ]
then
    sudo macchanger -p $DEV
elif [ "$1" = "kind" ]
then
    sudo macchanger -a $DEV
elif [ "$MAC" = "" ]
then
    sudo macchanger -A $DEV
else
    sudo macchanger -m $MAC $DEV
fi
sudo ip link set dev $DEV up
sudo service network-manager start

# To get a random mac after every resume, place a script +x at
# /lib/systemd/system-sleep/macspoof.sh
# Also it's a good idea to run this script after starting the session
