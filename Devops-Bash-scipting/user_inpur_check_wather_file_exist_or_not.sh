#!/bin/bash

#filename="$1"
# ! -e means not exist

read -p "Please enter file name: " name
read -p "Enter path to search file : " path

findfile=`find $path/ -name $name -type f|grep -v 'find'` 
if [[ ! -e $findfile ]]; then
	echo "$name does't exist in the system"
else
	echo "$name is located $findfile"
fi
