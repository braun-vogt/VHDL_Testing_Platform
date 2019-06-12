#ifndef FILESET_H_INCLUDED
#define FILESET_H_INCLUDED
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#include <dirent.h>
#include <stddef.h>
#include <unistd.h>

#include "../header/tcl.h"
#include "../header/config.h"
#define fnlm 256

typedef struct file_s
{
    char** file;
    long filenum;
    char** ports;
    long portsnum;
    FILE *vhd;
} files_t;

enum
{
    success,
    error_malloc,
    error_realloc,
    error_delete,
    error_free,
    error_openfile
};

char resize_portset(files_t *fileset, char *portname,char *file, configpath_s *config);

char init_fileset(files_t *fileset);
char init_files(files_t *fileset, configpath_s *config);
char init_portset(files_t *fileset, configpath_s *config);
char resize_fileset(files_t *fileset,char* dirname, configpath_s config);
char reinit_files(files_t *fileset);

char ports_file(files_t *fileset,int filenum,int *portnum, configpath_s *config, char ports[][256]);
char ports_file_num(files_t *fileset,int filenum,int *portnum, configpath_s *config, char ports[][256],int *pinnum,int *anzahl);

char containsport(files_t *fileset,const char *port);
void free_fileset(files_t *fileset );
char *analyce_ports(char* portline);
char remove_element(files_t *fileset, int i);


char modifyentitypar(files_t *fileset, int currentfile, configpath_s config, char parnum);
char modifyentity(files_t *fileset, int currentfile, configpath_s config);

#endif // FILESET_H_INCLUDED
