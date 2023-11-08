#!/bin/bash

### Nahhi chal raha hai 
read -p "Please Enter your Name: " name
echo "Your Name is name $name"

read -p "Please provide your address: " address
echo "Your address is $address"

read -p "Please provide your Department name: " Department
echo "You work for $Department great"

read -s -p "Please Enter your password: " passwrd
read -s -p "Please Enter your password: " passwrd1
if [ $passwrd != $passwrd1 ]
then
	echo "You Entered Incorrect password"
fi

echo "****** Create $name user for $Department *******

