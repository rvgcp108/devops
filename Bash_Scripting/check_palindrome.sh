#!/bin/bash -x

#->Problem Statement: Take a number from user and check if the number is a Prime then show that its palindrome is also prime.
#->Author: RajeshV
#->Date: 20Jan2024
#About Palindrome: ये ऐसे शब्द या कविता के रूप में होतेहैं जिनको उल्टा या सीधा किसी भी तरह से पढ़िए इसका मतलब वहीं होता है, जैसे-नवीन, डालडा आदि

echo -p "enter the number for checking"
num=$1
function checkingPrime ()
{
	flag=0
for (( i=2; i < $num; i++ ))
do 
	if [[ $num%$i -eq 0 ]]
	then
		((flag++))  
	fi 
done
	if [[ $flag -eq 0 ]]
	then 
		echo "it is prime number"
	else
		echo "it is not prime number"
	fi
}
function checkingPalindrome()
{
temp=$1
sum=0
while [[ $temp -ne 0 ]]
do
	id=$(( $temp % 10 ))
	sum=$(( $sum * 10 + $id ))
	temp=$(( $temp / 10 ))
done
checkingPrime $sum
}
checkingPrime
checkingPalindrome
