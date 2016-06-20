# File: pos_tagging.py
# Template file for Informatics 2A Assignment 2:
# 'A Natural Language Query System in Python/NLTK'

# John Longley, November 2012
# Revised November 2013 and November 2014 with help from Nikolay Bogoychev
# Revised November 2015 by Toms Bergmanis and Shay Cohen


# PART B: POS tagging

from statements import *

# The tagset we shall use is:
# P  A  Ns  Np  Is  Ip  Ts  Tp  BEs  BEp  DOs  DOp  AR  AND  WHO  WHICH  ?

# Tags for words playing a special role in the grammar:

function_words_tags = [('a','AR'), ('an','AR'), ('and','AND'),
     ('is','BEs'), ('are','BEp'), ('does','DOs'), ('do','DOp'), 
     ('who','WHO'), ('which','WHICH'), ('Who','WHO'), ('Which','WHICH'), ('?','?')]
     # upper or lowercase tolerated at start of question.

function_words = [p[0] for p in function_words_tags]

def unchanging_plurals():
    nn = []
    nns = []
    nnnns = []
    with open("sentences.txt", "r") as f:
        for line in f:
            for w in line.split():
                word = w.split("|")[0]
                tag = w.split("|")[1]
                if (tag == "NN"):
                    if (not (word in nn)):
                        nn.append(word)
                elif (tag == "NNS"):
                    if (not (word in nns)):
                        nns.append(word)
    for w in nn:
        if w in nns:
            nnnns.append(w)
    return nnnns

#verb_stem is modified to accept verbs so i copied the part of verb_stem
#without the verb verification part
unchanging_plurals_list = unchanging_plurals()

def noun_stem (s):
    """extracts the stem from a plural noun, or returns empty string"""    
    if s[-3:] == "men":
            s = s[:-3] + "man"
    if (not (s in unchanging_plurals_list)):
        if (s == "has"):
            s = "have"
        else:
            if re.match(".*s", s):
                if re.match("(.|unt)ies", s):
                    s = s[:-1]
                elif re.match(".*(a|e|i|o|u)ies", s):
                    s = ""
                elif re.match(".*ies", s):
                    s = s[:-3]+"y"
                elif re.match(".*es", s):
                    if re.match(".*(o|x|ch|sh|ss|zz)es", s):
                         s = s[:-2]
                    else:
                        s = s[:-1]
                elif re.match(".*(a|e|i|o|u)ys", s):
                    s = s[:-1]
                elif re.match(".*(a|i|o|u|s|x|y|z|ch|sh)s", s):
                    s = ""
                else:
                    s = s[:-1]
    return s
     

def tag_word (lx,wd):
    """returns a list of all possible tags for wd relative to lx"""
    tags = []
    if wd in lx.getAll("P"):
        tags.append("P")
    if wd in lx.getAll("A"):
        tags.append("A")
    if noun_stem(wd) in lx.getAll('N'):
        if noun_stem(wd) == wd:
            tags.append("Ns")
            if wd in unchanging_plurals_list:
                tags.append("Np")
        else:
            tags.append("Np")
    for tag in ["I","T"]:
        if verb_stem(wd) in lx.getAll(tag):
            if verb_stem(wd) == wd:
                tags.append(tag + "p")
            else:
                tags.append(tag + "s")
    for tag in function_words_tags:
        if wd == tag[0]:
            tags.append(tag[1])
    return tags

def tag_words (lx, wds):
    """returns a list of all possible taggings for a list of words"""
    if (wds == []):
        return [[]]
    else:
        tag_first = tag_word (lx, wds[0])
        tag_rest = tag_words (lx, wds[1:])
        return [[fst] + rst for fst in tag_first for rst in tag_rest]

# End of PART B.
