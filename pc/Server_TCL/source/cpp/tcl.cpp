#include "../header/tcl.h"
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>

//char parsices[8]= {6,4,5,2,0,1,3,7};
static char pars[8][256]= {"par0pm","par1pm","par2pm","par3pm","par4pm","par5pm","par6pm","par7pm"};

char init_tclfiles(tclfiles_t *tcl,char *mpath,char *spath)
{
    strcpy(tcl->mpath,mpath);
    strcat(tcl->mpath,"synthesice_par.tcl");
    tcl->master=fopen(tcl->mpath,"r");
    if(tcl->master==0)
    {
        perror("Error open file synthesice_par.tcl");
        return failture_open;
    }
    else {}

    strcpy(tcl->mpath2,mpath);
    strcat(tcl->mpath2,"synthesice_whole.tcl");
    tcl->master2=fopen(tcl->mpath2,"r");
    if(tcl->master2==0)
    {
        perror("Error open file synthesice_whole.tcl");
        return failture_open;
    }
    else {}

    strcpy(tcl->spath,spath);
    strcat(tcl->spath,"sspar.tcl");
    tcl->slave=fopen(tcl->spath,"w+");
    if(tcl->slave==0)
    {
        perror("Error open file sspar.tcl");
        return failture_open;
    }

    strcpy(tcl->spath2,spath);
    strcat(tcl->spath2,"sswhole.tcl");
    tcl->slave2=fopen(tcl->spath2,"w+");
    if(tcl->slave2==0)
    {
        perror("Error open file sswhole.tcl");
        return failture_open;
    }
    else
    {
        return tcl_success;
    }
}

char close_tclfiles(tclfiles_t *tcl)
{

    fclose(tcl->master2);
    fclose(tcl->slave2);
    fclose(tcl->master);
    fclose(tcl->slave);
    tcl->master=0;
    tcl->slave=0;
    tcl->master2=0;
    tcl->slave2=0;
    return tcl_success;
}


char modifypartcl(tclfiles_t *tcl,char *filename,char *filepath,char *destpath, char parnum)
{
    char scriptline[256*2];
    static char par45=0;
    static char par20=0;
    static char par13=0;
    fflush(stdout);

    fseek(tcl->slave,0,SEEK_SET);
    fseek(tcl->master,0,SEEK_SET);
    while(fgets(scriptline,256*2,tcl->master)!=0)
    {

        //constrins unused
        if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc")) //TO change
        {
            scriptline[10]='\0';
            strcat(scriptline,"/home/fbraun-lokal/git/VHDL_Testing_Platform/src/constraints/final.xdc\n");
        }
        if(strstr(scriptline,"get_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc")) //TO change
        {
            scriptline[10]='\0';
            strcat(scriptline,"/home/fbraun-lokal/git/VHDL_Testing_Platform/src/constraints/final.xdc\n");
        }


        if(strstr(scriptline,"report_utilization -file ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp")) //TO change
        {
            scriptline[25]='\0';
            strcat(scriptline,"/home/fbraun-lokal/git/VHDL_Testing_Platform/pc/predefined_tcl/");
            strcat(scriptline,"report.txt\n");
        }

        if(strstr(scriptline,"write_checkpoint –force ./Dokumente/git/VHDL_Testing_Platform/proj/part_routed.dcp")) //TO change
        {
            scriptline[26]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }
        if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/proj/static.dcp"))
        {
            scriptline[10]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,"static.dcp");
            strcat(scriptline,"\n");
        }
        if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/src/hdl/PART1.vhd"))
        {
            scriptline[10]='\0';
            strcat(scriptline,filepath);
            strcat(scriptline,filename);
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"write_checkpoint ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp"))   //TO change
        {
            scriptline[17]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"set_property SCOPED_TO_CELLS {par} [get_files ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp]")) //to change
        {
            strcpy(scriptline,"set_property SCOPED_TO_CELLS {");
            if(par45==0)
            {
                par45++;
            }
            else
            {
                parnum=4;
                par45=0;
            }

            if(par20==0)
            {
                par20++;
            }
            else
            {
                parnum=2;
                par20=0;
            }

            if(par13==0)
            {
                par13++;
            }
            else
            {
                parnum=0;
                par13=0;
            }

            strcat(scriptline,pars[(int)parnum]);
            strcat(scriptline,"} [get_files ");
            scriptline[46]='\0';
            strcat(scriptline,filepath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp]");
            strcat(scriptline,"\n");

        }
        else if(strstr(scriptline,"set_property top PART1.vhd [current_fileset]")) //to change
        {
            strcpy(scriptline,"set_property top ");
            strcat(scriptline,filepath);
            strcat(scriptline,filename);
            strcat(scriptline," [current_fileset] \n");
        }
        else if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp")) //to change
        {
            strcpy(scriptline,"add_files ");
            strcat(scriptline,filepath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }

        fprintf(tcl->slave,"%s",scriptline);
        fflush(tcl->slave);
    }
    return tcl_success;
}


