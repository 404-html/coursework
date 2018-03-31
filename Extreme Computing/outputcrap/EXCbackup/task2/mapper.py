#!/usr/bin/python

import sys
import xml.etree.ElementTree as ET

for line in sys.stdin:
	line = line.strip()
	row = ET.fromstring(line)
	if row.attrib['PostTypeId'] == "1": #If its a question
		print("{0} {1}".format(row.attrib['ViewCount'], row.attrib['Id']))
