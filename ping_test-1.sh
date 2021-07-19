#!/bin/sh

usage() {
    echo "ping test..."
    echo " "
    echo "Usage: ping_test.sh [OPTION]"
    echo "OPTION : "
    echo "      -a      all ip number ping"
    echo " "
    echo "      -n      input ip number ping"
    echo " "
    echo "      -h      display this help and exit"
    exit 0
}


###INPUT ADDR ###

echo " "
echo "IP ADDR INFO"
echo "`ip a | grep -w inet | grep -v 127 | awk '{print $2}' | awk -F/ '{print $1}'`"
echo " "
FIRST=($(ip a | grep -w inet | grep -v 127 | awk '{print $2}' | awk -F/ '{print $1}' | awk -F. '{print $1}'))
SECOND=($(ip a | grep -w inet | grep -v 127 | awk '{print $2}' | awk -F/ '{print $1}' | awk -F. '{print $2}'))
THIRD=($(ip a | grep -w inet | grep -v 127 | awk '{print $2}' | awk -F/ '{print $1}' | awk -F. '{print $3}'))

echo -e "LAST IP NUMBER (blank - 1..254) : \c "
read -a LAST
echo -e "COUNT NUMBER : \c "
read -a COUNT

### ARRAY LENGTH ###

first_length=${#FIRST[*]}
second_length=${#SECOND[*]}
third_length=${#THIRD[@]}
last_length=${#LAST[@]}


### CHECK RESULTS ###

if [ "$LAST" != " " ]
	for ((a=0 ; a <= $first_length-1 ; a++))  
		do
		for ((b=0 ; b <= $last_length-1 ; b++)) 
		do
			ping -c $COUNT ${FIRST[$a]}.${SECOND[$a]}.${THIRD[$a]}.${LAST[$b]}
		done 
	done
then
	for ((a=0 ; a <= $first_length-1 ; a++))  
		do
		for b in {1..254} 
		do
			ping -c $COUNT ${FIRST[$a]}.${SECOND[$a]}.${THIRD[$a]}.$b
		done 
	done
fi

while getopts "anecutivCsdrMSVhUl" opt
do
        case $opt in
            a)  initialize_all
                ;;
	    c)
		echo "count"
		echo -e "COUNT NUMBER : \c "
		read -a COUNT
		;;
            n)
                echo "ping test"
#		echo -e "LAST IP NUMBER (blank - 1..254) : \c "
#		read -a LAST
#                echo -n "root's password: "
#                read -s passwd
                echo " "
                initialize_node
                ;;
            h)  usage
                ;;
        esac
done
