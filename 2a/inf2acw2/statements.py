# File: statements.py
# Template file for Informatics 2A Assignment 2:
# 'A Natural Language Query System in Python/NLTK'

# John Longley, November 2012
# Revised November 2013 and November 2014 with help from Nikolay Bogoychev
# Revised November 2015 by Toms Bergmanis and Shay Cohen


# PART A: Processing statements

def add(lst,item):
    if (item not in lst):
        lst.insert(len(lst),item)

class Lexicon:
    """stores known word stems of various part-of-speech categories"""
    def __init__(self):
        self.dict = {"P":[], "N":[], "A":[], "I":[], "T":[]}

    def add(self, stem, cat):
        if cat in self.dict.keys():
            if (not (stem in self.dict[cat])):
                self.dict[cat].append(stem)

    def getAll(self, cat):
        return self.dict[cat]
    
class FactBase:
    def __init__(self):
        self.unary = {}
        self.binary = {}

    def addUnary(self, pred, e1):
        if (not (pred in self.unary.keys())):
            self.unary[pred] = []
        self.unary[pred].append(e1)

    def addBinary(self, pred, e1, e2):
        if (not (pred in self.binary.keys())):
            self.binary[pred] = []
        self.binary[pred].append((e1,e2))

    def queryUnary(self, pred, e1):
        if (not (pred in self.unary.keys())):
            return False
        if e1 in self.unary[pred]:
            return True
        else:
            return False
        
    def queryBinary(self, pred, e1, e2):
        if (not (pred in self.binary.keys())):
            return False
        if (e1,e2) in self.binary[pred]:
            return True
        else:
            return False

import re
from nltk.corpus import brown

#get all VB and VBZ words
vbvbz = []
for t in brown.tagged_words():
    if (t[1]=="VBZ" or t[1]=="VB"):
        if (not (t[0] in vbvbz)):
            vbvbz.append(t[0])
        
def verb_stem(s):
    """extracts the stem from the 3sg form of a verb, or returns empty string"""
    if (not (s in vbvbz)):
        #Filters non-verb word
        s = ""
    
    if (s == "has"):
        s = "have"
    else:
        if re.match(".*s", s):
            if re.match("(.|unt)ies", s):
                #Xie case
                s = s[:-1]
            elif re.match(".*(a|e|i|o|u)ies", s):
                #only y changes to ies, all vowel+ies combinations are invalid
                s = ""
            elif re.match(".*ies", s):
                #Other ies case
                s = s[:-3]+"y"
            elif re.match(".*es", s):
                if re.match(".*(o|x|ch|sh|ss|zz)es", s):
                    #+es case (quizzes should become quiz,not quizz)
                    s = s[:-2]
                else:
                    #all other case(ies excluded previously)
                    s = s[:-1]
            elif re.match(".*(a|e|i|o|u)ys", s):
                #vowel ys case
                s = s[:-1]
            elif re.match(".*(a|i|o|u|s|x|y|z|ch|sh)s", s):
                #invalid +s case
                s = ""
            else:
                #other available +s case
                s = s[:-1]
    return s

def add_proper_name (w,lx):
    """adds a name to a lexicon, checking if first letter is uppercase"""
    if ('A' <= w[0] and w[0] <= 'Z'):
        lx.add(w,'P')
        return ''
    else:
        return (w + " isn't a proper name")

def process_statement (lx,wlist,fb):
    """analyses a statement and updates lexicon and fact base accordingly;
       returns '' if successful, or error message if not."""
    # Grammar for the statement language is:
    #   S  -> P is AR Ns | P is A | P Is | P Ts P
    #   AR -> a | an
    # We parse this in an ad hoc way.
    msg = add_proper_name (wlist[0],lx)
    if (msg == ''):
        if (wlist[1] == 'is'):
            if (wlist[2] in ['a','an']):
                lx.add (wlist[3],'N')
                fb.addUnary ('N_'+wlist[3],wlist[0])
            else:
                lx.add (wlist[2],'A')
                fb.addUnary ('A_'+wlist[2],wlist[0])
        else:
            stem = verb_stem(wlist[1])
            if (len(wlist) == 2):
                lx.add (stem,'I')
                fb.addUnary ('I_'+stem,wlist[0])
            else:
                msg = add_proper_name (wlist[2],lx)
                if (msg == ''):
                    lx.add (stem,'T')
                    fb.addBinary ('T_'+stem,wlist[0],wlist[2])
    return msg
                        
# End of PART A.

