#!/bin/bash

file_path="/tmp"
#methond1
for file in $( ls $file_path/*.txt );do mv -v $file ${i%.txt}.csv;done

#methond2
#find . -depth -name "[current file name element]" -exec sh -c 'f="{}"; mv -- "$f" "${f%[current file name element]}[new file name element]"' \;

#Example:  find . -depth -name "*.txt" -exec sh -c 'f="{}"; mv -- "$f" "${f%.txt}.pdf"' \;



