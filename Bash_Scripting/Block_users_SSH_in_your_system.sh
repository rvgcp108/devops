#!/bin/bash

# No. of Counts 
count=1

# No. of Users Kicked from your device
kicked_users=0

# Get Username of the User
printf 'Welcome '
echo ''$USER

printf "Enter Delay in Seconds (Default Value is 1 Sec): "
read delay
	
# Check if user input is null.
# If null, then it will assign 1 as default to delay variable.
if [ -z $delay ]
then
	delay=1
fi

clear

while(true)
do
	echo ''
	echo 'Count = #'$count
	echo 'Kicked Users = #'$kicked_users
	who
	# Fires the who command and awk command extracts the last line from it.
	# rev command reverses the string and cuts it till it encounters the first opening parenthesis.
	# Then again reverse the string and again cut till closing parenthesis is encountered.
	# This method gets the ip address of the connected/logged in user. 
	ip="$( who | awk '/./{line=$0} END{print line}' | rev | cut -d '(' -f 1 | rev | cut -d ')' -f 1 )"
	
	# This is the regex (regular expression) pattern for validating ip address.
	# If a valid ip is found, the condition will be true and it will get the pid (process id) of the ssh process.
	# Then it will print the pid and kill the process.
	if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
	then
		output=$(pidof sshd)
		echo $output
		echo ""
		printf 'PID Of the Logged in User is : '
		x="$( echo $output | cut -d ' ' -f 1 )"
		echo $x
		kill -9 $x
		kicked_users=`expr $kicked_users + 1`
	fi
	sleep $delay;

	# Increase the count value
	count=`expr $count + 1`
done
# Different Ways to check if variable is null
	#if [ -z $delay ]
	#if [ $delay -eq  0 ]
	#if [ "$#" -eq "0" ]
	#if test -z "$delay" 

#wh0am1
