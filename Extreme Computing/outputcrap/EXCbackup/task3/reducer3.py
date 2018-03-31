#!/usr/bin/python

import sys

count = 0

for line in sys.stdin:
	line = line.strip()
	
	if line != "":
		idee, useless, ans = line.split(";")
		if count < 10:
			print("{0} -> {1}".format(idee, ans))
		count += 1
