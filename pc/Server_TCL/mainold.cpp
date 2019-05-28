#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#include "./source/header/fileset.h"
#include "./source/header/tcl.h"
#include "./source/header/schedule.h"
#include "./source/header/vivado_log_parser.h"
#include "./source/header/json.h"
#include <unistd.h>
#include <pthread.h>
#define constrainpath /home/


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
    char fset=true;
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
#define lol
#ifdef init
    //system("/bin/bash -i");

    char hilf[500]="bash -c 'cd /home/fbraun-lokal/git/VHDL_Testing_Platform/proj/ ";
    strcat(hilf,argv[1]);

    strcat(hilf," && ls && source /home/fbraun-lokal/Xilinx/Vivado/2017.4/settings64.sh && vivado -source ");
    strcat(hilf,"/home/fbraun-lokal/git/VHDL_Testing_Platform/proj/");
    strcat(hilf,"create_project.tcl ");
    strcat(hilf,argv[1]);
    strcat(hilf,"dynparrec.tcl \n '");


    printf("%s", hilf);
    system(hilf);

    getchar();
    getchar();
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

    printf("\nIncluded ports\n");
    for(int i=0; i<fileset.portsnum; i++)
    {
        printf("%s\n",fileset.ports[i]);
    }

    printf("Included files\n");
    for(int i=0; i<fileset.filenum; i++)
    {
        printf("%s\n",fileset.file[i]);
    }
    printf("\n\n");


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
    char usedpars[8];
    for(int i=0;i<8;i++)
    {
        usedpars[i]=-1;
    }
    int used=0;
    do
    {
        for(int i=0; i<fileset.filenum; i++)
        {

            modifypartcl(&tcl,fileset.file[i],argv[3],argv[2],parnum);
#define create_products
#ifdef create_products
            char cop[256]=" bash -c 'cd /home/fbraun-lokal/git/VHDL_Testing_Platform/proj/";
            //strcat(cop,argv[1]);

            strcat(cop," && source /home/fbraun-lokal/Xilinx/Vivado/2017.4/settings64.sh && vivado -mode batch -source  ");
            strcat(cop,argv[1]);
            strcat(cop,"sspar.tcl '");
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
                modifywholetcl(&tcl,fileset.file[i],argv[3],argv[2],parnum);
                scheduler(&schedule,argv[2],fileset.file[i],parnum);
                printf("\n\n USER :%s  \n DESIGN %s \n, parnum %d\n",fileset.file[i],fileset.file[i],parnum);

#ifdef create_products
                char cop[256]="bash -c 'cd ";
                strcat(cop,argv[1]);

                strcat(cop," && source /home/fbraun-lokal/Xilinx/Vivado/2017.4/settings64.sh && vivado -mode batch -source  ");
                strcat(cop,argv[1]);
                strcat(cop,"sswhole.tcl '");
                system(cop);
#endif // create_products

                char hilf[256];
                strcpy(hilf,fileset.file[i]);
                char *pointer=strstr(hilf,".vhd");
                *pointer='\0';
                strcat(hilf,".bit");
                strcpy(new_user.design,hilf);

                ////bitfiles transver

                char hilf2 [500]= "scp /home/fbraun-lokal/git/VHDL_Testing_Platform/pc/predefined_tcl/";
                strcat(hilf2, hilf);
                strcat(hilf2, " root@ictsrv002.ict.tuwien.ac.at:/home/root/par/");
                system(hilf2);

                char hilfhilf[256]="rm /home/fbraun-lokal/git/VHDL_Testing_Platform/pc/predefined_tcl/";
                strcat(hilfhilf,hilf);
                system(hilfhilf);

                int user=0;
                sscanf(hilf,"%*[^0-9]%d",&user);
                char name[256];
                sprintf(name,"%d",user);


                pointer=strstr(hilf,"_");
                *pointer='\0';

                strcpy(new_user.user,name);
                ports_file(&fileset,i,&ports,argv[3],portsnames);

                printf("\n PORTNUM %d",ports);
                addconnections(&new_user,portsnames,ports);
                new_user.pblock=parnum;

                strcpy(hilf,argv[2]);
                strcat(hilf,"users.json");




                printf("%s",hilf);
                fflush(stdout);

                if(fset)
                {
                    add_new_json(new_user, hilf);
                    fset=false;

                }
                else
                {
                    add_user_json(new_user, hilf);
                }


                parse_json(data, hilf);

                strcpy(hilf2, "scp ");
                strcat(hilf2, hilf);
                strcat(hilf2, " root@ictsrv002.ict.tuwien.ac.at:/home/root/par/");
                system(hilf2);

                char mv[256]="mv ";
                strcat(mv,argv[3]);
                strcat(mv,fileset.file[i]);
                strcat(mv, " ");
                strcat(mv, argv[3]);
                strcat(mv,"fertig/");
                system(mv);

                strcpy(mv,"mv /home/fbraun-lokal/git/VHDL_Testing_Platform/pc/tclziel/");
                strcat(mv,fileset.file[i]);
                char *hpointer=strstr(mv,".");
                *hpointer='\0';
                strcat(mv,".dcp /home/fbraun-lokal/git/VHDL_Testing_Platform/pc/tclziel/fertig/");
                system(mv);

                strcpy(mv,"mv /home/fbraun-lokal/git/VHDL_Testing_Platform/pc/tclziel/");
                strcat(mv,fileset.file[i]);
                hpointer=strstr(mv,".");
                *hpointer='\0';
                strcat(mv,"_routed.dcp /home/fbraun-lokal/git/VHDL_Testing_Platform/pc/tclziel/fertig/");
                system(mv);
            }
        }



        sleep(5);

        for(int i=0;i<8;i++)
        {
            usedpars[i]=-1;
        }


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
        fset=true;

    }
    while(input!='e');

    //modifyentity(&fileset, fileset.file[0], argv[3]);

    close_tclfiles(&tcl);
    free_fileset(&fileset);

    return 0;
}

