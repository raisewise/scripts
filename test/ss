#!/bin/sh

A=$1

for i in `cat /root/nodelist`
	do printf -- '-%.0s' $(seq `tput cols`); echo ""
	   echo "$i" ; 
	   ssh $i $A
done
printf -- '-%.0s' $(seq `tput cols`); echo ""
