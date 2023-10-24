#!/bin/bash

cd /path/to/python/script/directory
python myscript.py $1 $2 $3

import sys

print("Argument 1:", sys.argv[1])
print("Argument 2:", sys.argv[2])
print("Argument 3:", sys.argv[3])
