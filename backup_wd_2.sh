#! /bin/bash

# Backup my important folders into the mounted external backup drive

rsync -avurt --delete /media/data1/Imatges/ /media/blue/wd_ext/backup/Imatges/
rsync -avurt --delete /media/data1/Documents/ /media/blue/wd_ext/backup/Documents/
rsync -avurt --delete /media/data1/Photos /media/blue/wd_ext/backup/Photos/
