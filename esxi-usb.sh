#!/bin/sh

echo -e "DEVICE : \c "
read -a DEVICE

ESXI_IMAGE=/media
USB_MOUNT=/mnt

echo -e 'd\nn\n\n\n\n\nt\nc\na\nw' | fdisk $DEVICE
sleep 5
sync
sleep 5
mkfs.vfat -F 32 -n USB $DEVICE'1'
sleep 5
sync
sleep 5

/usr/bin/syslinux $DEVICE'1'
sleep 5
cat `find /usr/ -name 'mbr.bin'` > $DEVICE
sleep 5

mount $DEVICE'1' $USB_MOUNT
cp -a $ESXI_IMAGE/* $USB_MOUNT

mv $USB_MOUNT/isolinux.cfg $USB_MOUNT/syslinux.cfg
sed -i -e 's/menu.c32/mboot.c32/g' $USB_MOUNT/syslinux.cfg
sed -i -e 's/APPEND -c boot.cfg/APPEND -c boot.cfg -p 1/g' $USB_MOUNT/syslinux.cfg

umount $USB_MOUNT
