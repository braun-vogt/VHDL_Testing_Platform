#ifndef WAITER_H_INCLUDED
#define WAITER_H_INCLUDED
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/inotify.h>
#include <unistd.h>
#include "./config.h"

#define all IN_ACCESS | IN_ATTRIB | IN_CLOSE_WRITE | IN_CLOSE_NOWRITE | IN_CREATE | IN_DELETE | IN_DELETE_SELF | IN_MODIFY | IN_MOVE_SELF | IN_MOVED_FROM | IN_MOVED_TO | IN_OPEN
#define events  IN_CREATE | IN_DELETE | IN_DELETE_SELF | IN_MODIFY | IN_MOVE_SELF | IN_MOVED_FROM | IN_MOVED_TO


char waitfornewfiles(configpath_s config);
char removewatch();

#endif // WAITER_H_INCLUDED
