#!/usr/bin/python

import sys
import xml.etree.ElementTree as ET

for line in sys.stdin:
	line = line.strip()
	row = ET.fromstring(line)

	if row.attrib['PostTypeId'] == "2": #If its an answer
		print("{0} {1} {2} {3}".format(row.attrib['ParentId'], row.attrib['PostTypeId'], row.attrib['Id'], row.attrib['OwnerUserId']))

	if row.attrib['PostTypeId'] == "1": #If its a question
		if 'AcceptedAnswerId' in row.attrib:
			print("{0} {1} {2} {3}".format(row.attrib['Id'], row.attrib['PostTypeId'], row.attrib['AcceptedAnswerId'], row.attrib['OwnerUserId']))
