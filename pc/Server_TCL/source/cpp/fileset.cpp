#include "../header/fileset.h"

//#ifndef pars
//#define pars
static char pars[8][256]= {"par0pm","par1pm","par2pm","par3pm","par4pm","par5pm","par6pm","par7pm"};
//#endif // pars

char init_fileset(files_t *fileset)
{
    fileset->file=(char**)malloc(sizeof(char*));
    fileset->file[0]=(char*)malloc(sizeof(char)*fnlm);

    fileset->ports=(char**)malloc(sizeof(char*));
    fileset->ports[0]=(char*)malloc(sizeof(char)*fnlm);

    fileset->filenum=0;
    fileset->portsnum=0;
    return success;
}
char reinit_files(files_t *fileset)
{
    fileset->file=(char**)malloc(sizeof(char*));
    fileset->file[0]=(char*)malloc(sizeof(char)*fnlm);
    fileset->filenum=0;
    return success;
}

char init_files(files_t *fileset, configpath_s *config)
{
    DIR *d;
    struct dirent *dir;
    d=opendir(config->vhdlinpath);
    char errorcode;

    if(d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            errorcode=resize_fileset(fileset,dir->d_name,*config);
            if(errorcode!=success)
            {
                closedir(d);
                return errorcode;
            }
        }
        closedir(d);
    }
    if(0 != access(config->vhdloutpath, F_OK))
    {
        fprintf(config->log,"erzeuge ordner für abgearbeitete datein");
        fflush(config->log);

        char hilf[256]="cd ";
        strcat(hilf,config->vhdloutpath);

        strcat(hilf,"&& mkdir ./fertig");
        system(hilf);
    }

    if(config->verbose)
    {
        fprintf(config->log,"input fileset:\n");
        fflush(config->log);
        for(int i=0; i<fileset->filenum; i++)
        {
            fprintf(config->log,"%s\n",fileset->file[i]);
            fflush(config->log);
            fflush(stdout);
        }
        printf("\n");
    }
    return success;
}

char resize_fileset(files_t *fileset,char* dirname, configpath_s config)
{

    files_t hilf;
    char *hilfc;
    if(strstr(dirname,".vhd"))
    {
        if(fileset->filenum==0)
        {
            strcpy(fileset->file[0],dirname);
            fileset->filenum++;
        }
        else
        {
            fileset->filenum++;
            hilf.file=(char**)realloc(fileset->file,fileset->filenum*sizeof(char*));
            if(hilf.file==0)
            {
                fprintf(config.log,"lost remalloc");
                fflush(config.log);
                return error_realloc;
            }
            else
            {
                fileset->file=hilf.file;
            }
            hilfc=(char*)malloc(fnlm*sizeof(char));
            if(hilf.file==0)
            {
                fprintf(config.log,"lost malloc");
                fflush(config.log);
                return error_malloc;
            }
            else
            {
                fileset->file[fileset->filenum-1]=hilfc;
            }

            strcpy(fileset->file[fileset->filenum-1],dirname);
        }
    }
    return success;
}


char init_portset(files_t *fileset, configpath_s *config)
{
    char home[256];
    strcpy(home,config->vhdlinpath);

    char ports[256*2];
    int num=0;
    num=fileset->filenum;
    char error;

    for(int i=0; i<fileset->filenum; i++)
    {
        fileset->vhd=fopen(strcat(home,fileset->file[i]),"r");
        if(fileset->vhd==0)
        {
            fprintf(config->log,"error init fileset %s", strerror(errno));
            fprintf(config->log,"%s",home);
            fflush(config->log);
            fflush(stdout);
            return error_openfile;
        }
        while(fgets(ports,256,fileset->vhd)!=0)
        {

            error=resize_portset(fileset,analyce_ports(ports),fileset->file[i],config);
            if(error!=success)
            {
                return error;
            }
            if(fileset->filenum!=num)
            {
                num=fileset->filenum;
                i--;
                break;
            }
        }
        strcpy(home,config->vhdlinpath);
        fclose(fileset->vhd);
    }
    return success;
}

