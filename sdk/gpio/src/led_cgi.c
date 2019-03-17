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

#include "libgpio.h"
#include "libuio.h"

#define TRIGGER(x) ((x)==0?1:0)
#define ONOFF(x) ((x)==0?"ON":"OFF")

#define LEDNUM 8

#define GREEN 0x0000ff00
   
static int leds_val[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

int printButton(int i){
	printf("<td><a href=gpio?led%i=%i>%s</a></td>\n", i, TRIGGER(leds_val[i]), ONOFF(leds_val[i]));
	return 0;
}

int get_leds(){
	for(int i = 0; i < LEDNUM; i++) {
		unsigned char readVal;

		GPIO vm = GPIO_init(0, 0);
		setPinMode(vm, 1, i + 1, INPUT);
		readVal = digitalRead(vm, 1, i + 1);
		GPIO_Close(vm);

		leds_val[i] = readVal;
	}
    return 0;
}

int create_led_entry()
{
	int i;

  
	printf("<table>\n");
  
	printf("<tr>\n"); 
	for(i = 0; i < LEDNUM; i++) {
		printf("<td>led%d</td>\n", i);
	}
	printf("</tr>\n");
  
	printf("<tr height=40 pixel>\n");
	for(i = 0; i < LEDNUM; i++) {
		printf("<td bgcolor=#%06X>\n", leds_val[i]?GREEN:0);
		printf("<p><p>\n");
		printf("</td>\n");
	}
	printf("</tr>\n");
  
	printf("<tr>\n");
	for(i = 0; i < LEDNUM; i++) {
		printButton(i);
	}

	printf("</tr>\n");

	printf("</table>\n");

	return 0;
}

int set_led(int pinNumber, int val)
{
    GPIO vm = GPIO_init(0, 0);
	setPinMode(vm, 2, pinNumber + 1, OUTPUT);
	digitalWrite(vm, 2, pinNumber + 1, val);
    GPIO_Close(vm);
    return 0;
}

int get_led_val(char **getvars)
{
	int val = 0, number = 0;

	sscanf(getvars[0], "led%i", &number);
	sscanf(getvars[1],"%i",&val);
	printf("Pin Number: %d, Value: %d\n", number, val);
	leds_val[number] = val;
	set_led(number,val);

	return 0;
}

int led_cgi_page(char **getvars, int form_method)
{
	addTitleElement("Zybo LED Control");
	
	get_leds();

	/* Drive the hardware */
	if (getvars != 0) {
		if(getvars[0] != 0){
			get_led_val(getvars);
		}
	}

	create_led_entry();

	printf("<form ACTION=\"%s\" METHOD=\"GET\">\n", "/cgi-bin/gpio");
	//printf("<div><label>LED GPIO ID: <input name=\"ledgpio\" size=\"3\" value=\"%d\" ></label></div>",ledgpio);
	//printf("<div><P> To change LED GPIO, change the value in the \"LED GPIO ID\" box and press \"Clear\" button.</div>");

	printf("<input type=\"Submit\" value=\"UPDATE\">\n");

	printf("<p><p>\n");
	printf("</form>\n");

	return 0;
}

