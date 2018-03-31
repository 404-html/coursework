#!/usr/bin/python

import sys

for line in sys.stdin:
	line = line.strip()
	tokens = line.split()
	
	for token in tokens:
		print("{0}\t{1}".format(token, 1))
