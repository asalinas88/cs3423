#!/bin/bash
# this script performs the same way as prettyPrint
# will read in multiple lines of file
# will update customer balance
# will re-write file

# first line: email firstName lastName
# second line: APT-XX rent balance dueDate

read email firstName lastName
read apt rent balance date
newBal=$((balance-payment))
echo $email $firstName $lastName > "Data/$email"
echo $apt $rent $newBal $date >> "Data/$email"
echo "[*] Updating customer file finished."
