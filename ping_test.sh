#!/bin/sh

if [ -z $1 ]
then
	echo -e "\tex ) ./ping_test.sh 172.16.80"
else	
	for i in {1..254}
		do echo "ping $1.$i -c 1 &" >> $PWD/ping_list
	done

	sh $PWD/ping_list >> $PWD/ping_result

#	cat $PWD/ping_result | grep 'ttl=[0-9]'
	cat $PWD/ping_result | grep 'ttl=[0-9]' | awk '{print $4}' | awk -F: '{print $1}' >> use_ip

	for i in `cat $PWD/use_ip`
		do echo "nmap $i &" >> $PWD/nmap_run
	done

	sh $PWD/nmap_run >> $PWD/nmap_result
	sleep 30
	cat $PWD/nmap_result | grep -vE "Starting|Nmap done|^$"

	rm -rf $PWD/ping_list
	rm -rf $PWD/ping_result
	rm -rf $PWD/use_ip
	rm -rf $PWD/nmap_run
	rm -rf $PWD/nmap_result
fi
