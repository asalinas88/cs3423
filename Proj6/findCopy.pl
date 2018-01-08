#!/usr/bin/perl -w

# check to see if directory exists
# if not, exit
die "Invalid number of arguments\n" if ($#ARGV < 1);
my $regex = shift @ARGV;
#my $dir = shift @ARGV;
opendir(DIR, "$ARGV[2]") or die $!;
while (my $file = readdir(DIR)){
    if ($file =~ $regex){
        print $file;
    }
    open(IN, "<", $file) or die "Unable to open file\n";
    while (my $line = <IN>){
        if ($line =~ $regex){
            print "$file: $line\n";
        }
        close(IN);
    }
}



