#ifndef CONFIG_H_INCLUDED
#define CONFIG_H_INCLUDED
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <stddef.h>
#include <unistd.h>
#include <pthread.h>

typedef struct configpath_s
{
    int maxportnum;
    char vivadologpath[256];
    char device[256];

    char entitypath[2048];

    FILE * log;
    char logpath[256];

    char vivadopath[256];

    char projectpath[256];

    char vhdlinpath [256];
    char vhdloutpath [256];

    char tclinpath [256];
    char tcloutpath [256];

    char reportoutpath[256];
    char reportinpath[256];

    char dcpinpath[256];
    char dcpoutpath[256];
    char dcpsavpath[256];

    char bitoutpath[256];

    char scpbitdestpath[256];

    char constrainpath[256];

    char jsonpath[256];

    int verbose;

    char camerapath[1024];

}configpath;

char getconfig(configpath *config);

#endif // FILESET_H_INCLUDED
