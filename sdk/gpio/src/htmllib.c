/* htmllib.c
 * HTML common library functions for the CGI programs. */

#include <stdio.h>
#include "htmllib.h"

void htmlHeader(char *title) {
	printf("Content-type: text/html\n\n"
			"<html>\<head>\n<meta charset=\"UTF-8\">\n<TITLE>%s</TITLE>\n"
			"<link rel=\"stylesheet\" href=\"../css/bootstrap.min.css\">\n"
			"<script src=\"../js/bootstrap.bundle.min.js\">\n</script>\n"
			"<script type=\"text/javascript\" src=\"/lang/b28n.js\">\n</script>\n"
			"<script type=\"text/javascript\" src=\"/lang/webcam.js\">\n</script>\n"
			"</head>",
			title);
}

void htmlBody() {
	printf("<body onload=\"page_init()\" oncontextmenu=\"return false;\">");
}

void htmlFooter() {
	printf("</body></html>");
}

void addTitleElement(char *title) {
	printf("<H1>%s</H1>", title);
}
