#include "../header/vivado.h"

void startparvivado(configpath_s *config)
{
    char cop[256*4]=" bash -c 'cd ";
    strcat(cop,config->projectpath);
    strcat(cop," && source ");
    strcat(cop,config->vivadopath);
    strcat(cop,"settings64.sh && vivado -mode batch -source  ");
    strcat(cop,config->tcloutpath);
    //strcat(cop,"sspar.tcl '");
    strcat(cop,"sspar.tcl ");


    strcat(cop, ">> ");
    if(config->log==stdout)
    {
        fprintf(config->log,"vivado stdout\n");
        fflush(config->log);
        strcat(cop,"/dev/stdout '");
        system(cop);
    }
    else
    {
        fprintf(config->log,"vivado log\n");
        fflush(config->log);
        strcat(cop,config->vivadologpath);
        strcat(cop,"'");
        fflush(config->log);
        if(config->verbose)
        {
            fprintf(config->log,"Config log:%s\n",config->logpath);
            fflush(config->log);
        }
        //strcat(cop," && echo done ");
        fclose(config->log);
        system(cop);



        config->log=fopen(config->logpath,"a");
        if(config->log==0)
        {
            fprintf(config->log,"fatal error log not found");
            fflush(config->log);
        }
    }


}
void startwhovivado(configpath_s *config)
{
    char cop[256*2]="bash -c 'cd ";
    strcat(cop,config->projectpath);
    strcat(cop," && source ");
    strcat(cop,config->vivadopath);
    strcat(cop,"settings64.sh && vivado -mode batch -source ");
    strcat(cop,config->tcloutpath);
    //strcat(cop,"sswhole.tcl '");
    strcat(cop,"sswhole.tcl ");

    strcat(cop, ">> ");
    if(config->log==stdout)
    {
        fprintf(config->log,"vivado stdout\n");
        fflush(config->log);
        strcat(cop,"/dev/stdout '");
        system(cop);
    }
    else
    {
        fprintf(config->log,"vivado log\n");
        fflush(config->log);
        strcat(cop,config->vivadologpath);
        strcat(cop,"'");
        fflush(config->log);
        fclose(config->log);
        system(cop);
        config->log=fopen(config->logpath,"a");
        if(config->log==0)
        {
            fprintf(config->log,"fatal error log not found");
            fflush(config->log);
        }
    }

}
