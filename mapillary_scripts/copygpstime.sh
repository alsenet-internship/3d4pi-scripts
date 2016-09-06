#!/usr/bin/env bash
for i in $@ 
do
	gdt=$(exiftool -s3 -GPSDateTime "$i")
	ssec=$(echo $gdt | sed 's/.*\(.\).$/\1/')
if [ -n "$gdt"  ]; then
 exiftool -overwrite_original -DateTimeOriginal="$gdt" -SubSecTimeOriginal="$ssec" "$i"
fi
done
