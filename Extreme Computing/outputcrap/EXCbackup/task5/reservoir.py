#!/usr/bin/python

import sys
import random

keptlines = []
#keptks = []
count = 1
k = 100

#https://en.wikipedia.org/wiki/Reservoir_sampling

for line in sys.stdin:
	line = line.strip()

	if count >= 1 and count <= k:
		keptlines.append(line)
		#keptks.append(count)
	
	if count > k:
		j = random.randint(1,count)
		if j <= k:
			keptlines[j-1] = line
			#keptks[j-1] = count
			
	count += 1

for l in keptlines:
	print(l)
