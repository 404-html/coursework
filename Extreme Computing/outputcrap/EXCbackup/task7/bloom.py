#!/usr/bin/python

import sys
import math
import mmh3
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

print("n is {0}".format(n))
print("m is {0}".format(m))
print("k is {0}".format(k))

#Initialize the array

a = bitarray(m)
a.setall(False)

count = 1

for line in sys.stdin:

	line = line.strip()

	hasu = []
	for k in key:
		hasu.append(mmh3.hash(line+k, signed=False) % m)

	#Check if it's there	
	present = True
	for h in hasu:
		present = present and a[h]
	if present:
		#print("Damn, line {0} is probabaly there.".format(count))
	else:
		#print("meh, no line {0}.".format(count))
				
		print(line)
		print(hasu)
		#for h in hasu:
		#	a[h] = 1

	count += 1

