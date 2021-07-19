#!/bin/sh

### INFO ###
echo -e "command : \c "
read -a COMMAND
echo -e "username : \c "
read -a USER
echo -e "password : \c "
stty -echo
read -a PASS
stty echo

### auto ssh ###
for i in {131..138} ;
	do
		expect <<END
		spawn ssh $USER@148.3.4.$i $COMMAND
		expect "password"
		send "$PASS\r"
		expect eof
		END ;
	done
