#!/usr/bin/python

import sys

questionid = ""
answerid = ""

for line in sys.stdin:

	line = line.strip()

	if line == "":
		continue

	quesid, typu, ansid, user = line.split()

	if typu == "1":
		questionid = quesid
		answerid = ansid
	else:
		if ansid == answerid:
			print("{0} {1}".format(user, quesid))
