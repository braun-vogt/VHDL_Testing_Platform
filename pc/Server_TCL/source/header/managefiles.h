#ifndef managefiles
#define managefiles 1
#include "../header/fileset.h"
#include "../header/config.h"


void movefinishedfiles(files_t fileset, configpath_s config, int currentfile);
char managebitfiles(configpath_s *config, files_t *fileset, int currentfile);
#endif
