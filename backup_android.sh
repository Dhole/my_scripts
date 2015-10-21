#! /bin/sh

IP=192.168.2.146
DEST=/media/data0/moto_G/
INTERNAL=/sdcard/
FOLDERS="{afwall,DCIM,Android,osmdroid,Plumble,osmand,WhatsApp,Telegram,Pictures,tomdroid,00001.vcf}"

rsync -avurt --delete \
    --exclude=*cache* \
    --exclude=*RIL_offline* \
    --exclude=*thumbnails* \
    --exclude=*WhatsApp/Media* \
    --exclude="*WhatsApp/Profile Pictures*" \
    --exclude=*.obf \
    shell@$IP:$INTERNAL$FOLDERS $DEST
