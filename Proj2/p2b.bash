#!/bin/bash

# cat files together
# run p2a.sed 
# sort and count instances
# run p2b.sed and send it to p2b.out
cat lastlog1.out lastlog2.out | sed -f p2a.sed | sort | uniq -c | sed -f p2b.sed > p2b.out

