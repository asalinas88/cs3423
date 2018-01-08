#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <fcntl.h>
#include "cs3423p8.h"
void errExit(const char *arg, ...);
char **buildCmd(Cmd cmd, Token tokenM[]);
/***************************************************
int concCmd (Cmd cmdM[], int iCmdCnt, Token tokenMp[], int iTokenCnt);
Purpose:
    Causes PELL to execute commands in parallel

Parameters:
    Cmd cmdM[]     array of commands
    Token tokenM[] array of tokens for the input test
    int iTokenCnt  number of entries in tokenM


Notes:

Return value:
    0 if all children were launched successfully

****************************************************/
int concCmd(Cmd cmdM[], int iCmdCnt, Token tokenM[], int iTokenCnt){
    long lForkPid;
    int inputFD, outputFD;
    int i, status;
    char **fullCMD;

    for (i = 0; i < iCmdCnt; i++)
    {
        lForkPid = fork();
        switch(lForkPid)
        {
            case -1:
                errExit("fork failed: %s", strerror(errno));
                break;
            case 0:     // child process
                // open up input file (if there is one)
                if (cmdM[i].iStdinRedirectIdx != 0){
                    inputFD = open(tokenM[cmdM[i].iStdinRedirectIdx], O_RDONLY);
                    if (inputFD == -1)
                        errExit("Bad file: %s", cmdM[i].iStdinRedirectIdx);
                    if (dup2(inputFD, STDIN_FILENO) == -1)
                        errExit("dup failed");
                    if (inputFD != STDIN_FILENO)
                        close(inputFD);
                }  
                if (cmdM[i].iStdoutRedirectIdx != 0){
                    outputFD = open(tokenM[cmdM[i].iStdoutRedirectIdx],O_WRONLY|O_CREAT|O_EXCL, 0644);
                    if (outputFD == -1)
                        errExit("Bad file: %s", cmdM[i].iStdoutRedirectIdx);
                    if (dup2(outputFD, STDOUT_FILENO) == -1)
                        errExit("dup failed");
                    if (outputFD != STDOUT_FILENO)
                        close(outputFD);
                }
                fullCMD = buildCmd(cmdM[i], tokenM);
                execvp(fullCMD[0], fullCMD);

        } // end switch
    } // end for
    for (i = 0; i < iCmdCnt; i ++)
    {
        wait(&status);    
        if (status != 0)
            return status;
    }
    return 0;

}

/****************************************************
int pipeCmd (Cmd cmdM[], int iCmdCnt, Token tokenM[], int iTokenCnt);
Purpose:

Parameters:
    Cmd cmdM[]     array of commands
    Token tokenM[] array of tokens for the input test
    int iTokenCnt  number of entries in tokenM

Notes:

Return value:
*****************************************************/
int pipeCmd (Cmd cmdM[], int iCmdCnt, Token tokenM[], int iTokenCnt)
{
    long lForkPid;
    int fd[2];          // file descriptors for the pipe
    int inputFD, outputFD, dupRV;
    int status = 0;
    char **fullCMD;

    // create the pipe
    if (pipe(fd) == -1)
        errExit("Pipe not created %s", strerror(errno));    
    
    lForkPid = fork();  // create a child process

    // Both the parent and child continue here
    switch(lForkPid)
    {
        case -1:
            errExit("fork failed: %s", strerror(errno));
        case 0:     // child process - the reader
            // redirect stdin
            if (cmdM[0].iStdinRedirectIdx != 0){
                inputFD = open(tokenM[cmdM[0].iStdinRedirectIdx], O_RDONLY);
                if (inputFD == -1)
                    errExit("Bad file: %s", cmdM[0].iStdinRedirectIdx);
                dupRV = dup2(inputFD, STDIN_FILENO);
                if (inputFD != STDIN_FILENO)
                    close(inputFD);
                if (dupRV == -1)
                    errExit("dup failed");
            }

            dupRV = dup2(fd[1], STDOUT_FILENO);
            if (dupRV == -1)
                errExit("dup failed");
            close(fd[1]);
            fullCMD = buildCmd(cmdM[0], tokenM);
            execvp(fullCMD[0], fullCMD);
        default:    // parent process - the writer
            wait(NULL);
            close(fd[1]);
            lForkPid = fork();  
            switch(lForkPid)
            {
                case -1:
                    errExit("fork failed: %s", strerror(errno));
                case 0:
                    if (cmdM[1].iStdoutRedirectIdx != 0){
                        outputFD = open(tokenM[cmdM[1].iStdoutRedirectIdx], O_WRONLY|O_CREAT|O_EXCL, 0644);
                        if (outputFD == -1)
                            errExit("Bad file: %s", cmdM[1].iStdoutRedirectIdx);
                        dupRV = dup2(outputFD, STDOUT_FILENO);
                        if (dupRV == -1)
                            errExit("dup failed");
                    }
                    dupRV = dup2(fd[0], STDIN_FILENO);
                    if (dupRV == -1)
                        errExit("dup failed");
                    close(fd[0]);
                    close(outputFD);
                    fullCMD = buildCmd(cmdM[1], tokenM);
                    execvp(fullCMD[0], fullCMD);
                default:
                    wait(&status);
                    close(outputFD);
                    close(fd[0]);
                    return status;
            }  
    }
}

/***********************************************
char **buildCmd(Cmd cmd, Token tokenM[]);
Purpose:
    Build an array of commands
Parameters:
    Cmd cmd - reference to the cmd structure
    Token tokenM[] - reference to the tokenM array
***********************************************/
char **buildCmd(Cmd cmd, Token tokenM[])
{
    char **arr = malloc(sizeof(char *) * MAX_ARGS + 1);
    int i;
    int sz = 0;

    arr[0] = malloc(strlen(cmd.szCmdNm) + 1);
    strcpy(arr[sz++], cmd.szCmdNm);
    for (i = cmd.iBeginIdx; i <= cmd.iEndIdx; i++)
    {
        arr[sz++] = tokenM[i];
    }
    arr[sz] = NULL;
    return arr;
}
