#!/bin/sh

OS=`uname -r | awk -F'.' '{print $(NF-1)}'`
TOTAL=`free | grep ^Mem | awk '{print $2}'`
USED1=`free | grep ^Mem | awk '{print $3}'`
USED2=`free | grep ^-/+ | awk '{print $3}'`
BUCA=`free | grep ^Mem | awk '{print $6}'`

case $OS in
	el7)
		ACTUAL=`echo "100*($USED1-$BUCA)/$TOTAL" | bc -l`
		echo ACTUAL=${ACTUAL:0:5}%
		;;
	el6)
		NOMINAL=`echo "100*$USED1/$TOTAL" | bc -l`
		ACTUAL=`echo "100*$USED2/$TOTAL" | bc -l`
		echo NOMINAL=${NOMINAL:0:5}% ACTUAL=${ACTUAL:0:5}%
		;;
esac
