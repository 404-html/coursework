#!/usr/bin/python

import sys
import os

absurdly_lengthy_path = os.environ["mapreduce_map_input_file"]
filename = absurdly_lengthy_path.strip().split('/')[-1]

#Just for proper sorting
filenum = filename.split('.')[0][1:]

for line in sys.stdin:
	
	line = line.strip()
	words = line.split()
	
	for word in words:

		print("{0} {1} {2}".format(word,filename,filenum))
		
		
