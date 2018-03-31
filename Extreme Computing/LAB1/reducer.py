#!/usr/bin/python

from operator import itemgetter
import sys

prevWord = ""
valueTotal = 0
word = ""
# input from STDIN
for line in sys.stdin:

    line = line.strip()
    word, value = line.split('\t',1)
    value = int (value)
    # Remember that Hadoop sorts map output by key 
    # reducer takes these keys sorted
    if prevWord == word:
        valueTotal += value
    else:
        if prevWord:
            # write result to STDOUT
            print '%s\t%s' % (prevWord, valueTotal)
        valueTotal = value
        prevWord = word

if prevWord == word:
    print '%s\t%s' % (prevWord, valueTotal)

