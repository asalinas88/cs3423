#!/bin/bash
# create menu with options for user to select
go=0
while [ $go ];
    do
       echo "Enter your choice or CTRL-D to exit"
       echo "C - create a customer file"
       echo "P - accept a customer payment"
       echo "F - find customer by apartment number"
       if ! read opt; then
            # got EOF
            break
        fi
        case "$opt" in
            [Cc])
                bash ./create.sh
                ;;
             [Pp])
                bash ./payment.sh
                ;;
            [Ff])
                bash ./find.sh
                ;;
             *) echo "[*] Error: invalid action value"
                ;;
        esac
    done
