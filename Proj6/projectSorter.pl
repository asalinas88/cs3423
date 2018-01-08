#!/usr/bin/perl -w

# check arguments
if ($#ARGV < 0){
    die "Invalid number of arguments\n";    
}

my @files = glob("$ARGV[0]/*");
foreach my $file (@files){
    if (-d $file){
        next;    
    }
    if ($file =~ /proj(.*)\./){
        mkdir "$ARGV[0]/assignment$1/";
        `mv $file "$ARGV[0]/assignment$1/"`;
    }
    else {
        mkdir "$ARGV[0]/misc/";
        `mv $file "$ARGV[0]/misc/"`;
    }
} # end foreach
