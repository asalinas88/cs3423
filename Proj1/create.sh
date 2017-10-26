#!/bin/bash
# Prompt user for customer information
read -p "Please enter customer email address: " email
read -p "Please enter customer's full name: " firstName lastName
read -p "Please enter the apartment number: " aptNum
read -p "What is the monthly rent amount? " rent
read -p "When is the next due date? " date

# Set account balance to 0
balance=0
export balance

#test if file exists
#if file does not exist, create and write to it
if [ -f "./Data/$email" ]; then
    echo "[*] Error: Customer already exists."
else
    touch "Data/$email"
    echo $email $firstName $lastName > "Data/$email"
    echo $aptNum $rent $balance $date >> "Data/$email"
    echo "[*] Creating new customer $firstName $lastName finished"

fi


