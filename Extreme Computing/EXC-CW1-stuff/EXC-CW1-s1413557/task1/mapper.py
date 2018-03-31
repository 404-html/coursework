#!/usr/bin/python

import sys

for line in sys.stdin:
	
	#use strip to Remove trailing \n, Prevent double outputs
	print("{0}".format(line.strip().lower()))
