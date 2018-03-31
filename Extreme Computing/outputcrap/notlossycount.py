#!/usr/bin/python

import sys
import math
import mmh3
from bitarray import bitarray

if (len(sys.argv)) != 3:
	print("Usage: notlossy.py -p \"percentage\"")
	sys.exit()

if (sys.argv[1] != "-p"):
	print("Usage: notlossy.py -p \"percentage\"")
	sys.exit()

#Get n from input
try:
	p = float(sys.argv[2])
except ValueError:
	print("Usage: notlossy.py -p \"percentage\"")
	sys.exit()

d = dict()
count = 0

for line in sys.stdin:
	line = line.strip()
	count += 1
	if line in d.keys():
		d[line] += 1
	else:
		d[line] = 1

accept = int(count*p)
for k in d.keys():
	if d[k] > accept:
		print(k)
