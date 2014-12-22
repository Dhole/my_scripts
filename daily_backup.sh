#! /bin/bash

# Daily backup script

mount -l | grep /media/wd-160-backup > /dev/null
if [ $? != 0 ] ; then
	lvm lvchange -aly vg-wd-160/backup
	if [ ! -d /media/wd-160-backup ] ; then
		mkdir /media/wd-160-backup
	fi
	mount /dev/vg-wd-160/backup /media/wd-160-backup/
fi

ls /media/wd-160-backup/Imatges/ /media/wd-160-backup/Documents/ > /dev/null
if [ $? != 0 ] ; then
	echo "There is some error with backup partition"
	exit 1
fi

rdiff-backup /media/data1/Documents/ /media/wd-160-backup/Documents/
rdiff-backup /media/data1/Imatges/ /media/wd-160-backup/Imatges/
