#!/usr/bin/python

import sys

lastid = ""
lastques = ""
anscount = 0

for line in sys.stdin:

	line = line.strip()
	idee, ques = line.split()

	if idee == lastid:
		lastques += ", {0}".format(ques)
		anscount += 1
	else:
		if anscount > 0:
			print("{0};{1};{2}".format(lastid, anscount, lastques))
		lastid = idee
		lastques = ques
		anscount = 1

if anscount > 0:
	print("{0};{1};{2}".format(lastid, anscount, lastques))
