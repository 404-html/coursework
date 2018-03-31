#!/usr/bin/python

import sys

studentnum = -1
classlist = []
space ="   "
sep = "\t"

for line in sys.stdin:

	line = line.strip()
	typu, idee, tael = line.split(sep,2)
	
	if typu == 'student':

		if len(classlist)>1:

			classes = space.join(classlist)
			print("{0}-->{1}".format(studentnum,classes))

		studentnum = idee
		classlist = []

	else:
		
		classname, score = tael.split(sep,1)
		classlist.append("({0},{1})".format(score,classname))
		
if len(classlist)>0:
	classes = space.join(classlist)
	print("{0}-->{1}".format(studentnum,classes))
