#ifndef TCL_H_INCLUDED
#define TCL_H_INCLUDED
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
typedef struct tclfiles_s
{
    FILE *master;
    char mpath[256];

    FILE *master2;
    char mpath2[256];

    FILE *slave;
    char spath[256];

    FILE *slave2;
    char spath2[256];
} tclfiles_t;

enum
{
    tcl_success,
    failture_open
};

char init_tclfiles(tclfiles_t *tcl,char *mpath,char *spath);
char close_tclfiles(tclfiles_t *tcl);
char modifypartcl(tclfiles_t *tcl,char *filename,char *filepath,char *destpath, char parnum);
char modifywholetcl(tclfiles_t *tcl,char *filename,char *filepath,char *destpath, char parnum);


#endif // TCL_H_INCLUDED
