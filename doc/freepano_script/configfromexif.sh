#!/bin/bash
# configfromexif.sh
# To work please copy into the bin forlder of the freepano project
usage() {
  echo 'usage: configfromexif  <Website Folder> <Input Folder with Images>'
  exit 1
}
if [ ! -e "$1/js/main.js" ]; then
 usage
fi

if [ ! -e "$2"/*.jpeg ]; then
 usage
fi
scdir=$(cd $(dirname $0) ; pwd -P)
pwd=$(pwd)
wdir=$(echo /tmp/configfexif)
mkdir $wdir
echo //next serie > $wdir/out.txt

declare -a files=("${@:2}"/*)
for(( i= 0; i < ${#files[*]}; ++ i ))
do

(cd $wdir ; $scdir/pyramid.sh -l 3 512 $pwd/${files[$i]})

 lat=$(exiftool -s3 -n -gpslatitude "${files[$i]}")
 lon=$(exiftool -s3 -n -gpslongitude "${files[$i]}")
 dir=$(basename ${files[$i]} .jpeg)
 pdir=$(basename ${files[$i-1]} .jpeg)
 ndir=$(basename ${files[$i+1]} .jpeg)
 name=$(echo "$dir" | sed -e 's/-[^ ]*$//' -e 's/^[^_]*\_//')
 nname=$(echo "$ndir" | sed -e 's/-[^ ]*$//' -e 's/^[^_]*\_//')
 pname=$(echo "$pdir" | sed -e 's/-[^ ]*$//' -e 's/^[^_]*\_//')
mv $wdir/$dir/512/3 $1/panoramas/$dir
 echo "     '$name': {
            dirName: 'panoramas/$dir',
            coords: {
              lon: $lon,
              lat: $lat,
            },
	    arrow: {
              list: {
                0: {
                  coords: {
                    lon: -180,
                    lat: -4
                  },
                  target: '$nname'
                },
                1: {
                  coords: {
                    lon: -0,
                    lat: -24
                  },
                  target: '$pname'
                }
              }
            }
          },

">> $wdir/out.txt
done
 sed -i "428r $wdir/out.txt" $1/js/main.js
#echo Please copy out.txt into $1js/main.js

rm -r $wdir
