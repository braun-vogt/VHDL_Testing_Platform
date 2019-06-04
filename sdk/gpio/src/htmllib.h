/* htmllib.h */

#ifndef _HTMLLIB_H
#define _HTMLLIB_H

/* function prototypes */
void htmlHeader(char *title);
void htmlBody();
void htmlFooter();
void addTitleElement(char *title);
void addModal(char *id, char *title, char *msg);
void timerScript(int year, int month, int day, int hour, int minute, int second);
void timerScriptSeconds(long seconds);

#endif	/* !_HTMLLIB_H*/
