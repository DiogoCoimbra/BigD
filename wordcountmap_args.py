#!/usr/bin/python
import sys

TAB_CHAR = '\t'


arg1 = int(sys.argv[1])
arg2 = int(sys.argv[2])

for line in sys.stdin:
    for token in line.strip().split(" "):
        if token: 
            print(token + TAB_CHAR + str(arg1*arg2))
