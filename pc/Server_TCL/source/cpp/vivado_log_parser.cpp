#include "../header/vivado_log_parser.h"
//           LUTS SLICE RAM DSP
parres_t par6= {2400,4800,0,0};

parres_t par4= {2400,4800,10,0};
parres_t par5= {2400,4800,10,0};

parres_t par2= {3600,7200,10,0};
parres_t par0= {3600,7200,10,0};

parres_t par1= {4000,8000,10,0};
parres_t par3= {4000,8000,10,0};

parres_t par7= {12000,24000,30,40};

char parsices[8]= {6,4,5,2,0,1,3,7};

#define debug

char parselog(resources_t *res,configpath_s *config, char *parnum)
{

    if(config->verbose)
    {
        fprintf(config->log,"\n Logpath :%s\n",config->reportinpath);
        fflush(config->log);
    }

    FILE *LOGFILE;
    char log[500]="";
    strcpy(log,config->reportinpath);
    strcat(log,"report.txt");
    LOGFILE=fopen(log,"r");
    if(LOGFILE==0)
    {
        perror("Error open logfile");
        return -1;
    }

    while(fgets(log,256*2,LOGFILE)!=0)
    {
        if(strstr(log,"| Slice LUTs*             |"))
        {
            for(int i=27; i<35; i++)
            {
                log[i-27]=log[i];
            }
            log[35]='\0';
            sscanf(log,"%ld",&(res->LUTS));
            fprintf(config->log,"LUTS: %ld\n",res->LUTS);
            fflush(config->log);
        }

        if(strstr(log,"| Slice Registers         |"))
        {
            for(int i=28; i<33; i++)
            {
                log[i-28]=log[i];
            }
            log[33]='\0';
            sscanf(log,"%ld",&(res->SLICES));
            fprintf(config->log,"SLICES: %ld\n",res->SLICES);
            fflush(config->log);
        }

        if(strstr(log,"|   RAMB36/FIFO* |"))
        {
            for(int i=18; i<25; i++)
            {
                log[i-18]=log[i];
            }
            log[25]='\0';
            sscanf(log,"%ld",&(res->RAM));
            fprintf(config->log,"RAM: %ld\n",res->RAM);
            fflush(config->log);
        }
        if(strstr(log,"| DSPs      |"))
        {
            for(int i=13; i<20; i++)
            {
                log[i-13]=log[i];
            }
            log[20]='\0';

            sscanf(log,"%ld",&(res->DSP));
            fprintf(config->log,"DSP: %ld\n",res->DSP);
            fflush(config->log);
        }
    }
    selectpar(res,parnum);
    if(*parnum==-1)
    {
        fprintf(config->log,"unroutable");
        fflush(config->log);
        return -1;
    }

    printf("Partieles file %d \n",*parnum);
    return 1;
}

void selectpar(resources_t *res,char *parnum)
{
    if((res->LUTS<par6.LUTS || res->SLICES<par6.SLICES) && res->RAM==par6.RAM && res->DSP==par6.DSP )
    {
        *parnum=6;
    }
    else if ((res->LUTS<par5.LUTS || res->SLICES<par5.SLICES) && res->RAM<=par5.RAM &&res->DSP<=par5.DSP  )
    {
        *parnum=5;
    }
    else if ((res->LUTS<par2.LUTS || res->SLICES<par2.SLICES)  && res->RAM<=par2.RAM &&res->DSP<=par2.DSP)
    {
        *parnum=2;
    }
    else if ((res->LUTS<par1.LUTS || res->SLICES<par1.SLICES)  && res->RAM<=par1.RAM &&res->DSP<=par1.DSP)
    {
        *parnum=1;
    }
    else if ((res->LUTS<par7.LUTS || res->SLICES<par7.SLICES)  && res->RAM<=par7.RAM &&res->DSP<=par7.DSP)
    {
        *parnum=7;
    }
    else
    {
        *parnum= -1;
    }
}
char changeparnum(char parnum)
{
    int i=0;
    for(i=0; i<8; i++)
    {
        if(parnum==parsices[i])
        {

            break;
        }
    }
    if(i<7)
    {
        return parsices[i+1];
    }
    else
    {
        return -1;
    }

}
