#!/bin/sh

##To calculate the area, circumference and diameter of a circle##
echo -e "\n" 
echo  "###################################################"
echo  "To calculate the area and circumference of a circle"
echo  "###################################################" 
echo -e
echo -n "Enter the radius of the circle: "
IFS= read -r RADIUS
echo -n "The area of the circle is: "
AREA= expr 3.1415*$RADIUS*$RADIUS | bc
echo -n "The circumference of the circle is: "
CIRCUMF= expr 2*3.1415*$RADIUS | bc
echo -n "The diameter of the circle is: "
DIAM= expr 2*$RADIUS | bc
echo -e
