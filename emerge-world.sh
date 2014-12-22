#! /bin/bash

# Script to perform weekly update upon user confirmation. Intended to be executed by cron

export DISPLAY=:0

echo "Starting emerge sync, update..."

sudo emerge --sync
sudo emerge -av --update --deep --with-bdeps=y --newuse world

$SHELL
