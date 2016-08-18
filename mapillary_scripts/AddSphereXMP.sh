#!/usr/bin/env bash
for i in $@ 
do
                 width=$(exiftool -s3 -ImageWidth "$i")
                 heigth=$(exiftool -s3 -ImageHeight "$i")
                 degrees=$(exiftool -s3 -GPSImgDirection "$i")

exiftool -overwrite_original -xmp:UsePanoramaViewer="True" -xmp:ProjectionType="equirectangular" -xmp:PoseHeadingDegrees="$degrees" -xmp:FullPanoWidthPixels="$width" -xmp:FullPanoHeightPixels="$heigth" -xmp:CroppedAreaImageWidthPixels="$width" -xmp:CroppedAreaImageHeightPixels="$heigth" -xmp:CroppedAreaLeftPixels="0" -xmp:CroppedAreaTopPixels="0"  "$i"

done
