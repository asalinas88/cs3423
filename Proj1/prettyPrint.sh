#!/bin/bash
# this prints the customer file
# in the format requested
# first line: email firstName lastName
# second line: APT-XX rent balanceDue dueDate

read email firstName lastName
read apt rent balance date
echo "-----------------------"
echo "Email: $email"
echo "Name: $firstName $lastName"
echo "Apt: $apt"
echo "Balance: $balance"
echo "Rent Amt: $rent"
echo "Due Date: $date"
echo "-----------------------"
