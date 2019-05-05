#include "/home/pfirsichgnom/Dokumente/Codeblocks/Server_TCL/source/header/fileset.h"


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
char filefertig=0;

char init_files(files_t *fileset, char *path, char *fertigpath)
{
    DIR *d;
    struct dirent *dir;
    d=opendir(path);
    char errorcode;
    if(d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            //printf("%s\n",dir->d_name);
            errorcode=resize_fileset(fileset,dir->d_name);
            if(errorcode!=success)
            {
                closedir(d);
                return errorcode;
            }
        }
        closedir(d);
    }
    if(filefertig!=1)
    {
        printf("erzeuge ordner für abgearbeitete datein");

        char hilf[256]="cd ";
        strcat(hilf,fertigpath);

        strcat(hilf,"&& mkdir ./fertig");
        system(hilf);
    }
    /*printf("input fileset:\n");
    for(int i=0; i<fileset->filenum; i++)
    {
        printf("%s\n",fileset->file[i]);
        fflush(stdout);
    }
    printf("\n");*/
    return success;
}

char resize_fileset(files_t *fileset,char* dirname)
{

    files_t hilf;
    char *hilfc;
    if(strstr(dirname,"fertig"))
    {
        filefertig=1;
    }
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
                printf("lost remalloc");
                return error_realloc;
            }
            else
            {
                fileset->file=hilf.file;
            }
            hilfc=(char*)malloc(fnlm*sizeof(char));
            if(hilf.file==0)
            {
                printf("lost malloc");
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



char init_portset(files_t *fileset, char *dir)
{
    char home[256];
    strcpy(home,dir);

    char ports[256*2];
    int num=0;
    num=fileset->filenum;
    char error;

    for(int i=0; i<fileset->filenum; i++)
    {
        fileset->vhd=fopen(strcat(home,fileset->file[i]),"r");
        if(fileset->vhd==0)
        {
            perror("error fileset");
            printf("%s",home);
            fflush(stdout);
            return error_openfile;
        }
        while(fgets(ports,256,fileset->vhd)!=0)
        {

            error=resize_portset(fileset,analyce_ports(ports),fileset->file[i]);
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
        strcpy(home,dir);
        fclose(fileset->vhd);
    }
    return success;
}

char ports_file(files_t *fileset,int filenum,int *portnum, char *dir, char ports[][256])
{
    char home[256];
    strcpy(home,dir);

    char portsread[256*2];
    int i=0;
    fileset->vhd=fopen(strcat(home,fileset->file[filenum]),"r");
    if(fileset->vhd==0)
    {
        perror("error fileset");
        printf("%s",home);
        fflush(stdout);
        return error_openfile;
    }
    while(fgets(portsread,256,fileset->vhd)!=0)
    {

        if((strcmp(analyce_ports(portsread),"IGNORE")!=0))
        {
            printf("\nPORT %s \n",portsread);
            strcpy(ports[i],portsread);
            i++;
        }

    }

    fclose(fileset->vhd);
    *portnum=i;
    return success;
}


char resize_portset(files_t *fileset, char *portname,char *file)
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
                    printf("resice port malloc error");
                    return error_realloc;
                }

                hilfc=(char*)calloc(fnlm,sizeof(char));
                if(hilfc!=0)
                {
                    fileset->ports[fileset->portsnum-1]=hilfc;
                }
                else
                {
                    printf("resice port calloc error");
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
                    printf("%s %ld",fileset->file[i],fileset->filenum);
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

char *analyce_ports(char* portline)
{
    for(int i = 0; i < 256; i++)
    {
        portline[i] = toupper(portline[i]);
    }
    if(strstr(portline,"PMOD_JB_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JB_IN");
        return portline;
    }
    else if(strstr(portline,"PMOD_JB_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JB_OUT");
        return portline;
    }
    else if(strstr(portline,"PMOD_JB_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JB_OE");
        return portline;
    }
    else if(strstr(portline,"PMOD_JC_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JC_IN");
        return portline;
    }
    else if(strstr(portline,"PMOD_JC_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JC_OUT");
        return portline;
    }
    else if(strstr(portline,"PMOD_JC_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JC_OE");
        return portline;
    }
    else if(strstr(portline,"PMOD_JD_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JD_IN");
        return portline;
    }
    else if(strstr(portline,"PMOD_JD_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JD_OUT");
        return portline;
    }
    else if(strstr(portline,"PMOD_JD_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JD_OE");
        return portline;
    }
    else if(strstr(portline,"PMOD_JE_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JE_IN");
        return portline;
    }
    else if(strstr(portline,"PMOD_JE_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JE_OUT");
        return portline;
    }
    else if(strstr(portline,"PMOD_JE_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)"))
    {
        strcpy(portline,"PMOD_JE_OE");
        return portline;
    }
    else if(strstr(portline,"RGB_LED : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)"))
    {
        strcpy(portline,"RGB_LED");
        return portline;
    }
    else if(strstr(portline,"RGB_LED2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)"))
    {
        strcpy(portline,"RGB_LED2");
        return portline;
    }
    else if(strstr(portline,"LEDS : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)"))
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
    else if(strstr(portline," UART_ZYNQ_RXD : OUT STD_LOGIC;"))
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

char modifyentity(files_t *fileset, char* filename, char *path)
{
    for(int i=0; i<fileset->filenum; i++)
    {
        if(!strcmp(filename,fileset->file[i]))
        {
            char hilf[256]="\0";
            FILE* vhd;
            strcat(hilf,path);
            strcat(hilf,filename);
            vhd=fopen(hilf,"r+");
            if(vhd==0)
            {
                printf("%s",hilf);
                perror("VHD File nicht edditierbar");
                return error_openfile;
            }
            fseek(vhd,0,SEEK_SET);
            long foundbegent=0;
            long foundendent=0;

            while(fgets(hilf,256,vhd)!=0)
            {
                for(int i = 0; i < 256; i++)
                {
                    hilf[i] = toupper(hilf[i]);
                }
                if(strstr(hilf,"PORT"))
                {
                    foundbegent=ftell(vhd);
                }
                if(strstr(hilf,"END"))
                {
                    foundendent=ftell(vhd);
                }
            }

            if(foundendent && foundbegent)
            {
                fseek(vhd,foundbegent,SEEK_SET);
                fprintf(vhd,"%s",entitys);
            }
        }
    }
    return success;
}

char finishfiles()
{

    return success;
}
