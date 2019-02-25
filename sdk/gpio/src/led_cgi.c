/* led_cgi.c - Simple CGI interface to control LEDs on microblaze 

   John Williams <jwilliams@itee.uq.edu.au>

*/

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include "htmllib.h"
#include "cgivars.h"
#include "led_cgi.h"
#include <fcntl.h>
#include <sys/ioctl.h>

#define MAX(x,y) ((x)>(y)?(x):(y))
#define MIN(x,y) ((x)<(y)?(x):(y))

#define TRIGGER(x) ((x)==LEDOFF?LEDON:LEDOFF)

#define GPIO_ROOT "/sys/class/gpio"
#define LEDNUM 8
#define LEDON 0x0000ff00
#define LEDOFF 0

#define LEDHTML "<td><a href=gpio?ledgpio=%i&led0=%i&led1=%i&led2=%i&led3=%i&led4=%i&led5=%i&led6=%i&led7=%i>ON/OFF</a></td>\n"
static char *led_name[] = {"led0", "led1", "led2", "led3",
			   "led4", "led5", "led6", "led7"};
   
static int led_html_color[] = {0, 0, 0, 0, 0, 0, 0, 0};

static int leds_val;

#ifdef LEDGPIOBASE
static int ledgpio=LEDGPIOBASE;
#else
static int ledgpio=0;
#endif

int create_led_entry()
{
	int i;

  
	printf("<table>\n");
  
	printf("<tr>\n"); 
	for(i = 0; i < LEDNUM; i++) {
		printf("<td>%s</td>\n", led_name[i]);
	}
	printf("</tr>\n");
  
	printf("<tr height=40 pixel>\n");
	for(i = 0; i < LEDNUM; i++) {
		printf("<td bgcolor=#%06X>\n", led_html_color[i]);
		printf("<p><p>\n");
		printf("</td>\n");
	}
	printf("</tr>\n");
  
	printf("<tr>\n"); 
	printf(LEDHTML, ledgpio,
		TRIGGER(led_html_color[0]),led_html_color[1],led_html_color[2],
		led_html_color[3],led_html_color[4], led_html_color[5],
		led_html_color[6], led_html_color[7]);
	printf(LEDHTML, ledgpio,
		led_html_color[0], TRIGGER(led_html_color[1]),
		led_html_color[2], led_html_color[3], led_html_color[4],
		led_html_color[5], led_html_color[6], led_html_color[7]);
	printf(LEDHTML, ledgpio,
		led_html_color[0], led_html_color[1], 
		TRIGGER(led_html_color[2]),led_html_color[3], 
		led_html_color[4],led_html_color[5],led_html_color[6],led_html_color[7]);
	printf(LEDHTML, ledgpio,
		led_html_color[0], led_html_color[1], led_html_color[2],
		TRIGGER(led_html_color[3]), led_html_color[4],led_html_color[5],
		led_html_color[6], led_html_color[7]);
	printf(LEDHTML, ledgpio,
		led_html_color[0], led_html_color[1], led_html_color[2], 
		led_html_color[3], TRIGGER(led_html_color[4]),
		led_html_color[5], led_html_color[6], led_html_color[7]);
	printf(LEDHTML, ledgpio,
		led_html_color[0], led_html_color[1], led_html_color[2], 
		led_html_color[3], led_html_color[4],TRIGGER(led_html_color[5]),
		led_html_color[6], led_html_color[7]);
	printf(LEDHTML, ledgpio,
		led_html_color[0], led_html_color[1], led_html_color[2], 
		led_html_color[3], led_html_color[4], led_html_color[5], 
		TRIGGER(led_html_color[6]), led_html_color[7]);
	printf(LEDHTML, ledgpio,
		led_html_color[0], led_html_color[1], led_html_color[2], 
		led_html_color[3], led_html_color[4], led_html_color[5], 
		led_html_color[6], TRIGGER(led_html_color[7]));
	printf("</tr>\n");

	printf("</table>\n");

	return 0;
}

int set_leds()
{
	int nchannel = 0;

	nchannel=open_gpio_channel(ledgpio);
	if (nchannel <= 0)
		return -1;
	if (set_gpio_direction(ledgpio, nchannel, "out"))
		return -1;
	return set_gpio_value(ledgpio,nchannel, leds_val);

}

int get_led_val(char **getvars)
{
	char *tmp;
	int val;
	int i, j;

	for (j = 0; getvars[j]; j+= 2) {
		if (!strcmp(getvars[j], "ledgpio")) {
			sscanf(getvars[j+1], "%i", &ledgpio);
		}
	}

	leds_val = 0;
	for (i = 0; i < 8; i++) {
		tmp = 0;
		for (j = 0; getvars[j]; j+= 2) {
	
			if(!strcmp(getvars[j], led_name[i])) {
				tmp = getvars[j+1];
			}
		}
	
		if(tmp)
			if(sscanf(tmp,"%i",&val)) {
				led_html_color[i] = val;
        			if (val != 0) {	
					leds_val += (1 << i);
				}
			}
	}
	return 0;
}

int led_cgi_page(char **getvars, int form_method)
{
	addTitleElement("Zybo LED Control");
	
	if (getvars != 0) {
		if(getvars[0] != 0){
			get_led_val(getvars);
		} 
	}

	/* Drive the hardware */

	set_leds();

	printf("<form ACTION=\"%s\" METHOD=\"GET\">\n", "/cgi-bin/gpio");
	printf("<div><label>LED GPIO ID: <input name=\"ledgpio\" size=\"3\" value=\"%d\" ></label></div>",ledgpio);
	printf("<div><P> To change LED GPIO, change the value in the \"LED GPIO ID\" box and press \"Clear\" button.</div>");

	create_led_entry();

	printf("<input type=\"Submit\" value=\"Clear\">\n");

	printf("<p><p>\n");
	printf("</form>\n");

	/* Drive the hardware */
	set_leds();

	return 0;
}

