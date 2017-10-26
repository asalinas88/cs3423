#!/bin/bash
# call awk script
awk -v date="$1" -f p4.awk p4Customer.txt
# make Emails directory
if [ -d "Emails" ]; then
    rm -f Emails/*
else
    mkdir -p Emails
fi
# perform sed cmds on template file
# to generate automated emails for specified customers
for file in *.sed; do
    filename=$(echo $file | sed 's/\.sed//g')
    bash $file > Emails/$filename
done
rm *.sed
