#!/usr/bin/env bash
for i in $@ 
do
	gdt=$(exiftool -s3 -GPSDateTime "$i")
	ssec=$(echo $gdt | sed 's/.*\(.\).$/\1/')

	exiftool -overwrite_original -DateTimeOriginal="$gdt" -SubSecTimeOriginal="$ssec" "$i"
done