char ports_file(files_t *fileset,int filenum,int *portnum, configpath_s *config, char ports[][256])
{
    char home[256];
    strcpy(home,config->vhdlinpath);

    char portsread[256*2];
    int i=0;
    fileset->vhd=fopen(strcat(home,fileset->file[filenum]),"r");
    if(fileset->vhd==0)
    {
        fprintf(config->log,"error init fileset %s", strerror(errno));
        fprintf(config->log,"%s",home);
        fflush(config->log);
        return error_openfile;
    }
    while(fgets(portsread,256,fileset->vhd)!=0)
    {

        if((strcmp(analyce_ports(portsread),"IGNORE")!=0))
        {
            fprintf(config->log,"\nPORT %s \n",portsread);
            fflush(config->log);
            strcpy(ports[i],portsread);
            i++;
        }
    }

    fclose(fileset->vhd);
    *portnum=i;
    return success;
}


//Analyses used ports in current fileset
char ports_file_num(files_t *fileset,int filenum,int *portnum, configpath_s *config, char ports[][256],int *pinnum,int *anzahl)
{
    char home[256];
    strcpy(home,config->vhdloutpath);
    strcat(home,fileset->file[filenum]);

    strtok(home,".");
    strcat(home,"_original.vhdl");


    char portsread[256*2];
    int i=0;
    int hilf=0;
    fileset->vhd=fopen(home,"r");
    if(fileset->vhd==0)
    {
        fprintf(config->log,"error init portfile %s", strerror(errno));
        fprintf(config->log,"%s",home);
        fflush(config->log);
        return error_openfile;
    }
    while(fgets(portsread,256,fileset->vhd)!=0)
    {
        for(int k=0;k<256*2;k++)
        {
            portsread[k] = toupper(portsread[k]);
        }
        if(strstr(portsread,"PAR_TEST_GPIO0_IN : IN STD_LOGIC_VECTOR")!=0)
        {
            int from=0,to=0;
            char temp[256];
            sscanf(portsread,"%*[^0-9]%d %s %d ",&to,temp,&from);
            fprintf(config->log,"GPIO IN from: %d to %d\n",from,to);
            fflush(config->log);

            if(to<from)
            {
                if(from-to>hilf)
                {
                    hilf=0;
                    for(to=to; to<=from; to++)
                    {
                        pinnum[hilf]=to;
                        hilf++;
                    }
                }
            }
            else if(to>from)
            {
                if(to-from>hilf)
                {
                    hilf=0;
                    for(to=to; to>=from; to--)
                    {
                        pinnum[hilf]=to;
                        hilf++;
                    }
                }
            }
            else
            {
                if(hilf<1)
                {
                    pinnum[hilf]=to;
                    hilf++;
                }

            }
        }
        else if(strstr(portsread,"PAR_TEST_GPIO0_OUT : OUT STD_LOGIC_VECTOR")!=0)
        {
            int from=0,to=0 ;

            fprintf(config->log,"DRINNEN GPIO_OUT\n");
            fflush(config->log);
            sscanf(portsread,"%*[^0-9]%d %*[^0-9]%d ",&to,&from);
            fprintf(config->log,"GPIO OUT from: %d to %d\n",from,to);
            fflush(config->log);

            if(to<from)
            {
                if(from-to>hilf)
                {
                    hilf=0;
                    for(to=to; to<=from; to++)
                    {
                        pinnum[hilf]=to;
                        hilf++;
                    }
                }
            }
            else if(to>from)
            {
                if(to-from>hilf)
                {
                    hilf=0;
                    for(to=to; to>=from; to--)
                    {
                        pinnum[hilf]=to;
                        hilf++;
                    }
                }
            }
            else
            {
                if(hilf<0)
                {
                    pinnum[hilf]=to;
                    hilf++;
                }
            }
        }

        if((strcmp(analyce_ports(portsread),"IGNORE")!=0))
        {
            fprintf(config->log,"\nPORT %s \n",portsread);
            fflush(config->log);
            strcpy(ports[i],portsread);
            i++;
        }
        *anzahl=hilf;

    }

    fclose(fileset->vhd);
    *portnum=i;
    return success;
}



