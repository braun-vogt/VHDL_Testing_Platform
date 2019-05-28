#ifndef FILESET_H_INCLUDED
#define FILESET_H_INCLUDED
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#define fnlm 256
const char entitys[1800]="CLK_MMC : IN STD_LOGIC; \n CLK_PLL : IN STD_LOGIC; \n RST : IN STD_LOGIC; \n PMOD_JB_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); \n  PMOD_JB_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); \n  PMOD_JB_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); \n  PMOD_JC_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); \n  PMOD_JC_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); \n PMOD_JC_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); \n  PMOD_JD_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); \n  PMOD_JD_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); \n  PMOD_JD_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); \n PMOD_JE_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); \n PMOD_JE_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); \n  PMOD_JE_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); \n  RGB_LED : OUT STD_LOGIC_VECTOR (2 DOWNTO 0); \n RGB_LED2 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0); \n UART_ZYNQ_rxd : in STD_LOGIC; \n UART_ZYNQ_txd : out STD_LOGIC; \n GPIO_PART_Input : in STD_LOGIC_VECTOR (31 DOWNTO 0); \n GPIO_PART_Output : out STD_LOGIC_VECTOR (31 DOWNTO 0); \n IIC_ZYNQ_sda_i : in STD_LOGIC; \n IIC_ZYNQ_sda_o : out STD_LOGIC; \n IIC_ZYNQ_scl_i : in STD_LOGIC; \n IIC_ZYNQ_scl_o : out STD_LOGIC";
typedef struct file_s
{
    char** file;
    long filenum;
    char** ports;
    long portsnum;
    FILE *vhd;
} files_t;

enum
{
    success,
    error_malloc,
    error_realloc,
    error_delete,
    error_free,
    error_openfile
};

char init_fileset(files_t *fileset);
char init_files(files_t *fileset, char *path,char *fertigpath);
char init_portset(files_t *fileset,char *dir);
char resize_fileset(files_t *fileset,char* dirname);
char ports_file(files_t *fileset,int filenum,int *portnum, char *dir, char ports[][256]);

char containsport(files_t *fileset,const char *port);
void free_fileset(files_t *fileset );
char *analyce_ports(char* portline);
char resize_portset(files_t *fileset, char *portname,char *file);
char  remove_element(files_t *fileset, int i);
char modifyentity(files_t *fileset, char *filename,char *path);


#endif // FILESET_H_INCLUDED
