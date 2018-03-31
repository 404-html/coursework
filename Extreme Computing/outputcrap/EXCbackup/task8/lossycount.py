#!/usr/bin/python

import sys

#http://www.mathcs.emory.edu/~cheung/Courses/584-StreamDB/Syllabus/07-Heavy/Manku.html
theta = 0.01			#support frequency
epsilon = 0.1 * theta	#error frequency, (10% of theta)
window = int(1/epsilon)	#window size
n = 0 					#Number of processed item
bucket = dict()
bucketnum = 1			#Number of windows

#print(theta)
#print(epsilon)
#print(window)


for line in sys.stdin:

	line = line.strip()
	
	n += 1

	if line in bucket.keys():
		bucket[line] += 1
	else:
		bucket[line] = 1
	#BUCKET FULL!
	if (n % window) == 0:
		for k in bucket.keys():
			# f <= n * epsilon
			# f <= bucketnum * window * epsilon
			# f <= bucketnum * 1
			if bucket[k] <= bucketnum :
				#print("Remove freq {0} in bucketnum {1}".format(bucket[k], bucketnum))
				bucket.pop(k)
		bucketnum += 1
				
#print(len(bucket.keys()))
for k in bucket.keys():
	if bucket[k] > ((theta-epsilon) * n):
		print(k)
	