char resize_portset(files_t *fileset, char *portname,char *file, configpath_s *config)
{
    char resice=true;
    files_t hilf;
    char *hilfc;

    if(!(strstr(portname,"IGNORE")))
    {
        for(int i=0; i<fileset->portsnum; i++)
        {
            if(!(strstr(fileset->ports[i],portname)))
            {
                ;
            }
            else
            {
                resice=false;
            }
        }
        if(resice)
        {
            if(fileset->portsnum==0)
            {
                strcpy(fileset->ports[0],portname);
                fileset->portsnum++;
            }
            else
            {
                fileset->portsnum++;
                hilf.ports=(char**)realloc(fileset->ports,fileset->portsnum*sizeof(char*));
                if(hilf.ports!=0)
                {
                    fileset->ports=hilf.ports;
                }
                else
                {
                    fprintf(config->log,"resice port malloc error");
                    fflush(config->log);
                    return error_realloc;
                }

                hilfc=(char*)calloc(fnlm,sizeof(char));
                if(hilfc!=0)
                {
                    fileset->ports[fileset->portsnum-1]=hilfc;
                }
                else
                {
                    fprintf(config->log,"resice port calloc error");
                    fflush(config->log);
                    return error_malloc;
                }
                strcpy(fileset->ports[fileset->portsnum-1],portname);
            }
        }
        else
        {
            for(int i=0; i<fileset->filenum; i++)
            {

                if(strstr(fileset->file[i],file))
                {
                    fflush(stdout);
                    remove_element(fileset, i);
                }
            }
        }
    }
    return success;
}
char remove_element(files_t *fileset, int i)
{
    for(int a=i; a<fileset->filenum-1; a++)
    {
        strcpy(fileset->file[a],fileset->file[a+1]);
    }
    free(fileset->file[fileset->filenum-1]);
    fileset->filenum--;
    return success;
}

void free_fileset(files_t *fileset )
{
    for(int i=0; i<fileset->filenum; i++)
    {
        free(fileset->file[i]);
    }
    free(fileset->file);
    for(int i=0; i<fileset->portsnum; i++)
    {
        free(fileset->ports[i]);
    }
    free(fileset->ports);
}


void removeSpaces(char *input)
{

    int hilf = 0;

    for (int i = 0; input[i]; i++)
    {
        if (input[i] != ' ')
        {
            input[hilf++] = input[i];
        }
    }
    input[hilf] = '\0';
}

