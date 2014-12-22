#! /bin/bash

# Kindle comic adapter (cbr2cbz)
# Converts comics in .cbr or cbz file format into cbz resizing all the images
# to 600x800 and rotating the landscape ones for use in Kindle

CURRENT=$(pwd)

find `pwd` -type d | while read line1; do
	echo "$line1"
	cd "$line1"
	
	ls | grep .cbz | while read line2; do
		mkdir tmp
		echo $line2
		unzip "$line2" -d tmp
		cd tmp
		#Trobar imatges que s'han de rotar
		find -name "*png" | while read line3; do
			convert "$line3" "${line3%png}jpg"
			rm "$line3"
		done
		find -name "*jpg" | grep [0-9]-[0-9] | while read line3; do
			jpegtran -outfile "$line3" -rot 90 "$line3"
		done
		find -name "*jpg" | while read line3; do
			mogrify -resize '600x800>' "$line3"
		done
		rm ../"$line2"
		FILENAME=$(echo -n "$line2" | sed 's/.cbr/.cbz/')
		zip -r "$FILENAME" *
		mv "$FILENAME" ../
		cd ..
		rm -rf tmp
	done
	
	ls | grep .cbr | while read line2; do
		unrar e "$line2" tmp/
		cd tmp
		#Trobar imatges que s'han de rotar
		find . -name "*png" | while read line3; do
			convert "$line3" "${line3%png}jpg"
			rm "$line3"
		done
		find . -name "*jpg" | grep [0-9]-[0-9] | while read line3; do
			jpegtran -outfile "$line3" -rot 90 "$line3"
		done
		find . -name "*jpg" | while read line3; do
			mogrify -resize '600x800>' "$line3"
		done
		rm ../"$line2"
		FILENAME=$(echo -n "$line2" | sed 's/.cbr/.cbz/')
		zip -r "$FILENAME" *
		mv "$FILENAME" ../
		cd ..
		rm -rf tmp
	done
	
	cd $CURRENT
done

