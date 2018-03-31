#!/usr/bin/python

import sys

prevword = ""
count = 0
output = ""

for line in sys.stdin:

	line = line.strip()
	word, fiel, filenum, wcount = line.split()

	if word == prevword:
		
		#cat : 2 : {(d1.txt, 2), (d2.txt, 3)}
		#     ^
		#      \-- this whitespace became a tab sometimes?
		count += 1
		output += ", ({0}, {1})".format(fiel,wcount)

	else:

		if count != 0:
			print("{0} : {1} : {{{2}}}".format(prevword,count,output))

		prevword = word
		count = 1
		output = "({0}, {1})".format(fiel,wcount)

#lastline
if count != 0:
	print("{0} : {1} : {{{2}}}".format(prevword,count,output))
