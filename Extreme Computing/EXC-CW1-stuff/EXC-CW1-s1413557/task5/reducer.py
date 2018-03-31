#!/usr/bin/python

import sys

linecount = 0

for line in sys.stdin:

	if linecount < 25:
		
		line = line.strip()
		line, count = line.split("\t",1)
		print("{0}\t{1}".format(count,line))

	linecount += 1
