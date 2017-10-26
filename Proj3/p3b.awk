BEGIN {
    printf("%-6s %8s %10s %15s\n", "NAME", "FLIGHT", "SEATS", "TOTAL COST");
    totalCost = 0;
    price = 0;
    cust = " ";
    seat = " ";
}
{
# last name is field $6
# flight is field $2
# seats are field $3
# cost is field $$4

    # if the line begins with customer
   if ($1 == "CUST"){
        # set customer to variable
        cust = $6;
        # set price to 0
        price = 0;
    }
    # else if we have reached the end of the customer record
    else if ($1 != "ENDCUST")
    {
        # create hash array to store flight info
        flight[$2] += $3;
        # calculate the price 
        price = $4*$3;
        printf("%-6s %11s %5s %7s %10s\n", cust, $2, flight[$2], seat, price);
        # calculate the total cost for customer
        totalCost += price;
    }
    else
    {
        # print the total cost
        printf("%30s %-30s\n", "Total", totalCost);    
        # set the total cost back to 0
        totalCost = 0;
    }

}
END{
    # print all elements of hash 
     printf("%-6s %15s\n", "Flight", "Total Seats");    
     for (key in flight){
         printf("%-6s %10s\n", key, flight[key]);
         }
    
}

  



