#!/usr/bin/python

import sys

prevline = ""
count = 0

for line in sys.stdin:
	
	line = line.strip()

	if line == prevline:

		count += 1

	else:

		if count != 0:
			print("{0} {1}".format(prevline,count))

		prevline = line
		count = 1

#lastline
if count != 0:
	print("{0} {1}".format(prevline,count))
