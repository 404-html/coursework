def checkPrefix(lst, prefix):
    for i in lst:
        if i[:2]==prefix:
            print "*", i[:2], i
        else:
            print "-", i[:2], i
