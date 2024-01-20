#!/bin/bash
echo -n "Enter first number: "
read NUM1
echo -n "Enter second number: "; 
read NUM2
echo
echo -e "The first number is $NUM1, second number is $NUM2.\n"
TEMP=$NUM1
NUM1=$NUM2
NUM2=$TEMP
echo -e "The numbers are swapped. First number is $NUM1 second number is $NUM2.\n"
exit 0
