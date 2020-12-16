#!/bin/sh

/usr/bin/echo '/usr/bin/mount -o loop /dev/sr0 /mnt' >> /etc/rc.local
/usr/bin/chmod 755 /etc/rc.d/rc.local

/usr/bin/sed -i -e 's/SELINUX=disabled/SELINUX=enforcing/g' /etc/selinux/config
/usr/bin/systemctl start NetworkManager
/usr/bin/systemctl enable NetworkManager
/usr/sbin/reboot
