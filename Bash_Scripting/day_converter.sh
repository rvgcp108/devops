#!/bin/bash

echo -e
echo "Convert number of days to weeks, months, years"
echo "##############################################"
echo "Enter number of days: " 
IFS= read -r days
year=$(echo "$days" / 365 | bc -l)
echo -e "The conversion to years is:$year"
week=$(echo "$days" / 7 | bc -l)
echo -e "The conversion to weeks is:$week"
month=$(echo "$days" / 30 | bc -l)
echo -e "The conversion to months is:$month"
echo -e
