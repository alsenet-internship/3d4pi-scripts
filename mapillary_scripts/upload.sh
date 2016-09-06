#!/usr/bin/env bash
sd=$(dirname $0)
if [ "$#" -ne 4 ]  ; then
    echo "syntax: upload.sh FOLDER EMAIL USERNAME PASSWORD [sequence_id]"
else
rename .jpeg .jpg $1/*
$sd/copygpstime.sh $1/*.jpg #needed if time was not copied from original
$sd/correctgps $1
python2 $sd/interpolate_direction.py $1 180
$sd/AddSphereXMP.sh $1/*.jpg
 MAPILLARY_EMAIL=$2 MAPILLARY_USERNAME=$3 MAPILLARY_PASSWORD=$4 python2 $sd/add_mapillary_tag_from_exif.py $1  $5
echo "Done Tagging, starting compression"
for i in `ls $1`; do
size=$(wc -c <"$1/$i")
if [ $size -ge 20000000 ]; then
mogrify -define jpeg:extent=20000kb $1/$i
fi
done
echo "Done compressing press y to confirm upload"
read -n 1 -p "Input Selection:" mainmenuinput
  if [ "$mainmenuinput" = "y" ]; then
echo "no upload"
python2 $sd/upload.py $1
fi
fi
