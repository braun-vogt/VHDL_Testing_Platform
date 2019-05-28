#include "../header/managefiles.h"

void movefinishedfiles(files_t fileset, configpath_s config, int currentfile)
{
    char mv[256]="mv ";
    strcat(mv,config.vhdlinpath);
    strcat(mv,fileset.file[currentfile]);
    strcat(mv, " ");
    strcat(mv, config.vhdloutpath);
    system(mv);

    strcpy(mv,"mv ");
    strcat(mv,config.dcpoutpath);
    strcat(mv,fileset.file[currentfile]);
    char *hpointer=strstr(mv,".");
    *hpointer='\0';
    strcat(mv,".dcp ");
    strcat(mv,config.dcpsavpath);
    system(mv);

    hpointer=strstr(mv,".");
    *hpointer='\0';
    strcat(mv,".edif ");
    strcat(mv,config.dcpsavpath);
    system(mv);


    strcpy(mv,"mv ");
    strcat(mv,config.dcpoutpath);
    strcat(mv,fileset.file[currentfile]);
    hpointer=strstr(mv,".");
    *hpointer='\0';
    strcat(mv,"_routed.dcp ");
    strcat(mv,config.dcpsavpath);
    system(mv);
}
char managebitfiles(configpath_s *config, files_t *fileset, int currentfile)
{
    char hilf[256];
    strcpy(hilf,fileset->file[currentfile]);
    char *pointer=strstr(hilf,".vhd");
    *pointer='\0';
    strcat(hilf,".bit");

    ////bitfiles transver
    char hilf2 [500]= "scp ";
    strcat(hilf2,config->bitoutpath);
    strcat(hilf2, hilf);
    strcat(hilf2," ");
    strcat(hilf2,config->scpbitdestpath);
    strcat(hilf2,hilf);
    if(config->verbose)
    {
        printf("scp bitfile path %s",hilf2);
        fflush(stdout);
    }
    //system(hilf2);

    for(int i=0; i<500; i++)
    {
        hilf2[i]='\0';
    }

    //remove transfered files
    strcpy(hilf2,"rm ");
    strcat(hilf2,config->bitoutpath);
    strcat(hilf2,hilf);
    system(hilf2);

    return 0;
}
