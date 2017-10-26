#!/bin/bash

# Prompt user for apartment to search 
read -p "Enter customer's apartment number (APT-XX): " apt
echo "Searching for apartment $apt"

var=$(grep -l "$apt" ./Data/*)
# Check if results are 0 or empty
if [ -z $var ]; then
    echo "[*] Error: apartment number not found"
else
    for file in $var; do
        echo "File: " $file
        bash ./prettyPrint.sh < $file
    done
fi
    
