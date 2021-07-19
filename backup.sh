#!/bin/sh

### INFO ###
echo -e "username : \c "
read -a USER
echo -e "password : \c "
stty -echo
read -a PASS
stty echo
HOSTNAME=`hostname | awk -F. '{print $1}'`
DATE=`date +%Y%m%d`
LXC_PATH="/var/lib/lxc/"
CONTAINER=($(lxc-ls -1))
CONTAINER_COUNT=${#CONTAINER[*]}
BACKUP="/backup/config/$HOSTNAME-$DATE/"

#mkdir -p $BACKUP

### auto scp ###
expect <<END
spawn ssh $USER@172.16.80.131 hostname
expect "password"
send "$PASS\r"
expect eof
END
