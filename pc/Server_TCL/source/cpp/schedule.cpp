#include "../header/schedule.h"
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#include <unistd.h>

char filehilf=0;
void scheduler (schedule_t *schedule,char* otputpath,char* filename, char port)
{
    getdir(schedule,otputpath);
    getfilenames(schedule,filename,port);
    cmpdir(schedule);
}
void getdir(schedule_t *schedule,char* otputpath)
{
    DIR *d;
    struct dirent *dir;
    d=opendir(otputpath);
    int i=0;
    if(d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            if(strstr(dir->d_name,".bit"))
            {
                char *pointer=strstr(dir->d_name,".bit");
                *pointer='\0';
                strcpy(schedule->dirfiles[i],dir->d_name);
                i++;
            }
        }
        closedir(d);
    }
    schedule->dircount=i;
    for(i=i; i<8; i++)
    {
        schedule->dirfiles[i][0]='\0';
    }
}
void cmpdir(schedule_t *schedule)
{
    char check=true;
    for(int i=0; i<8; i++)
    {
        check =true;
        for(int a=0; a<8; a++)
        {
            if(strcmp(schedule->filenames[i],schedule->dirfiles[a])==0)
            {
                check=false;
            }
        }
        if(check)
        {
            schedule->filenames[i][0]='\0';
            schedule->par[i]=-2;
        }
        sortarray(schedule->filenames,schedule->par);
    }
}
char usedpar (schedule_t *schedule,char parnum)
{
    for(int i=0; i<8; i++)
    {
        if(schedule->par[i]==parnum)
        {
            printf("\n\nPAr sind gleich  %d %d\n ",schedule->par[i],parnum);
            return true;
        }

    }
    printf("\n\nPAr sind nicht gleich   %d\n ",parnum);
    return false;
}


void sortarray(char hilf[][256], char *par)
{
    for(int a=0; a<8; a++)
    {
        for(int i=0; i<8; i++)
        {
            if(hilf[i][0]=='\0')
            {
                if(i<7)
                {
                    strcpy(hilf[i],hilf[i+1]);
                    par[i]=par[i+1];
                }
            }
        }
    }
    for(int i=0; i<8; i++)
    {
        if(hilf[i][0]=='\0')
        {
            filehilf=i;
            break;
        }
    }

}


void getfilenames(schedule_t *schedule,char * filename,char parnum)
{
    char hilf=true;
    for(int i=0; i<8; i++)
    {
        if(strcmp(schedule->filenames[i],filename)==0)
        {
            hilf=false;
        }
    }
    if(hilf)
    {
        strcpy(schedule->filenames[(int)filehilf],filename);
        schedule->par[(int)filehilf]=parnum;
        filehilf++;
        if(filehilf==8)
        {
            printf("OVERFLOW!!!!!!!!!\n!");
            filehilf=0;
        }
    }
}