char *analyce_ports(char* portline)
{
    for(int i = 0; i < 256; i++)
    {
        portline[i] = toupper(portline[i]);
    }

    if(strstr(portline,"PMOD_JB_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JB_IN");
        return portline;
    }
    else if(strstr(portline,"PMOD_JB_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JB_OUT");
        return portline;
    }
    else if(strstr(portline,"PMOD_JB_OE : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JB_OE");
        return portline;
    }
    else if(strstr(portline,"PMOD_JC_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JC_IN");
        return portline;
    }
    else if(strstr(portline,"PMOD_JC_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JC_OUT");
        return portline;
    }
    else if(strstr(portline,"PMOD_JC_OE : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JC_OE");
        return portline;
    }
    else if(strstr(portline,"PMOD_JD_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JD_IN");
        return portline;
    }
    else if(strstr(portline,"PMOD_JD_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JD_OUT");
        return portline;
    }
    else if(strstr(portline,"PMOD_JD_OE : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JD_OE");
        return portline;
    }
    else if(strstr(portline,"PMOD_JE_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JE_IN");
        return portline;
    }
    else if(strstr(portline,"PMOD_JE_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JE_OUT");
        return portline;
    }
    else if(strstr(portline,"PMOD_JE_OE : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JE_OE");
        return portline;
    }
    else if(strstr(portline,"RGB_LED2 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)"))
    {
        strcpy(portline,"RGB_LED2");
        return portline;
    }
    else if(strstr(portline,"RGB_LED : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)"))
    {
        strcpy(portline,"RGB_LED1");
        return portline;
    }
    else if(strstr(portline,"LEDS : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)"))
    {
        strcpy(portline,"LEDS");
        return portline;
    }
    else if(strstr(portline," CLK_MMC : IN STD_LOGIC_VECTOR ( 0 to 0 )"))
    {
        strcpy(portline,"CLK_MMC");
        return portline;
    }
    else if(strstr(portline,"CLK_PLL : IN STD_LOGIC_VECTOR ( 0 to 0 )"))
    {
        strcpy(portline,"CLK_PLL");
        return portline;
    }
    else if(strstr(portline,"UART_ZYNQ_TXD : IN STD_LOGIC;"))
    {
        strcpy(portline,"UART_ZYNQ_TXD");
        return portline;
    }
    else if(strstr(portline,"UART_ZYNQ_RXD : OUT STD_LOGIC;"))
    {
        strcpy(portline," UART_ZYNQ_RXD");
        return portline;
    }
    else
    {
        strcpy(portline,"IGNORE");
        return portline;
    }
}

char containsport(files_t *fileset,const char *port)
{
    for(int i=0; i<fileset->portsnum; i++)
    {
        if(strcmp(fileset->ports[i],port)==0)
        {
            return true;
        }
    }
    return false;
}

char modifyentity(files_t *fileset, int currentfile, configpath_s config)
{
    char hilf[256*2]="";
    bool startwriting=false;

    FILE* inputfile;
    strcat(hilf,config.vhdlinpath);
    strcat(hilf,fileset->file[currentfile]);
    inputfile=fopen(hilf,"r");

    if(config.verbose)
    {
        fprintf(config.log,"\nInput File for Modify entity :%s \n",fileset->file[currentfile]);
    }

    if(inputfile==0)
    {
        fprintf(config.log,"VHD InputFile nicht lesbar modentity %s\n", strerror(errno));
        fprintf(config.log,"%s\n",hilf);
        fflush(config.log);

        return error_openfile;
    }


    hilf[0]='\0';
    FILE *entityfile;
    strcat(hilf,config.entitypath);
    strcat(hilf,"entity.txt");
    entityfile=fopen(hilf,"r");

    if(entityfile==0)
    {
        fprintf(config.log,"VHD Entityfile nicht lesbar %s\n", strerror(errno));
        fprintf(config.log,"%s\n",hilf);
        fflush(config.log);
        return error_openfile;
    }


    hilf[0]='\0';
    FILE *outputfile;
    strcat(hilf,config.vhdloutpath);
    strcat(hilf,fileset->file[currentfile]);
    outputfile=fopen(hilf,"w+");

    if(outputfile==0)
    {
        fprintf(config.log,"VHD OutputFile nicht schreibbar%s\n", strerror(errno));
        fprintf(config.log,"%s\n",hilf);
        fflush(config.log);
        return error_openfile;
    }

    fseek(inputfile,0,SEEK_SET);

    while(fgets(hilf,256*2,entityfile)!=0)
    {
        fputs(hilf,outputfile);
    }

    while(fgets(hilf,256*2,inputfile)!=0)
    {
        if(!startwriting)
        {
            for(int i = 0; i < 256*2; i++)
            {
                hilf[i] = toupper(hilf[i]);
            }
        }
        if(startwriting)
        {
            fputs(hilf,outputfile);
        }

        if(strstr(hilf,"END"))
        {
            startwriting=true;
        }
    }
    fclose(inputfile);
    fclose(entityfile);
    fflush(outputfile);
    fclose(outputfile);

    strcpy(hilf,"cp ");
    strcat(hilf,config.vhdlinpath);
    strcat(hilf,fileset->file[currentfile]);
    strcat(hilf," ");
    strcat(hilf,config.vhdloutpath);

    char hilf2[256];
    strcpy(hilf2,fileset->file[currentfile]);
    strtok(hilf2,".");
    strcat(hilf2,"_original.vhdl\n");
    strcat(hilf,hilf2);

    if(config.verbose)
    {
        fprintf(config.log,"Writing copy from original to : %s\n",hilf);
        fflush(config.log);
    }
    system(hilf);

    strcpy(hilf,"mv ");
    strcat(hilf,config.vhdloutpath);
    strcat(hilf,fileset->file[currentfile]);
    strcat(hilf," ");
    strcat(hilf,config.vhdlinpath);
    system(hilf);

    if(config.verbose)
    {
        fprintf(config.log,"Mov finished entity from to : %s \n",hilf);
        fflush(config.log);
    }

    return success;
}



