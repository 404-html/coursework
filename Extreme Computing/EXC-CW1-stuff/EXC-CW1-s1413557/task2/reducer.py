#!/usr/bin/python

import sys

prevline = ""
linecount = 0

for line in sys.stdin:

	line = line.strip("\n")

	#print only if prev line appeared only once
	if (prevline != line):
		if linecount == 1:
			print(prevline)
		prevline = line
		linecount = 1
	else:
		linecount = linecount + 1

#print last line, if unique..
if linecount == 1:
		print(prevline)
