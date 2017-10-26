{
    if (NF == 3){
    printf("%s %s %s\n", $3, $1, $2);
    }
    if (NF == 2){
    printf("%s %s\n", $2, $1);
    }
}
    
