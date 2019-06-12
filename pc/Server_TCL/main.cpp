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
#include "./source/header/waiter.h"

#define create_products

//Thread
void *inputhandling(void *in);
void *checkfileupdates(void *cknf);


char init(configpath *config, files_t *fileset,tclfiles_t *tcl,pthread_t *userinput, int *input, int *cknf);
char reinitfileset(files_t *fileset,configpath_s *config);
char actualicefileset(files_t *fileset,configpath_s *config);

void freeall(configpath_s *config,files_t *fileset);
configpath config;
char exitthreads=0;
int main(int argc, char* argv[])
{
    char fset=true;

    files_t fileset;
    tclfiles_t tcl;
    resources_t res;
//schedule_t schedule;
    json_t new_user;
    char firstrun=true;

    pthread_t userinput;

    int input=0;
    int cknf=0;
    char parnum=0;
    int used=0;

    //
    //Init all basic structs
    if(init(&config,&fileset,&tcl, &userinput, &input,&cknf)!=0)
    {
        fprintf(config.log,"Error initing!!!");
        fflush(config.log);
        return -1;
    }
    //void (*fp)(configpath_s &config,files_t &fileset);
    //atexit( fp);
    char usedpars[8];
    char oldusedpars[8];

    for(int i=0; i<8; i++)
    {
        oldusedpars[i]=-1;
    }

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

#ifdef create_products
            //source par tcl files
            startparvivado(&config);
#endif // create_products
            if(parselog(&res,&config,&parnum)==-1)
            {
                fprintf(config.log,"INITAILY UNROUTABLE FATAL ERROR\n");
                fflush(config.log);
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
                        fprintf(config.log,"parsice equals %d",parnum);
                        a=0;
                    }
                }
                usedpars[used]=parnum;


                for(int a=0; a<8; a++)
                {
                    if(oldusedpars[a]==usedpars[used] && oldusedpars[a]!=-1)
                    {
                        usedpars[used]=changeparnum(usedpars[used]);
                        a=0;
                        if(config.verbose)
                        {
                            fprintf(config.log,"USEDPAR equals oldusedpar\n");
                        }
                    }
                }
                if(usedpars[used]!=-1)
                {
                    oldusedpars[used]=usedpars[used];
                }


                fprintf(config.log,"usedpar actuall:%d",usedpars[used]);
                parnum=usedpars[used];
                used++;

                for(int a=0;a<8;a++)
                {
                    if(config.verbose)
                    {
                        fprintf(config.log,"USEDPAR:%d\n",usedpars[a]);
                        fprintf(config.log,"OLDUSEDPAR:%d\n",oldusedpars[a]);
                    }
                }



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
                    fprintf(config.log,"File before modparent :%s \n",fileset.file[i]);
                    fflush(config.log);
                }


                modifyentitypar(&fileset,i,config,parnum);
                modifypartcl(&tcl,fileset.file[i],&config);

#ifdef create_products
                //source par tcl files
                startparvivado(&config);
#endif // create_products
                modifywholetcl(&tcl,fileset.file[i],&config,parnum);

                if(config.verbose)
                {
                    fprintf(config.log,"\n\n USER :%s  \n DESIGN %s \n, parnum %d\n",fileset.file[i],fileset.file[i],parnum);
                    fflush(config.log);
                }

#ifdef create_products
                startwhovivado(&config);
