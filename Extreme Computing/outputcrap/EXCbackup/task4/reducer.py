#!/usr/bin/python

import sys
import random

keptline = ""
#keptlinenum = 0
count = 1

#thank you wikipedia
for line in sys.stdin:
	line = line.strip()
	
	intrand = random.randint(1,count)

	if intrand <= 1: #k = 1
		keptline = line
		#keptlinenum = count

	count += 1

if count != 1: #if it reads
	print(keptline)
	#print(keptlinenum)
