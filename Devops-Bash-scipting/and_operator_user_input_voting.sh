#!/bin/bash

#using AND operator , get user input for voting
read -p "Please Enter your name: " name
read -p "Please Enter your age: " age
read -p "Please Enter your Country: " country


if [[ $age -ge 18 ]] && [[ $country == "India" ]]
then
	echo "$name you are eligible for vote"
else
	echo "$name you can't vote"
fi