#endif // create_products

                if(config.verbose)
                {
                    fprintf(config.log,"File before managebitfiles :%s \n",fileset.file[i]);
                    fflush(config.log);
                }
                managebitfiles(&config,&fileset,i);

                if(config.verbose)
                {
                    fprintf(config.log,"\nFile before filljson :%s \n",fileset.file[i]);
                    fflush(config.log);
                }

                int usold=0;
                for(int a=0; a<8; a++)
                {
                    if(oldusedpars[a]!=-1)
                    {
                        usold++;
                    }
                }
                if(usold==7)
                {
                    for(int a=0; a<8; a++)
                    {
                        oldusedpars[a]=-1;
                        fset=true;
                        if(config.verbose)
                        {
                            fprintf(config.log,"OLDUSEDPAR is full\n");
                        }
                    }
                }
                else
                {
                    fset=false;
                }

                if(!firstrun)
                {
                    filljson(&config, &fileset,&new_user, i, &fset, parnum);

                    if(config.verbose)
                    {
                        fprintf(config.log,"Jasen wird übernommen\n");
                    }

                }
                else
                {
                    filljson(&config, &fileset,&new_user, i, &firstrun, parnum);
                    firstrun=false;

                    if(config.verbose)
                    {
                        fprintf(config.log,"Jsen wird neu generiert da erster Start\n");
                    }
                }

                movefinishedfiles( fileset, config, i );
            }
        }

        if(!cknf)
        {
            if(waitfornewfiles(config)==-1)
            {
                fprintf(config.log,"inotifywait watch wurde beendet oder war nicht erfolgreich\n");
                return 0;
            }
        }
        else
        {
            cknf=0;
        }


        for(int i=0; i<8; i++)
        {
            usedpars[i]=-1;
        }

        if(fset==true)
        {
            if(config.verbose)
            {
                fprintf(config.log,"New Fileset oldusedpars full or portusage to high\n");
            }
            if(reinitfileset(&fileset,&config)!=0)
            {
                fprintf(config.log,"error initing fileset");
                fflush(config.log);
                return -1;
            }
        }
        else
        {
            if(config.verbose)
            {
                fprintf(config.log,"Append to Fileset oldusedchars not full\n");
            }
            if(actualicefileset(&fileset,&config)!=0)
            {
                fprintf(config.log,"error initing fileset");
                fflush(config.log);
                return -1;
            }
        }
        if(fileset.portsnum>config.maxportnum)
        {
            if(config.verbose)
            {
                fprintf(config.log,"Resice Fileset next turn ports are full\n");
            }
            for(int a=0;a<7;a++)
            {
                oldusedpars[a]=9;
            }
        }
    }
    while(input!='e');

    //modifyentity(&fileset, fileset.file[0], argv[3]);
    exitthreads=1;
    close_tclfiles(&tcl);
    free_fileset(&fileset);


    return 0;
}

char reinitfileset(files_t *fileset,configpath_s *config)
{
    free_fileset(fileset);
    if(init_fileset(fileset)!=success)
    {
        fprintf(config->log,"error malloc");
        fflush(config->log);
        return error_malloc;
    }

    if(init_files(fileset,config)!=success)
    {
        fprintf(config->log,"error initfileset");
        fprintf(config->log,"error :%d",init_files(fileset,config));
        fflush(config->log);
        return -1;
    }

    if(init_portset(fileset,config)!=success)
    {
        fprintf(config->log,"error init portset");
        fprintf(config->log,"error :%d",init_portset(fileset,config));
        fflush(config->log);
        return -1;
    }


    if(config->verbose)
    {
        fprintf(config->log,"\nIncluded ports\n");
        fflush(config->log);
        for(int i=0; i<fileset->portsnum; i++)
        {
            fprintf(config->log,"%s\n",fileset->ports[i]);
        }

        fprintf(config->log,"Included files\n");
        fflush(config->log);
        for(int i=0; i<fileset->filenum; i++)
        {
            fprintf(config->log,"%s\n",fileset->file[i]);
        }
        fprintf(config->log,"\n\n");
    }

    return 0;
}

