#!/usr/bin/perl -w
# check arguments
if ($#ARGV < 1){
    die "two arguments expected\n";    
}
# check for -i flag
if ($ARGV[0] eq "-i"){
    $flag = 1;
    $expr = $ARGV[1];
}
else {
    $flag = 0;
    $expr = $ARGV[0];
}
shift @ARGV;
# loop through files in directory
foreach my $file (@ARGV){
    # if the file name matches and -i is not specified, print the file
    if ($file =~ m/$expr/){
        if ($flag == 0){
            print "$file\n";
            next;
        }
    }
# if the file does not match, open the file and search the lines
    if ($file !~ m/$expr/){
        open(IN, "<", $file) or die "Unable to open file\n";
        my $match = 0;
        while (my $line = <IN>){
            if ($line =~ m/$expr/){
                chomp $line;
                $match = 1;
                if ($flag == 0){
                    print "$file: $line\n";
                }          
                last;

            }

 
        }

        if ($flag == 1 && $match == 0){
            print "$file\n";
        }
    }
}



