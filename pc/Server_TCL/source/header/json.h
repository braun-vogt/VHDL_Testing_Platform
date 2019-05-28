#ifndef json
#define json 1
#include <stdlib.h>
#include <stdio.h>
#include <json-c/json.h>
#include <string.h>
#include "../header/config.h"
#include "../header/fileset.h"

typedef struct json_s {
	char user[256];
	char design[256];
	int pblock;
	char peripheral[7][256];
	int peripheral_count;
	int pins[32];
	int pin_count;
} json_t;

void parse_json(json_t content[8], const char *file);
void add_user_json(json_t new_user, const char *file);
void addconnections(json_t *config,char connections[][256],int concount,configpath_s conf);
void add_new_json(json_t new_user, const char *file);
void filljson(configpath_s *config, files_t *fileset,json_t *new_user, int currentfile, char *fset, char parnum);
#endif
