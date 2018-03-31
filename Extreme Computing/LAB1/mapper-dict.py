#!/usr/bin/python

import sys

# First load the dictionary.
english_words = set()
for line in file('dict.eng'):
    english_words.add(line[:-1])

for line in sys.stdin:
    for w in line.split():
        if w in english_words:
            print 'LongValueSum:%s\t1' % w
