#!/usr/bin/python

import sys
import numpy as np

wlist = []
prevline = ""

for line in sys.stdin:

	line = line.strip()
	tok1, tok2, tok3, tok4, count = line.split()
	line = tok1 + ' ' + tok2 + ' ' + tok3

	if line != prevline:
	
		if len(wlist) > 0:

			total = float(sum(wlist))
			for i in range(0,len(wlist)):
				wlist[i] = wlist[i]/total

			#print(wlist)
			entropy = sum(-w * np.log2(w) for w in wlist)
			print("{0}\t{1}".format(prevline, entropy))

		prevline = line
		wlist = []
		wlist.append(int(count))

	else:

		wlist.append(int(count))

#Lastline
if len(wlist) != 0:

	total = float(sum(wlist))
	for i in range(0,len(wlist)):
		wlist[i] = wlist[i]/total
	entropy = sum(-w * np.log2(w) for w in wlist)

	print("{0}\t{1}".format(prevline, entropy))
