#ifndef TCL_H_INCLUDED
#define TCL_H_INCLUDED

#include <stddef.h>
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#include <errno.h>
#include "../header/config.h"

typedef struct tclfiles_s
{
    FILE *inpar;
    FILE *inwho;
    char tclinpath[256];

    FILE *outpar;
    FILE *outwho;
    char tcloutpath[256];

} tclfiles_t;

enum
{
    tcl_success,
    failture_open
};

char init_tclfiles(tclfiles_t *tcl,configpath_s *config);
char close_tclfiles(tclfiles_t *tcl);
char modifypartcl(tclfiles_t *tcl,char *filename,configpath_s *config);
char modifywholetcl(tclfiles_t *tcl,char *filename,configpath_s *config, char parnum);


#endif // TCL_H_INCLUDED
