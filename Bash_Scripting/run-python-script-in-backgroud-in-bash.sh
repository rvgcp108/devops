#!/bin/bash

# Change to the directory containing the Python script
cd /path/to/python/script/directory

# Run the Python script in the background
nohup python myscript.py > /dev/null 2>&1 &
