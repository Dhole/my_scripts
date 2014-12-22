#¡/bin/bash

# Mount luks ciphered storage and get a shell inside the folder
# Probably not the best way to do this

CURRENT_PWD=`pwd`
sudo losetup /dev/loop1 ../lvl
sudo cryptsetup luksOpen /dev/loop1 lvl
sudo mount /dev/mapper/lvl /mnt/nya
cd /mnt/nya/lvl
sudo bash
cd $CURRENT_PWD
sleep 2
sudo umount /mnt/nya
sudo cryptsetup luksClose lvl
sudo losetup -d /dev/loop1
echo "Listing files in /mnt/nya"
ls /mnt/nya
