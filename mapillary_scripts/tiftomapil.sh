cd /mnt/usb/rawdata/00-0e-64-08-1e-39/master/1460401040/segment/1462366612/panos/
for i in `ls result_1462368{169..211}_*.tif`
do

convert -level 0%,25%,1 /mnt/usb/rawdata/00-0e-64-08-1e-39/master/1460401040/segment/1462366612/panos/"$i" -define jpeg:extent=20000kb /home/lukas/alsenet/panos/panos6/`basename $i .tif`.jpg
done