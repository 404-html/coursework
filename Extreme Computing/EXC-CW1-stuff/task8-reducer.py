#!/usr/bin/python

import sys

minscore = 9001
dummies = []

for line in sys.stdin:
	
	line = line.strip()

	studentnum, classes = line.split("-->",1)
	classes = classes.split()

	if len(classes) > 3:

		for i in range(0,len(classes)):
			#extract score
			classes[i], stuff = classes[i][1:].split(",",1)
			classes[i] = float(classes[i])
		
		average = sum(classes)/len(classes)

		if average < minscore:
			minscore = average
			dummies = []
			dummies.append(studentnum)
		elif average == minscore:
			dummies.append(studentnum)

if minscore == 9001:
	print("YOU GOT NO STUDENTS")
else:
	print("Student(s) have more than 3 classes but have lowest average: " + ", ".join(dummies))
	print("OUTRAGEOUS! They only got an average of: "+ str(minscore))
