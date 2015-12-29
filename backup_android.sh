#! /bin/sh

set -x

init() {
    adb shell 'exec >/sdcard/rsyncd.conf && echo address = 127.0.0.1 && \
	echo port = 1873 && echo "[root]" && echo path = / && \
	echo use chroot = false && echo read only = false'
}

DEST=/media/data0/moto_G/
INTERNAL=/sdcard/
FOLDERS="afwall
DCIM
Android
osmdroid
Plumble
osmand
WhatsApp
Telegram
Pictures
tomdroid
00001.vcf"
#FOLDERS=DCIM

adb wait-for-device
adb shell 'killall rsync'
adb shell '/data/local/tmp/rsync --daemon --no-detach --config=/sdcard/rsyncd.conf' &
adb forward tcp:6010 tcp:1873
sleep 2

for FOLDER in ${FOLDERS}
do
    rsync -avurt --delete \
	--exclude=*cache* \
	--exclude=*RIL_offline* \
	--exclude=*thumbnails* \
	--exclude=*WhatsApp/Media* \
	--exclude=*WhatsApp/Profile\ Pictures* \
	--exclude=*.obf \
	--exclude=*BSD\ Now\ Mobile* \
	rsync://localhost:6010/root$INTERNAL$FOLDER $DEST$FOLDER
done

adb forward --remove tcp:6010
