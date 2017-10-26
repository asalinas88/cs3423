#!/bin/bash

# Insert dollar signs after user name
#cat lastlog1.out | sed -f p2aDollar.sed > dollar.out

# Find matches in last log1
cat lastlog1.out | sed -f p2a.sed > nolog1.txt

# Find matches in last log 2 and insert dollar signs
cat lastlog2.out | sed -f p2aDollar.sed > dollar.txt
grep -f dollar.txt nolog1.txt > p2a.out

rm dollar.txt nolog1.txt 
