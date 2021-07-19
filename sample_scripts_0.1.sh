#!/bin/bash
#
# Script for H/A Cluster
#

if [ -f /etc/init.d/functions ]; then
	. /etc/init.d/functions
else
	exit 0
fi

RETVAL=0
prog="Application"

start() {
	# Start daemon
	echo -n $"Starting $prog service: "
	logger Starting $prog Service...
        # /path/to/exec - options
	# daemon /path/to/application
	RETVAL=$?
	echo
	[ $RETVAL -eq 0 ] && touch /var/lock/subsys/$prog
	return $RETVAL
}

stop() {
	# Stop daemon
	echo -n $"Stopping $prog service: "
	logger Stopping $prog Service...
	killproc $prog
	RETVAL=$?
	echo
	[ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$prog
	return $RETVAL
}

# See how we were called.
case "$1" in
  start)
        start
        ;;
  stop)
        stop
	;;
  restart|reload)
	stop
	start
	RETVAL=$?
        ;;
  condrestart)
	if [ -f /var/lock/subsys/$prog ]; then
		stop
		start
		RETVAL=$?
	fi
        ;;
#  status)
#	status $prog
#	RETVAL=$?
#       ;;
  status)
	if [ -f /var/lock/subsys/$prog ]; then
		RETVAL=0
	else	
		RETVAL=3
	fi
        ;;
  *)
        echo $"Usage: $0 {start|stop|status}"
        exit 2
esac

exit $RETVAL 
