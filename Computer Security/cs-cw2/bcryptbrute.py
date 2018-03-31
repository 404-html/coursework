#!/usr/bin/python

import sys
import bcrypt

password = "123456"

count = 0

fn = open("/afs/inf.ed.ac.uk/user/s14/s1413557/Desktop/rockyou-samples.bcrypt.txt")

for i, line in enumerate(fn):
	line = line.strip()

	if count == 5:
		break
	if bcrypt.hashpw(password, line) == line:
		print i
		count += 1
