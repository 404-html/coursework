#!/usr/bin/python

import sys

size = 0
token = 0

for line in sys.stdin:

	line = line.strip()
	size = len(line)
	token = len(line.split())

	print("{0}\t{1}".format(size,token))
