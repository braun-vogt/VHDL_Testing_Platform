/* LEDcontrol.c */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#include "cgivars.h"
#include "htmllib.h"
#include "led_cgi.h"

int main() {
	char **postvars = NULL; 	/* POST request data repository */
	char **getvars = NULL; 		/* GET request data repository */
	int form_method; 		/* POST = 1, GET = 0 */  
	
	form_method = getRequestMethod();

	if(form_method == POST) {
		getvars = getGETvars();
		postvars = getPOSTvars();
	} else if(form_method == GET) {
		getvars = getGETvars();
	}

	htmlHeader("VHDL Testing Platform");
	htmlBody();
		
	led_cgi_page(getvars, form_method);

	htmlFooter();
	cleanUp(form_method, getvars, postvars);

	fflush(stdout);
	exit(0);
	return 0;
}
