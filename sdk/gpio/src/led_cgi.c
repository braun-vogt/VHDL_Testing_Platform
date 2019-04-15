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

#include <json-c/json.h>

#include "libgpio.h"
#include "libuio.h"

#define TRIGGER(x) ((x)==0?1:0)
#define ONOFF(x) ((x)==0?"dark":"success")

#define LEDNUM 32

#define GREEN 0x0000ff00
   
static int output_vals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static int input_vals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

static char user[20] = "default";
static int user_pins[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

int printButton(int i){
	printf("<a role=\"button\" href=gpio?user=%s&led%i=%i class=\"btn btn-%s\">PIN %d</a>\n", user, i, TRIGGER(output_vals[i]), ONOFF(output_vals[i]), i);
	return 0;
}

int printInput(int i){
	printf("<a role=\"button\" href=# class=\"btn btn-%s\">IN %d</a>\n", ONOFF(input_vals[i]), i);
	return 0;
}

int get_leds(){
	GPIO vm = GPIO_init(0, 0);
	for(int i = 0; i < LEDNUM; i++) {
		unsigned char readVal;

		setPinMode(vm, 1, i + 1, INPUT);
		setPinMode(vm, 2, i + 1, INPUT);
		input_vals[i] =  digitalRead(vm, 1, i + 1);
		output_vals[i] = digitalRead(vm, 2, i + 1);

	}
	GPIO_Close(vm);

    return 0;
}

int create_led_entry()
{
	int i;


	printf("<nav class=\"navbar navbar-expand-lg navbar-light bg-light\">\n");
	printf("<div class=\"container-fluid\">\n");
	printf("<span class=\"navbar-brand mb-0 h1\">VHDL Testing Platform</span>\n");
	printf("<ul class=\"nav navbar-nav navbar-right\">\n");
    printf("<li>User: <a data-toggle=\"modal\" href=\"#userModal\">%s</a></li>\n</ul>\n", user);
	printf("</div>\n</nav>\n");


	printf("<div class=\"btn-toolbar\" role=\"toolbar\" aria-label=\"Toolbar with button groups\">\n"
           "<div class=\"btn-group mr-2\" role=\"group\" aria-label=\"First group\">\n");

	if(!strcmp(user, "admin")){
		for(i = 0; i < LEDNUM; i++) {
			printInput(i);
		}

	}else if(!strcmp(user, "felix")){
		for(i = 0; i < 3; i++) {
			printInput(i);
		}

	}else if(!strcmp(user, "philipp")){
		for(i = 3; i < 6; i++) {
			printInput(i);
		}

	}else{
		for(i = 0; i < LEDNUM; i++) {
			//printInput(i);
		}

	}


	printf("</div>\n </div>\n");

	printf("<div class=\"btn-toolbar\" role=\"toolbar\" aria-label=\"Toolbar with button groups\">\n"
           "<div class=\"btn-group mr-2\" role=\"group\" aria-label=\"First group\">\n");

	if(!strcmp(user, "admin")){
		for(i = 0; i < LEDNUM; i++) {
			printButton(i);
		}

	}else if(!strcmp(user, "felix")){
		for(i = 0; i < 3; i++) {
			printButton(i);
		}

	}else if(!strcmp(user, "philipp")){
		for(i = 3; i < 6; i++) {
			printButton(i);
		}

	}else{
		for(i = 0; i < 3; i++) {
			//printButton(i);
		}

	}

	printf("</div>\n </div>\n");

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

int get_cgi_led_val(char **getvars)
{
	int val = 0, number = 0;

	int j;

	for (j = 0; getvars[j]; j+= 2) {
		if (!strcmp(getvars[j], "user")) {
			sscanf(getvars[j+1],"%s",&user);
		}
		//TODO Check if user is allowed to set led

		if(sscanf(getvars[j], "led%i", &number)){
			sscanf(getvars[j+1],"%i",&val);
			output_vals[number] = val;
			set_led(number,val);
		}
	}
	return 0;
}

int led_cgi_page(char **getvars, int form_method)
{
	//addTitleElement("Zybo LED Control");
	
	get_leds();

	/* Drive the hardware */
	if (getvars != 0) {
		if(getvars[0] != 0){
			get_cgi_led_val(getvars);
		}
	}

	get_leds();

	create_led_entry();

	printf("<a role=\"button\" href=gpio?user=%s class=\"btn btn-primary\">Update</a>\n", user);

	printf("<div id=\"webcam\">");
	printf("<img src=\"http://192.168.1.254/media/?action=snapshot\" alt=\"Live Video\" />");
	printf("</div>");

	return 0;
}

