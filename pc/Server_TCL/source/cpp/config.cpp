#include "../header/config.h"
#define cpath "./config.txt"

char testpath(configpath_s *config)
{
    if (0 != access(config->logpath, F_OK))
    {
        config->log=stdout;
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->logpath);
    }
    else
    {
        strcat(config->logpath,"log.txt");
        config->log=fopen(config->logpath,"w+");
        if(config->log==0)
        {
            printf("Logfile konnte nicht erstellt werden: %s",config->logpath);
            return -1;
        }
    }
    if (0 != access(config->bitoutpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->bitoutpath);
        return -1;
    }
    if (0 != access(config->constrainpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->constrainpath);
        return -1;
    }
    if (0 != access(config->dcpinpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->dcpinpath);
        return -1;
    }
    if (0 != access(config->dcpoutpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->dcpoutpath);
        return -1;
    }
    if (0 != access(config->dcpsavpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->dcpsavpath);
        return -1;
    }
    if (0 != access(config->jsonpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->jsonpath);
        return -1;
    }
    if (0 != access(config->projectpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->projectpath);
        return -1;
    }
    if (0 != access(config->reportinpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->reportinpath);
        return -1;
    }
    if (0 != access(config->reportoutpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->reportoutpath);
        return -1;
    }
    if (0 != access(config->scpbitdestpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->scpbitdestpath);
        //return -1;
    }
    if (0 != access(config->tclinpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->tclinpath);
        return -1;
    }
    if (0 != access(config->tcloutpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->tcloutpath);
        return -1;
    }
    if (0 != access(config->vhdlinpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->vhdlinpath);
        return -1;
    }
    if (0 != access(config->vhdloutpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->vhdloutpath);
        return -1;
    }
    if (0 != access(config->vivadopath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->vivadopath);
        return -1;
    }
    if (0 != access(config->entitypath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->entitypath);
        return -1;
    }

    fprintf(config->log,"HERER: %s",config->vivadologpath);

    if (0 != access(config->vivadologpath, F_OK))
    {
        fprintf(config->log,"Pfad nicht erreichbar: %s",config->vivadologpath);
        return -1;

    }
    if(strcmp(config->vivadologpath,"/dev/null"))
    {
            strcat(config->vivadologpath,"log.txt");
            fprintf(config->log,"APPEND: %s",config->vivadologpath);
    }



    return 0;
}
void getpath(char *input, char * dest)
{

    char *pointer;
    pointer=strtok(input, "=");
    pointer=strtok(NULL, "=");
    char bslh[2]="/";
    int i=strlen(pointer);
    if(pointer[i-1]!='/')
    {
        strcat(pointer,bslh);
    }
    strcpy(dest,pointer);

    if(!strcmp(dest,"/dev/null/"))
    {
        dest[strlen(dest)-1]=0;
    }
}

void getint(char *input, int * dest)
{
    char *pointer;
    pointer=strtok(input, "=");
    pointer=strtok(NULL, "=");
    sscanf(pointer,"%d",dest);
}

char getconfig(configpath *configs)
{
    configs->verbose=0;
    configs->log=stdout;
    FILE *config;
    config=fopen(cpath,"r");
    char input[256*2];
    if(config==0)
    {
        fprintf(configs->log,"Eror opening Config File at path: %s",cpath);
        return -1;
    }
    while(fscanf(config,"%s",input)!=EOF)
    {
        if(strstr(input,"device="))
        {
            getpath(input,configs->device);
        }
        else if(strstr(input,"vivadologpath="))
        {
            getpath(input,configs->vivadologpath);
        }

        else if(strstr(input,"maxportnum="))
        {
            getint(input,&(configs->maxportnum));
        }
        else if(strstr(input,"camera="))
        {
            getpath(input,configs->camerapath);
        }
        else if(strstr(input,"logpath="))
        {
            getpath(input,configs->logpath);
        }
        else if(strstr(input,"entitypath="))
        {
            getpath(input,configs->entitypath);
        }
        if(strstr(input,"vivadopath="))
        {
            getpath(input,configs->vivadopath);
        }
        else if(strstr(input,"verbose="))
        {
            getint(input,&(configs->verbose));
        }
        else if(strstr(input,"dcpsavpath="))
        {
            getpath(input,configs->dcpsavpath);
        }
        else if(strstr(input,"jsonpath="))
        {
            getpath(input,configs->jsonpath);
        }
        else if(strstr(input,"scpbitdestpath="))
        {
            getpath(input,configs->scpbitdestpath);
        }
        else if(strstr(input,"constrainpath="))
        {
            getpath(input,configs->constrainpath);
        }
        else if(strstr(input,"projectpath="))
        {
            getpath(input,configs->projectpath);
        }
        else if(strstr(input,"vhdlinpath="))
        {
            getpath(input,configs->vhdlinpath);
        }
        else if(strstr(input,"vhdloutpath="))
        {
            getpath(input,configs->vhdloutpath);
        }

        else if(strstr(input,"tclinpath="))
        {
            getpath(input,configs->tclinpath);
        }
        else if(strstr(input,"tcloutpath="))
        {
            getpath(input,configs->tcloutpath);
        }

        else if(strstr(input,"dcpinpath="))
        {
            getpath(input,configs->dcpinpath);
        }
        else if(strstr(input,"dcpoutpath="))
        {
            getpath(input,configs->dcpoutpath);
        }

        else if(strstr(input,"reportinpath="))
        {
            getpath(input,configs->reportinpath);
        }
        else if(strstr(input,"reportoutpath="))
        {
            getpath(input,configs->reportoutpath);
        }

        else if(strstr(input,"bitoutpath="))
        {
            getpath(input,configs->bitoutpath);
        }
    }
    fclose(config);

    if(testpath(configs)==-1)
    {
        return -1;
    }

    if(configs->verbose)
    {
        fprintf(configs->log,"vivadodir=%s\n",configs->vivadopath);
        fprintf(configs->log,"projectdir=%s\n",configs->projectpath);
        fprintf(configs->log,"constrainpath=%s\n",configs->constrainpath);
        fprintf(configs->log,"vhdlinpath=%s\n",configs->vhdlinpath);
        fprintf(configs->log,"vhdloutpath=%s\n",configs->vhdloutpath);
        fprintf(configs->log,"tclinpath=%s\n",configs->tclinpath);
        fprintf(configs->log,"tcloutpath=%s\n",configs->tcloutpath);
        fprintf(configs->log,"dcpinpath=%s\n",configs->dcpinpath);
        fprintf(configs->log,"dcpoutpath=%s\n",configs->dcpoutpath);
        fprintf(configs->log,"reportinpath=%s\n",configs->reportinpath);
        fprintf(configs->log,"reportoutpath=%s\n",configs->reportoutpath);
        fprintf(configs->log,"bitoutpath=%s\n",configs->bitoutpath);
        fprintf(configs->log,"logpath=%s\n",configs->logpath);
        fprintf(configs->log,"entitypath=%s\n",configs->entitypath);
        fprintf(configs->log,"maxportnum=%d\n",configs->maxportnum);
        fprintf(configs->log,"vivadologpath=%s\n\n",configs->vivadologpath);


    }
    fflush(configs->log);
    return true;
}
