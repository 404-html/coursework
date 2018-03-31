cat /afs/inf.ed.ac.uk/group/teaching/exc/ex2/part3/webLarge.txt \
  | parallel --pipe python ~/Desktop/EXC-CW2-s1413557/task7/computehash.py -n 1897987 \
  | python ~/Desktop/EXC-CW2-s1413557/task7/bloom.py -n 1897987
