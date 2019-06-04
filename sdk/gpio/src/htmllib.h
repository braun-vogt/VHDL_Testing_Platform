/* htmllib.h */

#ifndef _HTMLLIB_H
#define _HTMLLIB_H

/* function prototypes */
void htmlHeader(char *title);
void htmlBody();
void htmlFooter();
void addTitleElement(char *title);
void addUserModal(char *id);
void timerScript(int year, int month, int day, int hour, int minute, int second);

#endif	/* !_HTMLLIB_H*/
