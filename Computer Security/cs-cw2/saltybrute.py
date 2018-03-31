#!/usr/bin/python

import sys
import hashlib

passwords = ["123456","12345","123456789","password","iloveyou",
			"princess","1234567","rockyou","12345678","abc123",
			"nicole","daniel","babygirl","monkey","lovely",
			"jessica","654321","michael","ashley","qwerty",
			"111111","iloveu","000000","michelle","tigger"]

fn = open("/afs/inf.ed.ac.uk/user/s14/s1413557/Desktop/rockyou-samples.sha1-salt.txt")
mah_dic = dict()

for i, line in enumerate(fn):
	line = line.strip()
	tokens = line.split('$')
	for p in passwords:
		hl = hashlib.sha1()
		hl.update(tokens[2] + p)
		if hl.hexdigest() == tokens[3]:
			if p in mah_dic:
				mah_dic[p] += 1
			else:
				mah_dic[p] = 1

for some, fuk in mah_dic.items():
	print(str(fuk) + "," + some)
