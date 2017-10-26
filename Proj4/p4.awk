BEGIN{
    FS=","
    email = "";
    name = "";
    title = "";
    amtPaid = 0;
    amtOwed = 0;
}
{
    if ($4 < $5)
    {
        email = $1;
        name = $2;
        title = $3;
        amtPaid = $4;
        amtOwed = $5;
        #print $1, $3, $2;
        #print $5, $4;
        #printf "sed '-e s/EMAIL/"$email"/g\n";
        print "cat template.txt | sed -e 's|EMAIL|"email"|g' -e 's|TITLE|"title"|g' -e 's|FULLNAME|"name"|g' -e 's|NAME|"name"|g' -e 's|AMOUNT|"amtOwed"|g' -e 's|DATE|"date"|g'" >email".sed";
    }    
}
