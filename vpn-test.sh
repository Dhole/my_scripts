#! /bin/sh

kill_vpn() {
	while [ `pgrep openvpn` ]
	do
		pkill openvpn
		sleep 4
	done
}

test_con() {
	while [ 1 == 1 ]
	do
		ping -c 3 8.8.8.8 > /dev/null 2>&1
		if [ "$?" == "0" ]
		then
			break
		fi
	done
}

kill_vpn

if [ `whoami` != "root" ]
then
	echo "Run this script as root"
	exit 1
fi

for VPNCONF in /home/black/VPN/*.ovpn
do
	echo ""
	echo -e "\t$VPNCONF"
	echo ""
	openvpn $VPNCONF > /dev/null 2>&1 &
	sleep 8
	test_con
	sudo -u black speedtest-cli
	kill_vpn
done
