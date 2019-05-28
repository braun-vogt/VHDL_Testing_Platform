#include "../header/tcl.h"
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>

//char parsices[8]= {6,4,5,2,0,1,3,7};
//#ifndef pars
//#define pars
static char pars[8][256]= {"par0pm","par1pm","par2pm","par3pm","par4pm","par5pm","par6pm","par7pm"};
//#endif // pars
char init_tclfiles(tclfiles_t *tcl,configpath_s *config)
{
    strcpy(tcl->tclinpath,config->tclinpath);
    strcat(tcl->tclinpath,"synthesice_par.tcl");
    tcl->inpar=fopen(tcl->tclinpath,"r");
    if(tcl->inpar==0)
    {
        perror("Error open file synthesice_par.tcl");
        return failture_open;
    }

    strcpy(tcl->tclinpath,config->tclinpath);
    strcat(tcl->tclinpath,"synthesice_whole.tcl");
    tcl->inwho=fopen(tcl->tclinpath,"r");
    if(tcl->inwho==0)
    {
        perror("Error open file synthesice_whole.tcl");
        return failture_open;
    }

    strcpy(tcl->tcloutpath,config->tcloutpath);
    strcat(tcl->tcloutpath,"sspar.tcl");
    tcl->outpar=fopen(tcl->tcloutpath,"w+");
    if(tcl->outpar==0)
    {
        perror("Error open file sspar.tcl");
        return failture_open;
    }

    strcpy(tcl->tcloutpath,config->tcloutpath);
    strcat(tcl->tcloutpath,"sswhole.tcl");
    tcl->outwho=fopen(tcl->tcloutpath,"w+");
    if(tcl->outwho==0)
    {
        perror("Error open file sswhole.tcl");
        return failture_open;
    }

    return tcl_success;

}

char close_tclfiles(tclfiles_t *tcl)
{

    fclose(tcl->inpar);
    fclose(tcl->inwho);
    fclose(tcl->outpar);
    fclose(tcl->outwho);
    tcl->inpar=0;
    tcl->inwho=0;
    tcl->outpar=0;
    tcl->outwho=0;
    return tcl_success;
}

char modifypartcl(tclfiles_t *tcl,char *filename,configpath_s *config)
{

    char scriptline[256*2]; //temp variable for the read input
    //Set Filepointers to the beginning of the Fills
    fseek(tcl->outpar,0,SEEK_SET);
    fseek(tcl->inpar,0,SEEK_SET);

    while(fgets(scriptline,256*2,tcl->inpar)!=0)
    {

        if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc")) //TO change
        {
            scriptline[10]='\0';
            strcat(scriptline,config->constrainpath);
            strcat(scriptline,"final.xdc\n");
        }
        else if(strstr(scriptline,"write_edif ./Dokumente/git/VHDL_Testing_Platform/proj/part.edif")) //TO change
        {
            scriptline[11]='\0';
            strcat(scriptline,config->dcpoutpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"edif");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"report_utilization -file ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp")) //TO change
        {
            scriptline[25]='\0';
            strcat(scriptline,config->reportoutpath);
            strcat(scriptline,"report.txt\n");
        }
        else if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/src/hdl/PART1.vhd"))
        {
            scriptline[10]='\0';
            strcat(scriptline,config->vhdlinpath);
            strcat(scriptline,filename);
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"write_checkpoint ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp"))   //TO change
        {
            scriptline[17]='\0';
            strcat(scriptline,config->dcpoutpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"set_property top PART1.vhd [current_fileset]")) //to change
        {
            strcpy(scriptline,"set_property top ");
            strcat(scriptline,config->vhdlinpath);
            strcat(scriptline,filename);
            strcat(scriptline," [current_fileset] \n");
        }

        fprintf(tcl->outpar,"%s",scriptline);
        fflush(tcl->outpar);
    }
    return tcl_success;
}

