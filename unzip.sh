#! /bin/bash

# Recursive unzip

CURRENT=$(pwd)

find `pwd` -type d | while read line1; do
	echo "$line1"
	cd "$line1"
	
	ls | grep *.zip | while read line2; do
		mkdir "${line2%.zip}"
		echo $line2
		unzip "$line2" -d "${line2%.zip}"
	done
	cd ..
done
