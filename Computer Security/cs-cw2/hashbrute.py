#!/usr/bin/python

import sys
import string
import hashlib

mah_dic = dict()
mah_sol = dict()
mah_hart = list(string.ascii_lowercase) + list(string.digits)
mah_tier = hashlib.md5()

for a in mah_hart:
	for b in mah_hart:
		#print("Creating List for: " + a + b + "***")
		for c in mah_hart:
			for d in mah_hart:
				for e in mah_hart:
					f = a+b+c+d+e
					mah_tier = hashlib.md5()
					mah_tier.update(f)
					mah_dic[mah_tier.hexdigest()] = f

fn = open("/afs/inf.ed.ac.uk/user/s14/s1413557/Desktop/rockyou-samples.md5.txt")
#fn = open("/afs/inf.ed.ac.uk/user/s14/s1413557/Desktop/shite.txt")
for i, line in enumerate(fn):
	line = line.strip()
	if line in mah_dic:
		pasw = mah_dic[line]
		if pasw in mah_sol:
			mah_sol[pasw] += 1
		else:
			mah_sol[pasw] = 1
for some, fuk in mah_sol.items():
	print(str(fuk) + "," + some)
