#!/usr/bin/env bash
sd=$(dirname $0)
if test "$#" -ne 4; then
    echo "syntax: upload.sh FOLDER EMAIL USERNAME PASSWORD"
else
rename .jpeg .jpg $1/*
$sd/copygpstime.sh $1/*.jpg
python2 $sd/interpolate_direction.py $1 180
$sd/AddSphereXMP.sh $1/*.jpg
MAPILLARY_EMAIL=$2 MAPILLARY_USERNAME=$3 MAPILLARY_PASSWORD=$4 python2 $sd/add_mapillary_tag_from_exif.py $1
echo "Done Tagging, starting compression"
mogrify -define jpeg:extent=20000kb $1/*.jpg
echo "Done compressing press y to confirm upload"
read -n 1 -p "Input Selection:" mainmenuinput
  if [ "$mainmenuinput" = "y" ]; then
python2 $sd/upload.py $1
fi
fi
