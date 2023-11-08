#!/bin/bash

# I will use boolian operator(true/false)
username="$1"


if [[ $UID == 0 ]] || sudo -lU $username |grep -q "(ALL : ALL)";
then
	echo "Hey $username you have sudo privileges"
else
	echo "$username enjoy without sudo access"
fi




