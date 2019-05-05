#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#ifndef SCHEDULE_H_INCLUDED
#define SCHEDULE_H_INCLUDED
typedef struct schedule_s
{
    char dirfiles[8][256];
    char dircount;

    char filenames[8][256];
    char par[8];

} schedule_t;

void scheduler (schedule_t *schedule,char* otputpath,char* filename, char port);
void sortarray(char hilf[][256], char *par);
void getdir(schedule_t *schedule,char* otputpath);
void cmpdir(schedule_t *schedule);
char usedpar (schedule_t *schedule,char parnum);
void sortarray(char hilf[][256], char *par);
void getfilenames(schedule_t *schedule,char * filename,char parnum);

#endif // SCHEDULE_H_INCLUDED
