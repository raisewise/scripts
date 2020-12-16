#!/bin/sh

### Platform
# portal	 = pt = ptl
# common	 = pc = com
# hotel		 = ht = htl
# flight	 = ar = air
# calculate	 = st = stt
# package	 = pk = pkg
# information	 = dw = dws
# channel	 = ch = chn
# hanasam	 = ha = han
# gnis		 = gl = glb
# security	 = sc = sec
# hanahub	 = hb = hab
# customer	 = cs = csi
# call		 = ca = hcs
# infra		 = in = int

### 
HOSTNAME=`hostname`
PLATFORM=${HOSTNAME:0:2}
SERVICE=${HOSTNAME:2:3}
PURPOSE=${HOSTNAME:5:1}
ENV=${HOSTNAME:6:1}
DISK=`fdisk -l | grep sdb | awk '{print $2}'`
#DISK=fdisk -l | grep Disk | awk '{print $2}' | grep '/dev/sd[b-z]'
IP=`ifconfig | grep 'inet 10' | awk '{print $2}' | awk -F. '{print $2}'`

### template quit ###
if [ $HOSTNAME = "intemplate" ]
then
	exit 1
fi

### Add User ###
case ${PLATFORM} in
	pt)
		useradd ptl${SERVICE}01;;
	pc)
		useradd com${SERVICE}01;;
	ht)
		useradd htl${SERVICE}01;;
	ar)
		useradd air${SERVICE}01;;
	st)
		useradd stt${SERVICE}01;;
	pk)
		useradd pkg${SERVICE}01;;
	dw)
		useradd dws${SERVICE}01;;
	ch)
		useradd chn${SERVICE}01;;
	ha)
		useradd han${SERVICE}01;;
	gl)
		useradd glb${SERVICE}01;;
	sc)
		useradd sec${SERVICE}01;;
	hb)
		useradd hab${SERVICE}01;;
	cs)
		useradd csi${SERVICE}01;;
	ca)
		useradd hcs${SERVICE}01;;
	in)
		useradd inf${SERVICE}01;;
esac

### Add Parition ###
if [ $DISK ]
then
	pvcreate /dev/sdb
	vgcreate vgdata1 /dev/sdb
	lvcreate -n lvol1 -l 100%FREE vgdata1
	mkfs.xfs /dev/mapper/vgdata1-lvol1
	echo -e '/dev/mapper/vgdata1-lvol1\t/hntsw\t\txfs\tdefaults\t0 0' >> /etc/fstab
	mkdir /hntsw
	mount -a
	mkdir /hntsw/logs
	mkdir /hntsw/contents
	mkdir /hntsw/deploy
	chown -R wasadm. /hntsw
	chown cmadm. /hntsw/deploy
	ln -s /hntsw/logs -s /hntlogs
	ln -s /hntsw/contents -s /hntdata
	ln -s /hntsw/deploy -s /hntap
fi

### Change Zabbix agent server ###
if [ $IP = "100" ]
then
	sed -i -e 's/10.200.27.25/10.30.101.101/g' /etc/zabbix/zabbix_agentd.conf
	systemctl restart zabbix-agent
	rhnreg_ks --serverUrl=http://10.100.30.143/XMLRPC --activationkey=1-centos7masterkey --force
fi

###
sed -i -e '14d' /etc/rc.d/rc.local
rm -rf /root/hana_setting.sh
