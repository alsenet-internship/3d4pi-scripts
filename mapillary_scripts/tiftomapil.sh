for i in `ls /home/lukas/alsenet/panos/original/panos4`
do
n=$(basename "$i" -0-25-1.jpeg)
convert -level 0%,25%,1 /mnt/usb/rawdata/00-0e-64-08-1e-39/master/1460401040/segment/1462366612/panos/"$n".tif -define jpeg:extent=20000kb ./"$i"
done