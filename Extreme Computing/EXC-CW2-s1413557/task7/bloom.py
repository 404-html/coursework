#!/usr/bin/python

import sys
import os
import math
from bitarray import bitarray

#Checking input arguments

if (len(sys.argv)) != 3:
	print("Usage: bloom.py -n \"num of lines\"")
	sys.exit()

if sys.argv[1] != "-n":
	print("Usage: bloom.py -n \"num of lines\"")
	sys.exit()

try:
	n = int(sys.argv[2])
except ValueError:
	print("Usage: bloom.py -n \"num of lines\"")
	print("num of lines must be an integer!")
	sys.exit()

#Calculates length of bitarray needed
#https://hur.st/bloomfilter?n=2000000&p=1.0E-2
# wants 0.01 FP rate
# 0.01 FP rate cause key always to be 7, use 7 fixed keys
# some random names

key = ['Arthur', 'Beau', 'Cerise', 'Destin', 'Erzulie', 'Forthigan', 'Gawain']
k = 7
p = 0.01
m = int(math.ceil((n * math.log(p)) / math.log(1.0 / (math.pow(2.0, math.log(2.0))))))
#k = int(round(math.log(2.0) * m / n))

# "Don't worry about the exact equations.
#           But deriving them is fun!"
#                       -- lecture slides

#print("n is {0}".format(n))
#print("m is {0}".format(m))
#print("k is {0}".format(k))

#Initialize the array

a = bitarray(m)
a.setall(False)

hasEmpty = False

for line in sys.stdin:

	line = line.strip()
	
	#Empty line case
	if len(line.split("\t")) == k:
		if not hasEmpty:
			for hasu in line.split("\t"):
				a[int(hasu)] = 1
			print("")
			hasEmpty = True
		continue

	hasu = ["","","","","","",""]
	hasu[0],hasu[1],hasu[2],hasu[3],hasu[4],hasu[5],hasu[6], line = line.split("\t",7)
	#Check if it's there	
	present = True
	for h in hasu:
		present = present and a[int(h)]
	if not present:
		print(line)
		for h in hasu:
			a[int(h)] = 1
		
with open('rawbloomfilter', 'wb+') as fh:
    a.tofile(fh)
