#!/usr/bin/python

import sys

for line in sys.stdin:

	line = line.strip()
	token = line.split()
	length = len(token)

	if length > 3:
		for i in range(0, length-3):
			print("{0} {1} {2} {3}".format(token[i],token[i+1],token[i+2],token[i+3]))
