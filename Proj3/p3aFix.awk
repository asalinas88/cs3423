{
    if (NF == 3){
        printf("%s %s %s\n", $2, $3, $1);
    }
    if (NF == 2){
        printf("%s %s\n", $2, $1);
    }

    
}
