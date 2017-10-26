#!/bin/bash
# We want to accept a payment and update customer file

# Prompt user for information
read -p "Please enter customer email: " email
read -p "Please enter payment amount: " payment

# Find file
file=$(find .  -name "$email")
export file
export payment

# Check if customer exists
if [ ! -r "$file" ]; then
    echo "[*] Error: customer not found"
else
# If customer exists, pull file and update balance
    echo "[*] Updating customer file."
    bash ./updateBal.sh < $file
fi




