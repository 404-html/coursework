#!/usr/bin/python

import sys

prevline = ""
linecount = 0

#Basically same stuff in task 2
for line in sys.stdin:

    line = line.strip()
    if (prevline != line):
        if linecount > 0:
            print("{0}\t{1}".format(prevline,linecount))
        prevline = line
        linecount = 1
    else:
        linecount = linecount + 1

print("{0}\t{1}".format(prevline,linecount))
