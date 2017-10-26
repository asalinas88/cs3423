#!/usr/bin/perl -w
# Declare variables

my $amtOwed = 0;
my $amtPaid = 0;
my $email = "";
my $name = "";
my $title = "";
my $date = $ARGV[0];

# Make the Emails subdirectory
mkdir Emails;

# Open the p5Customer file or send an error
open($IN, "<", "p5Customer.txt") || die "Could not open file\n";

# Read in the customer file
while (my $line = <$IN>)
{   
    chomp $line;

    # read customer data into variables by splitting line
    ($email, $name, $title, $amtPaid, $amtOwed) = split (/,/, $line);

    # Check to see if the customer owed more than what they've paid
    if ($amtOwed > $amtPaid){

        # If they owe money, open the template file and create  
        # email file to send them an email
        open($IN2, "<", "template.txt") || die "Could not open template\n";
        open($OUT2, ">", "Emails/$email") || die "cannot open email file\n";

        # Read in the template file
        while (my $read = <$IN2>)
        {   
            # Substitute values
            (my $subLine) = $read =~ s/EMAIL/$email/gr;
            ($subLine) = $subLine =~ s/FULLNAME/$name/gr;
            ($subLine) = $subLine =~ s/NAME/$name/gr;
            ($subLine) = $subLine =~ s/TITLE/$title/gr;
            ($subLine) = $subLine =~ s/AMOUNT/$amtOwed/gr;
            ($subLine) = $subLine =~ s/DATE/$date/gr;
            
            # Write to file
            print $OUT2 $subLine;

        }
        # Clsoe template files and email files
        close($OUT2);
        close($IN2);
       
        }
}
# Close Customer file
close($IN); 

