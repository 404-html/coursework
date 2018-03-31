#!/usr/bin/python

import sys

topbyte = 0
toptoken = 0

for line in sys.stdin:

	line = line.strip()

	byte, token = line.split("\t", 1)
	byte = int(byte)
	token = int(token)
	
	if byte > topbyte:
		topbyte = byte
	if token > toptoken:
		toptoken = token

print("{0} {1}".format(topbyte,toptoken))
