#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#include "/home/pfirsichgnom/Dokumente/Codeblocks/Server_TCL/source/header/fileset.h"
#include "/home/pfirsichgnom/Dokumente/Codeblocks/Server_TCL/source/header/tcl.h"
#include "/home/pfirsichgnom/Dokumente/Codeblocks/Server_TCL/source/header/schedule.h"
#include "/home/pfirsichgnom/Dokumente/Codeblocks/Server_TCL/source/header/vivado_log_parser.h"
#include "/home/pfirsichgnom/Dokumente/Codeblocks/Server_TCL/source/header/json.h"
#include <unistd.h>
#include <pthread.h>
//#define create_products
/*
arguments

/home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/proj/                   //tcl
/home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/proj/oproduct/          //tclzielpfad
/home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/src/hdl/files/          //fileset
/home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/src/hdl/files          //finishedfiles
*/



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

int main(int argc, char* argv[])
{

    if(argc==1)
    {
        printf("Übergabeparameter:\n");
        printf("tclinputscriptpath tcloutputpath");
        return -99;
    }

    resources_t res;
    tclfiles_t tcl;
    files_t fileset;
    schedule_t schedule;
    json_t data[8];
    json_t new_user={"","",0,{""},1,{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},32};
    int ports=0;
    char portsnames[40][256];


    if(init_fileset(&fileset)!=success)
    {
        printf("error malloc");
        return error_malloc;
    }

    if(init_tclfiles(&tcl,argv[1], argv[1])!=tcl_success)
    {
        printf("error opentcl");
        return failture_open;
    }

    //project initialisation
#ifdef init
    char hilf[256]="cd ";
    strcat(hilf,argv[2]);

    strcat(hilf,"&& ls && source /home/pfirsichgnom/Programme/XILINX/2017.4/Vivado/2017.4/settings64.sh && vivado -source  ");
    strcat(hilf,argv[2]);
    strcat(hilf,"create_project.tcl ");
    strcat(hilf,argv[2]);
    strcat(hilf,"dynparrec.tcl");


    system(hilf);
#endif // init

    if(init_files(&fileset,argv[3],argv[4])!=success)
    {
        printf("error initfileset");
        printf("error :%d",init_files(&fileset,argv[3],argv[4]));
        return -1;
    }

    if(init_portset(&fileset,argv[3])!=success)
    {
        printf("error init portset");
        printf("error initfileset");
        printf("error :%d",init_portset(&fileset,argv[3]));
        return -1;
    }

    printf("Included ports\n");
    for(int i=0; i<fileset.portsnum; i++)
    {
        printf("%s\n",fileset.ports[i]);
    }

    printf("Included files\n");
    for(int i=0; i<fileset.filenum; i++)
    {
        printf("%s\n",fileset.file[i]);
    }

    int input=0;

    pthread_t tid;
    int err;
    err = pthread_create(&(tid), NULL, inputhandling, &input);
    if (err != 0)
    {
        printf("\ncan't create thread :[%s]", strerror(err));
    }
    else
    {
        printf("\n Thread created successfully\n");
    }


    char parnum=0;

    /////////////////////////////////////
    //Start main loop
    ////////////,////////////////

    do
    {
        for(int i=0; i<fileset.filenum; i++)
        {

            modifypartcl(&tcl,fileset.file[i],argv[3],argv[2],parnum);

#ifdef create_products
            char cop[256]="cd ";
            strcat(cop,argv[2]);

            strcat(cop,"&& ls && source /home/pfirsichgnom/Programme/XILINX/2017.4/Vivado/2017.4/settings64.sh && vivado -source  ");
            strcat(cop,argv[2]);
            strcat(cop,"sspar.tcl ");
            system(cop);
#endif // create_products
            if(parselog(&res,argv[1],&parnum)==-1)
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
                    if(usedpar(&schedule,parnum))
                    {
                        parnum=changeparnum(parnum);
                        if(parnum==-1)
                        {
                            printf("Unroutable");
                        }
                    }
                }

                modifywholetcl(&tcl,fileset.file[i],argv[3],argv[2],parnum);
                scheduler(&schedule,argv[2],fileset.file[i],parnum);
                printf("\n\n USER :%s  \n DESIGN %s \n, parnum %d\n",fileset.file[i],fileset.file[i],parnum);


#ifdef create_products
                char cop[256]="cd ";
                strcat(cop,argv[2]);

                strcat(cop,"&& ls && source /home/pfirsichgnom/Programme/XILINX/2017.4/Vivado/2017.4/settings64.sh && vivado -source  ");
                strcat(cop,argv[2]);
                strcat(cop,"sswhole.tcl ");
                system(cop);
#endif // create_products



                char hilf[256];
                strcpy(hilf,fileset.file[i]);
                char *pointer=strstr(hilf,".vhd");
                *pointer='\0';
                strcat(hilf,".bit");
                strcpy(new_user.design,hilf);

                pointer=strstr(hilf,"_");
                *pointer='\0';
                strcpy(new_user.user,hilf);
                ports_file(&fileset,i,&ports,argv[3],portsnames);

                printf("\n PORTNUM %d",ports);
                addconnections(&new_user,portsnames,ports);
                new_user.pblock=parnum;

                strcpy(hilf,argv[2]);
                strcat(hilf,"users.json");
                add_user_json(new_user, hilf);
                parse_json(data, hilf);

                char mv[256]="mv ";
                strcat(mv,argv[3]);
                strcat(mv,fileset.file[i]);
                strcat(mv, " ");
                strcat(mv, argv[3]);
                strcat(mv,"fertig/");
                system(mv);
            }
        }

        sleep(5);



        free_fileset(&fileset);



        if(init_fileset(&fileset)!=success)
        {
            printf("error malloc");
            return error_malloc;
        }


        if(init_files(&fileset,argv[3],argv[4])!=success)
        {
            printf("error initfileset");
            printf("error :%d",init_files(&fileset,argv[3],argv[4]));
            return -1;
        }

        if(init_portset(&fileset,argv[3])!=success)
        {
            printf("error init portset");
            printf("error :%d",init_portset(&fileset,argv[3]));
            return -1;
        }

    }
    while(input!='e');

    //modifyentity(&fileset, fileset.file[0], argv[3]);

    close_tclfiles(&tcl);
    free_fileset(&fileset);

    return 0;
}

