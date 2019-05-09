#ifndef VIVADO_LOG_PARSER_H_INCLUDED
#define VIVADO_LOG_PARSER_H_INCLUDED
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>

typedef struct parres_s
{
    long LUTS;
    long SLICES;
    long RAM;
    long DSP;
} parres_t;


typedef struct resources_s
{
    long LUTS;
    long SLICES;
    long RAM;
    long DSP;
} resources_t;

void selectpar(resources_t *res,char *parnum);
char parselog(resources_t *res,char *logpath, char *parnum);
char changeparnum(char parnum);

#endif // VIVADO_LOG_PARSER_H_INCLUDED
