#!/bin/bash

# Define a function to get user info
get_user_info() {
    read -p "Please enter your name: " name
    if [[ -z "$name" ]]; then
        echo "Error: Name cannot be empty"
        exit 1
    fi

    read -p "Please enter your age: " age
    if [[ "$age" =~ ^[0-9]+$ && "$age" -gt 0 ]]; then
        echo "Your age is $age."
    else
        echo "Error: Invalid age input."
        exit 1
    fi
}

# Call the function to get user info
get_user_info

# Display a greeting to the user
echo "Hello, $name! Welcome to my Bash script."
