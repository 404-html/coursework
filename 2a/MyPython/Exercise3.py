L = ['how', 'why', 'however', 'where', 'never']
for i in L:
    if i[:2] == 'wh':
        print "*", i[:2],i
    else:
        print "-", i[:2],i
