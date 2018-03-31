#!/usr/bin/python

import sys
import string
import hashlib

strings = ["hahaf","boobs","vagen","420ad","liisa","frank"]
fuck = hashlib.md5()

for s in strings:
	fuck = hashlib.md5()
	fuck.update(s)
	print fuck.hexdigest()