char modifyentitypar(files_t *fileset, int currentfile, configpath_s config, char parnum)
{
    char hilf[256*2]="";
    bool startwriting=false;

    FILE* inputfile;
    strcat(hilf,config.vhdlinpath);
    strcat(hilf,fileset->file[currentfile]);
    inputfile=fopen(hilf,"r");

    if(inputfile==0)
    {
        fprintf(config.log,"VHD InputFile nicht lesbar modparentity %s \n", strerror(errno));
        fprintf(config.log,"%s\n",hilf);
        fflush(config.log);
        return error_openfile;
    }


    hilf[0]='\0';
    FILE *entityfile;
    strcat(hilf,config.entitypath);
    strcat(hilf,pars[(int)parnum]);
    strcat(hilf,".txt");
    entityfile=fopen(hilf,"r");

    if(entityfile==0)
    {
        fprintf(config.log,"VHD Entityfile nicht lesbar %s \n", strerror(errno));
        fprintf(config.log,"%s\n",hilf);
        fflush(config.log);
        return error_openfile;
    }


    hilf[0]='\0';
    FILE *outputfile;
    strcat(hilf,config.vhdloutpath);
    strcat(hilf,fileset->file[currentfile]);
    outputfile=fopen(hilf,"w+");

    if(outputfile==0)
    {
        fprintf(config.log,"VHD OutputFile nicht schreibbar %s \n", strerror(errno));
        fprintf(config.log,"%s\n",hilf);
        fflush(config.log);
        return error_openfile;
    }

    fseek(inputfile,0,SEEK_SET);

    while(fgets(hilf,256*2,entityfile)!=0)
    {
        fputs(hilf,outputfile);
    }

    while(fgets(hilf,256*2,inputfile)!=0)
    {
        if(!startwriting)
        {
            for(int i = 0; i < 256*2; i++)
            {
                hilf[i] = toupper(hilf[i]);
            }
        }
        if(startwriting)
        {
            fputs(hilf,outputfile);
        }

        if(strstr(hilf,"END"))
        {
            startwriting=true;
        }
    }
    fclose(inputfile);
    fclose(entityfile);
    fflush(outputfile);
    fclose(outputfile);

    /*strcpy(hilf,"cp ");
    strcat(hilf,config.vhdlinpath);
    strcat(hilf,fileset->file[currentfile]);
    strcat(hilf," ");
    strcat(hilf,config.vhdloutpath);
    strcat(hilf,strtok(fileset->file[currentfile],"."));
    strcat(hilf,"_original.vhdl");
    system(hilf);*/

    strcpy(hilf,"mv ");
    strcat(hilf,config.vhdloutpath);
    strcat(hilf,fileset->file[currentfile]);
    strcat(hilf," ");
    strcat(hilf,config.vhdlinpath);
    system(hilf);

    if(config.verbose)
    {
        fprintf(config.log,"Mov finished entity from to : %s \n",hilf);
        fflush(config.log);
    }
    return success;
}


char finishfiles()
{
    return success;
}