//////////
//Fixpaths
///////
char modifywholetcl(tclfiles_t *tcl,char *filename,char *filepath,char *destpath, char parnum)
{
    char scriptline[256*2];
    static char par45=0;
    static char par20=0;
    static char par13=0;

    printf("PARNUM AUSWAHL %d\n",parnum);

    fseek(tcl->slave2,0,SEEK_SET);
    fseek(tcl->master2,0,SEEK_SET);
    while(fgets(scriptline,256*2,tcl->master2)!=0)
    {

        printf("%s",scriptline);
        //constrins unused
        if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc")) //TO change
        {
            scriptline[10]='\0';
            strcat(scriptline,"/home/fbraun-lokal/git/VHDL_Testing_Platform/src/constraints/final.xdc\n");
        }
        else if(strstr(scriptline,"set_property USED_IN {implementation} [get_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc]"))
        {
            printf("Drinnen \n\n");
            scriptline[49]='\0';
            strcat(scriptline,"/home/fbraun-lokal/git/VHDL_Testing_Platform/src/constraints/final.xdc]\n");
        }
        else if(strstr(scriptline,"get_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc")) //TO change
        {
            scriptline[10]='\0';
            strcat(scriptline,"/home/fbraun-lokal/git/VHDL_Testing_Platform/src/constraints/final.xdc\n");
        }
        else if(strstr(scriptline,"report_utilization -file ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp")) //TO change
        {
            scriptline[25]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,"report.txt\n");
        }

        else if(strstr(scriptline,"write_checkpoint –force ./Dokumente/git/VHDL_Testing_Platform/proj/part_routed.dcp")) //TO change
        {
            scriptline[17]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,".vhd");
            *pointer='\0';
            strcat(scriptline,"_routed.");
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/proj/static.dcp")) //TO change
        {
            scriptline[10]='\0';
            strcat(scriptline,"/home/fbraun-lokal/git/VHDL_Testing_Platform/proj/oproduct/");
            strcat(scriptline,"static.dcp");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/src/hdl/PART1.vhd")) //TO change
        {
            scriptline[10]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,filename);
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"write_checkpoint ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp"))   //TO change
        {
            scriptline[17]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"write_checkpoint ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp"))   //TO change
        {
            scriptline[17]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,".vhd");
            *pointer='\0';
            strcat(scriptline,"_routed.");
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"link_design -mode default -reconfig_partitions {part1} -part xc7z020clg400-1 -top top"))   //TO change
        {
            scriptline[48]='\0';
            strcat(scriptline,pars[(int)parnum]);

            printf("\n\n\n\n\n\n PARNUM + PAR AUSWAHL %s %d",pars[(int)parnum],parnum);
            strcat(scriptline,"} -part xc7z020clg400-1 -top top");
            strcat(scriptline,"\n\0");
        }
        else if(strstr(scriptline,"set_property HD.RECONFIGURABLE 1 [get_cells par]"))   //TO change
        {
             scriptline[44]='\0';
            strcat(scriptline,pars[(int)parnum]);
            strcat(scriptline,"]");
            strcat(scriptline,"\n\0");
        }
        else if(strstr(scriptline,"write_bitstream -cell par"))   //TO change
        {
            scriptline[22]='\0';
            strcat(scriptline,pars[(int)parnum]);
            strcat(scriptline," ");
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"bit");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"set_property SCOPED_TO_CELLS {par} [get_files ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp]")) //to change
        {
            strcpy(scriptline,"set_property SCOPED_TO_CELLS {");

            /*
            if(par45==0)
            {
                par45++;
            }
            else
            {
                parnum=4;
                par45=0;
            }

            if(par20==0)
            {
                par20++;
            }
            else
            {
                parnum=2;
                par20=0;
            }

            if(par13==0)
            {
                par13++;
            }
            else
            {
                parnum=0;
                par13=0;
            }*/

            strcat(scriptline,pars[(int)parnum]);
            strcat(scriptline,"} [get_files ");
            //scriptline[46]='\0';
            strcat(scriptline,destpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp]");
            strcat(scriptline,"\n");

        }



        else if(strstr(scriptline,"set_property top PART1.vhd [current_fileset]")) //to change
        {
            strcpy(scriptline,"set_property top ");
            strcat(scriptline,filepath);
            strcat(scriptline,filename);
            strcat(scriptline,"[current_fileset]");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp")) //to change
        {
            strcpy(scriptline,"add_files ");
            strcat(scriptline,destpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }
        printf("%s \n", scriptline);
        fprintf(tcl->slave2,"%s",scriptline);
        fflush(tcl->slave2);
    }
    return tcl_success;
}
