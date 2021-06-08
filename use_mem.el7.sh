#!/bin/sh

TOTAL=`free | grep ^Mem | awk '{print $2}'`
USED=`free | grep ^Mem | awk '{print $3}'`
BUCA=`free | grep ^Mem | awk '{print $6}'`
ACTUAL=`echo "100*($USED-$BUCA)/$TOTAL" | bc -l`
echo ACTUAL=${ACTUAL:0:5}%
