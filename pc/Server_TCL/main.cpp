#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#include <unistd.h>
#include <pthread.h>


#include "./source/header/config.h"
#include "./source/header/fileset.h"
#include "./source/header/tcl.h"
#include "./source/header/schedule.h"
#include "./source/header/vivado_log_parser.h"
#include "./source/header/json.h"
#include "./source/header/managefiles.h"
#include "./source/header/vivado.h"

//#define create_products

//Thread
void *inputhandling(void *in);

char init(configpath *config, files_t *fileset,tclfiles_t *tcl,pthread_t *userinput, int *input);
char reinitfileset(files_t *fileset,configpath_s *config);

void filljson(configpath_s *config, files_t *fileset,json_t *new_user, int currentfile, char *fset,char parnum);


int main(int argc, char* argv[])
{

    char fset=true;
    configpath config;
    files_t fileset;
    tclfiles_t tcl;
    resources_t res;
//schedule_t schedule;
    json_t new_user;

    pthread_t userinput;

    int input=0;
    char parnum=0;
    int used=0;

   //
    //Init all basic structs
    if(init(&config,&fileset,&tcl, &userinput, &input)!=0)
    {
        printf("Error initing!!!");
        return -1;
    }
    char usedpars[8];
    for(int i=0; i<8; i++)
    {
        usedpars[i]=-1;
    }

    /////////////////////////////////////
    //Start main loop
    ////////////,////////////////
    do
    {
        for(int i=0; i<fileset.filenum; i++)
        {
            modifypartcl(&tcl,fileset.file[i],&config);
            modifyentity(&fileset,i,config);
#define create_products
#ifdef create_products
            //source par tcl files
            startparvivado(&config);
#endif // create_products

            if(parselog(&res,&config,&parnum)==-1)
            {
                printf("INITAILY UNROUTABLE FATAL ERROR\n");
            }

            if(containsport(&fileset,"UART_ZYNQ_RXD") || containsport(&fileset,"UART_ZYNQ_TXD"))
            {
                parnum=7;
            }

            if(parnum!=-1)
            {
                for(int a=0; a<8; a++)
                {
                    if(usedpars[a]==parnum)
                    {
                        parnum=changeparnum(parnum);
                        a=0;
                    }
                }
                usedpars[used]=parnum;
                used++;

                /*for(int a=0; a<8; a++)
                {
                    if(usedpar(&schedule,parnum))
                    {
                        parnum=changeparnum(parnum);
                        if(parnum==-1)
                        {
                            printf("Unroutable");
                        }
                    }
                }*/

                if(config.verbose)
                {
                    printf("File before modparent :%s \n",fileset.file[i]);
                }


                modifyentitypar(&fileset,i,config,parnum);
                modifypartcl(&tcl,fileset.file[i],&config);
#define create_products
#ifdef create_products
            //source par tcl files
            startparvivado(&config);
#endif // create_products
                modifywholetcl(&tcl,fileset.file[i],&config,parnum);

                if(config.verbose)
                {
                    printf("\n\n USER :%s  \n DESIGN %s \n, parnum %d\n",fileset.file[i],fileset.file[i],parnum);
                }

#ifdef create_products
                startwhovivado(&config);
#endif // create_products

                if(config.verbose)
                {
                    printf("File before managebitfiles :%s \n",fileset.file[i]);
                }
                managebitfiles(&config,&fileset,i);

                if(config.verbose)
                {
                    printf("File before filljson :%s \n",fileset.file[i]);
                }
                filljson(&config, &fileset,&new_user, i, &fset, parnum);
                movefinishedfiles( fileset, config, i );
            }
        }

        sleep(5);

        for(int i=0; i<8; i++)
        {
            usedpars[i]=-1;
        }

        if(reinitfileset(&fileset,&config)!=0)
        {
            printf("error initing fileset");
            return -1;
        }
        fset=true;

    }
    while(input!='e');

    //modifyentity(&fileset, fileset.file[0], argv[3]);

    close_tclfiles(&tcl);
    free_fileset(&fileset);

    return 0;
}

char reinitfileset(files_t *fileset,configpath_s *config)
{
        free_fileset(fileset);
        if(init_fileset(fileset)!=success)
        {
            printf("error malloc");
            return error_malloc;
        }

        if(init_files(fileset,config)!=success)
        {
            printf("error initfileset");
            printf("error :%d",init_files(fileset,config));
            return -1;
        }

        if(init_portset(fileset,config)!=success)
        {
            printf("error init portset");
            printf("error :%d",init_portset(fileset,config));
            return -1;
        }


        if(config->verbose)
        {
            printf("\nIncluded ports\n");
            for(int i=0; i<fileset->portsnum; i++)
            {
                printf("%s\n",fileset->ports[i]);
            }

            printf("Included files\n");
            for(int i=0; i<fileset->filenum; i++)
            {
                printf("%s\n",fileset->file[i]);
            }
            printf("\n\n");
        }

        return 0;
}

char init(configpath *config, files_t *fileset,tclfiles_t *tcl,pthread_t *userinput, int *input)
{

    if(getconfig(config)==-1)
    {
        printf("error opening vonfig");
        return -1;
    }

    if(init_fileset(fileset)!=success)
    {
        printf("error malloc");
        return error_malloc;
    }

    if(init_tclfiles(tcl,config)!=tcl_success)
    {
        printf("error opentcl");
        return failture_open;
    }

    //project initialisation with vivado
    if (0 != access(config->projectpath, F_OK))
    {
        char hilf[500]="bash -c 'cd ";
        strcat(hilf,config->projectpath);
        strcat(hilf," && ls && source ");
        strcat(hilf, config->vivadopath);
        strcat(hilf,"settings64.sh && vivado -source ");
        strcat(hilf,config->projectpath);
        strcat(hilf,"create_project.tcl ");
        strcat(hilf,config->tclinpath);
        strcat(hilf,"dynparrec.tcl \n'");
        printf("%s", hilf);
        system(hilf);
    }

    if(init_files(fileset,config)!=success)
    {
        printf("error initfileset");
        printf("error :%d",init_files(fileset,config));
        return 1;
    }

    if(init_portset(fileset,config)!=success)
    {
        printf("error init portset");
        printf("error initfileset");
        printf("error :%d",init_portset(fileset,config));
        return 1;
    }

    if(config->verbose)
    {
        printf("\nIncluded ports\n");
        for(int i=0; i<fileset->portsnum; i++)
        {
            printf("%s\n",fileset->ports[i]);
        }

        printf("Included files\n");
        for(int i=0; i<fileset->filenum; i++)
        {
            printf("%s\n",fileset->file[i]);
        }
        printf("\n\n");
    }


    if (pthread_create(userinput, NULL, inputhandling, input) != 0)
    {
        printf("\ncan't create thread :[%s]", strerror(pthread_create(userinput, NULL, inputhandling, input)));
        return -1;
    }

    if(config->verbose)
    {
        printf("\n Thread created successfully\n");
    }

    return 0;
}

void *inputhandling(void *in)
{
    do
    {
        char *input =(char*)in;
        scanf("%c",input);
        if(*input=='e')
        {
            pthread_exit(0);
        }
    }
    while(1);
}


