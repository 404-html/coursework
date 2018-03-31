#!/usr/bin/python

import sys

for line in sys.stdin:

	line = line.strip()
	token = line.split()
	sep = "\t"

	print(sep.join(token))
