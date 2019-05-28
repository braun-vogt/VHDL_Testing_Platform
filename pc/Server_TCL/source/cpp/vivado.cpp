#include "../header/vivado.h"

void startparvivado(configpath_s *config)
{
    char cop[256]=" bash -c 'cd ";
    strcat(cop,config->projectpath);
    strcat(cop," && source ");
    strcat(cop,config->vivadopath);
    strcat(cop,"settings64.sh && vivado -mode batch -source  ");
    strcat(cop,config->tcloutpath);
    strcat(cop,"sspar.tcl '");

    /*
    strdcat(cop, ">> ");
    if(config->log==stdout)
    {
        strcat(cop,'/dev/stdout ');
    }
    else
    {
        strcat(cop,config.logpath);
    }
    */
    system(cop);
}
void startwhovivado(configpath_s *config)
{
    char cop[256]="bash -c 'cd ";
    strcat(cop,config->projectpath);
    strcat(cop," && source ");
    strcat(cop,config->vivadopath);
    strcat(cop,"settings64.sh && vivado -mode batch -source ");
    strcat(cop,config->tcloutpath);
    strcat(cop,"sswhole.tcl '");
    system(cop);
}
