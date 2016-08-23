#!/bin/bash
for i in `ls $1`; do
n=$(echo "$i"| sed -e 's/-[^ ]*$//' -e 's/^[^_]*\_//')
b=$(echo "$n"| sed -e 's/..\_[^ ]*$//')
exiftool -overwrite_original -all= -tagsFromFile "$2"/"$b"/"$n"_1.jp4  -gps:all "$1"/"$i"
done