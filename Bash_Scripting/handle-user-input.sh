#!/bin/bash

#Ref:https://linuxconfig.org/bash-script-flags-usage-with-arguments-examples

# Prompt the user for their age and store it in a variable
read -p "Please enter your age: " age

# Validate the input to ensure that it is a positive integer
if [[ "$age" =~ ^[0-9]+$ && "$age" -gt 0 ]]; then
    echo "Your age is $age."
else
    echo "Error: Invalid age input."
    exit 1
fi