char actualicefileset(files_t *fileset,configpath_s *config)
{

    fprintf(config->log,"\n\n\n\n\n\n\n\n\nIncluded ports bevore actualice\n");
    fflush(config->log);
    for(int i=0; i<fileset->portsnum; i++)
    {
            fprintf(config->log,"%s\n",fileset->ports[i]);
    }
    if(config->verbose)
    {
        fprintf(config->log,"Actualice Fileset!\n");
    }
    for(int i=0; i<fileset->filenum; i++)
    {
        free(fileset->file[i]);
    }
    free(fileset->file);

    if(reinit_files(fileset)!=success)
    {
        fprintf(config->log,"error malloc");
        fflush(config->log);
        return error_malloc;
    }

    fprintf(config->log,"\n\n\n\n\n\n\n\n\nIncluded ports after initfileset\n");
    fflush(config->log);
    for(int i=0; i<fileset->portsnum; i++)
    {
            fprintf(config->log,"%s\n",fileset->ports[i]);
    }



    if(init_files(fileset,config)!=success)
    {
        fprintf(config->log,"error initfileset");
        fprintf(config->log,"error :%d",init_files(fileset,config));
        fflush(config->log);
        return -1;
    }

    fprintf(config->log,"\n\n\n\n\n\n\n\n\nIncluded ports after initfiles\n");
    fflush(config->log);
    for(int i=0; i<fileset->portsnum; i++)
    {
            fprintf(config->log,"%s\n",fileset->ports[i]);
    }

    if(init_portset(fileset,config)!=success)
    {
        fprintf(config->log,"error init portset");
        fprintf(config->log,"error :%d",init_portset(fileset,config));
        fflush(config->log);
        return -1;
    }
    fprintf(config->log,"\n\n\n\n\n\n\n\n\nIncluded ports after portset\n");
    fflush(config->log);
    for(int i=0; i<fileset->portsnum; i++)
    {
            fprintf(config->log,"%s\n",fileset->ports[i]);
    }


    if(config->verbose)
    {
        fprintf(config->log,"\nIncluded ports\n");
        fflush(config->log);
        for(int i=0; i<fileset->portsnum; i++)
        {
            fprintf(config->log,"%s\n",fileset->ports[i]);
        }

        fprintf(config->log,"Included files\n");
        fflush(config->log);
        for(int i=0; i<fileset->filenum; i++)
        {
            fprintf(config->log,"%s\n",fileset->file[i]);
        }
        fprintf(config->log,"\n\n");
    }

    return 0;
}

char init(configpath *config, files_t *fileset,tclfiles_t *tcl,pthread_t *userinput, int *input, int *cknf)
{

    if(getconfig(config)==-1)
    {
        fprintf(config->log,"error opening config");
        fflush(config->log);
        return -1;
    }

    if(init_fileset(fileset)!=success)
    {
        fprintf(config->log,"error malloc");
        fflush(config->log);
        return error_malloc;
    }

    if(init_tclfiles(tcl,config)!=tcl_success)
    {
        fprintf(config->log,"error opentcl");
        fflush(config->log);
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
        fprintf(config->log,"%s", hilf);
        fflush(config->log);
        system(hilf);
    }

    if(init_files(fileset,config)!=success)
    {
        fprintf(config->log,"error initfileset");
        fprintf(config->log,"error :%d",init_files(fileset,config));
        fflush(config->log);
        return 1;
    }

    if(init_portset(fileset,config)!=success)
    {
        fprintf(config->log,"error init portset");
        fprintf(config->log,"error initfileset");
        fprintf(config->log,"error :%d",init_portset(fileset,config));
        fflush(config->log);
        return 1;
    }

    if(config->verbose)
    {
        fprintf(config->log,"\nIncluded ports\n");
        fflush(config->log);
        for(int i=0; i<fileset->portsnum; i++)
        {
            fprintf(config->log,"%s\n",fileset->ports[i]);
            fflush(config->log);
        }

        fprintf(config->log,"\nIncluded files\n");
        fflush(config->log);
        for(int i=0; i<fileset->filenum; i++)
        {
            fprintf(config->log,"%s\n",fileset->file[i]);
            fflush(config->log);
        }
        fprintf(config->log,"\n\n");
        fflush(config->log);
    }


    if (pthread_create(userinput, NULL, inputhandling, input) != 0)
    {
        fprintf(config->log,"\ncan't create thread :[%s]", strerror(pthread_create(userinput, NULL, inputhandling, input)));
        fflush(config->log);
        return -1;
    }

    if(config->verbose)
    {
        fprintf(config->log,"Thread created successfully\n\n");
        fflush(config->log);
    }

    if (pthread_create(userinput, NULL, checkfileupdates, cknf) != 0)
    {
        fprintf(config->log,"\ncan't create thread 2:[%s]", strerror(pthread_create(userinput, NULL, checkfileupdates, cknf)));
        fflush(config->log);
        return -1;
    }

    if(config->verbose)
    {
        fprintf(config->log,"Thread created successfully\n\n");
        fflush(config->log);
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
            exitthreads=1;
            removewatch();
            pthread_exit(0);
        }
    }
    while(1);
}
void *checkfileupdates(void *cknf)
{
    do
    {
        if(waitfornewfiles(config)==-1 || exitthreads)
        {
            fprintf(config.log,"inotifywait watch wurde beendet oder war nicht erfolgreich im thread!!!\n");
            pthread_exit(0);
        }
        //fprintf(config.log,"neues File im Thread entdeckt\n");
        *((int*)cknf)=1;
    }

    while(1);
}

