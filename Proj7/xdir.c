#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>
#include <dirent.h>
/* Create a function to create on xdir command.
   Print the directory name followed by a colon.
   Do not print any files that begin with "."
   Print the filenames (unqualified) in the order they are provided
   by the readdir function
*/
void checkFlags(int argc, char *argv[]);
void errExit(const char *arg, ...);
int flagL = 0;
int flagA = 0;

int main(int argc, char *argv[]){
    DIR *pDir;
    struct dirent *pDirent;
    struct stat statBuf;
    
    int rc;
    int statFlagF = 0;
    int statFlagD = 0;
    char type[1];
    char file[1000];

    
    // check number of arguments
    if (argc < 2)
        errExit("Too few arguments, directory name needed\n");    
    checkFlags(argc, argv);

    
    // open the directory
    pDir = opendir(argv[1]);

    // error check
    if (pDir == NULL)
        errExit("opendir could not open '%s' : %s", argv[1], strerror(errno));
    printf("%s : \n", argv[1]);
    
    
    int dirSz = strlen(argv[1]);
    
    // read in files from the directory
    while ((pDirent = readdir(pDir)) != NULL)
    {
        sprintf(file, "%s/%s", argv[1], pDirent->d_name);
        rc = stat(file, &statBuf);
        if (rc < 0)
            errExit("stat: %s", strerror(errno));

        // check for file/directory type
        if (S_ISREG(statBuf.st_mode))
            type[0] = 'F';
        if (S_ISDIR(statBuf.st_mode))
            type[0] = 'D';

        // check for count of 512 byte blocks


        // get size (in bytes)

        // check for -a flag and hidden files
        if (('.' == pDirent->d_name[0] && flagA == 1) || '.' != pDirent->d_name[0])
        {
            // check for -l flag
            if (flagL == 1)
            {
               printf("%*s%s %s %ld blks %ld bytes\n", 4, "", pDirent->d_name, type, statBuf.st_blocks, statBuf.st_size);

            }
            // otherwise just print directory name
            else
            {
                printf("%*s%s\n", 4, "", pDirent->d_name);
            }
        }
        


    }



}

void checkFlags(int argc, char *argv[])
{
    int i;
    for (i = 2; i < argc; i++)
    {
        if (strcmp(argv[i], "-l") == 0)
        {
              flagL = 1;  
        }
        else if (strcmp(argv[i], "-a") == 0)
        {
            flagA = 1;    
        }
    }
}

