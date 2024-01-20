#!/bin/bash -x
echo "program for leap year"
y=$1		#Command line Argument
if [[ ${#y[@]} -eq 4 ]]
then

	echo "invalid year"
elif [[ $y%4 -eq 0 && $y%100 -ne 0 || $y%400 -eq 0 ]]		#Condition for leap year
then 
	echo "the year is leap year" $y
else
	echo "it is not leap year"
fi