char modifywholetcl(tclfiles_t *tcl,char *filename,configpath_s *config, char parnum)
{
    char scriptline[256*2];

    printf("PARNUM AUSWAHL %d\n",parnum);

    fseek(tcl->outwho,0,SEEK_SET);
    fseek(tcl->inwho,0,SEEK_SET);
    while(fgets(scriptline,256*2,tcl->inwho)!=0)
    {
        if(config->verbose)
        {
            printf("%s\n",scriptline);
        }
        if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc"))
        {
            scriptline[10]='\0';
            strcat(scriptline,config->constrainpath);
            strcat(scriptline,"final.xdc \n");

        }
        else if(strstr(scriptline,"update_design -cells par6pm -black_box"))
        {
            scriptline[21]='\0';
            strcat(scriptline,pars[(int) parnum]);
            strcat(scriptline," -black_box\n");

        }
        else if(strstr(scriptline,"update_design -cells par6pm -from_file ./Dokumente/git/VHDL_Testing_Platform/proj/part.edif"))
        {
            scriptline[21]='\0';
            strcat(scriptline,pars[(int) parnum]);
            strcat(scriptline," -from_file ");
            strcat(scriptline,config->dcpinpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,".vhd");
            *pointer='\0';
            strcat(scriptline,".edif\n");
        }
        else if(strstr(scriptline,"write_checkpoint –force ./Dokumente/git/VHDL_Testing_Platform/proj/part_routed.dcp"))
        {
            scriptline[17]='\0';
            strcat(scriptline,config->dcpoutpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,".vhd");
            *pointer='\0';
            strcat(scriptline,"_routed.");
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/proj/static.dcp"))
        {
            scriptline[10]='\0';
            strcat(scriptline,config->dcpoutpath);
            strcat(scriptline,"static.dcp");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"link_design -mode default -reconfig_partitions {part1} -part xc7z020clg400-1 -top top"))
        {
            scriptline[48]='\0';
            strcat(scriptline,pars[(int)parnum]);

            printf("\n\n\n\n\n\n PARNUM + PAR AUSWAHL %s %d",pars[(int)parnum],parnum);
            strcat(scriptline,"} -part xc7z020clg400-1 -top top");
            strcat(scriptline,"\n\0");
        }
        else if(strstr(scriptline,"set_property HD.RECONFIGURABLE 1 [get_cells par]"))
        {
             scriptline[44]='\0';
            strcat(scriptline,pars[(int)parnum]);
            strcat(scriptline,"]");
            strcat(scriptline,"\n\0");
        }
        else if(strstr(scriptline,"write_bitstream -cell par"))
        {
            scriptline[22]='\0';
            strcat(scriptline,pars[(int)parnum]);
            strcat(scriptline," ");
            strcat(scriptline,config->bitoutpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"bit");
            strcat(scriptline,"\n");
        }
        else if(strstr(scriptline,"set_property SCOPED_TO_CELLS {par} [get_files ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp]"))
        {
            strcpy(scriptline,"set_property SCOPED_TO_CELLS {");
            strcat(scriptline,pars[(int)parnum]);
            strcat(scriptline,"} [get_files ");
            //scriptline[46]='\0';
            strcat(scriptline,config->dcpoutpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp]");
            strcat(scriptline,"\n");

        }
        else if(strstr(scriptline,"add_files ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp"))
        {
            strcpy(scriptline,"add_files ");
            strcat(scriptline,config->dcpoutpath);
            strcat(scriptline,filename);
            char* pointer=strstr(scriptline,"vhd");
            *pointer='\0';
            strcat(scriptline,"dcp");
            strcat(scriptline,"\n");
        }

        else if(strstr(scriptline,"set_property USED_IN {implementation} [get_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc]"))
        {
            strcpy(scriptline,"set_property USED_IN {implementation} [get_files ");
            strcat(scriptline,config->constrainpath);
            strcat(scriptline,"final.xdc] \n");
        }
        printf("%s \n", scriptline);
        fprintf(tcl->outwho,"%s",scriptline);
        fflush(tcl->outwho);
    }
    return tcl_success;
}
