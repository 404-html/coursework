#!/usr/bin/python

import sys

count = 0

for line in sys.stdin:
	line = line.strip()
	if count < 10:
		print(line)
	count += 1
