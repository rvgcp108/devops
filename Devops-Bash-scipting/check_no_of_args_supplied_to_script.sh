#!/bin/bash

# Check , if no of argument provided 3 to this script

# $# is use to calculate no of argument supplied to the script
# $0 means this scipt

if [[ $# -lt 3 ]]; then
	echo "Usage: $0 <age>  <name> <country>"
	exit 1
fi

age=$1
name=$2
country=$3

if [[ $age -gt 18 ]] && [[ $name == $name ]] && [[ $country == "India" ]]; then
	echo "$name is adult you can stay for some day in $country"
else
	echo "$name get out from $country"
fi

