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

#include "parFlash.h"
#include "json_parser.h"

#define TRIGGER(x) ((x)==0?1:0)
#define ONOFF(x) ((x)==0?"dark":"success")

#define PINNUM 32

static char ip_cam[120] = "\"http://192.168.1.254/media/?action=snapshot\" alt=\"Live Video\"";

static int output_vals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static int input_vals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

static char user[256] = "default";

json_t config = {
		{"admin"},
		{"admin.vhd"},
		{0},
		{{"led0", "led1"}},
		{2},
		{{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}},
		{32},
		1
};

int printButton(int i){
	printf("<a role=\"button\" href=gpio?user=%s&led%i=%i class=\"btn btn-%s\">PIN %d</a>\n", user, i, TRIGGER(output_vals[i]), ONOFF(output_vals[i]), i);
	return 0;
}

int printInput(int i){
	printf("<a role=\"button\" href=# class=\"btn btn-%s\">IN %d</a>\n", ONOFF(input_vals[i]), i);
	return 0;
}

int get_leds(int device){
	GPIO vm = GPIO_init(device, 0);
	for(int i = 0; i < PINNUM; i++) {

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
	printf("<nav class=\"navbar navbar-expand-lg navbar-light bg-light\">\n");
	printf("<div class=\"container-fluid\">\n");
	printf("<span class=\"navbar-brand mb-0 h1\">VHDL Testing Platform</span>\n");
	printf("<ul class=\"nav navbar-nav navbar-right\">\n");
    printf("<li>User: <a data-toggle=\"modal\" href=\"#userModal\">%s</a></li>\n</ul>\n", user);
	printf("</div>\n</nav>\n");


	printf("<div class=\"btn-toolbar\" role=\"toolbar\" aria-label=\"Toolbar with button groups\">\n"
           "<div class=\"btn-group mr-2\" role=\"group\" aria-label=\"First group\">\n");


	for (int i = 0; i < config.length; i++){
		if(!strcmp(user, config.users[i])){
			for(int j = 0; j < config.pin_count[i]; j++){
				printInput(config.pins[i][j]);
			}
		}
	}

	printf("</div>\n </div>\n");

	printf("<div class=\"btn-toolbar\" role=\"toolbar\" aria-label=\"Toolbar with button groups\">\n"
           "<div class=\"btn-group mr-2\" role=\"group\" aria-label=\"First group\">\n");

	for (int i = 0; i < config.length; i++){
		if(!strcmp(user, config.users[i])){
			for(int j = 0; j < config.pin_count[i]; j++){
				printButton(config.pins[i][j]);
			}
		}
	}

	printf("</div>\n </div>\n");

	return 0;
}

int set_led(int device, int pinNumber, int val)
{
    GPIO vm = GPIO_init(device, 0);
	setPinMode(vm, 2, pinNumber + 1, OUTPUT);
	digitalWrite(vm, 2, pinNumber + 1, val);
    GPIO_Close(vm);
    return 0;
}

int get_cgi_led_val(char **getvars)
{
	int val = 0, number = 0;

	for (int j = 0; getvars[j]; j+= 2) {
		if (!strcmp(getvars[j], "user")) {
			sscanf(getvars[j+1],"%s",&user);
		}

		if(sscanf(getvars[j], "led%i", &number)){
			sscanf(getvars[j+1],"%i",&val);
			for (int i = 0; i < config.length; i++){
				if(!strcmp(user, config.users[i])){
					for(int j = 0; j < config.pin_count[i]; j++){
						if(config.pins[i][j] == number){
							output_vals[number] = val;
							set_led(config.pblocks[i]+2,number,val);
						}
					}
				}
			}
		}
	}
	return 0;
}

int led_cgi_page(char **getvars, int form_method)
{
	parse_JSON(&config);

	for (int i = 0; i < config.length; i++){
		if(!strcmp(user, config.users[i])){
			get_leds(config.pblocks[i]+2);
		}
	}

	/* Drive the hardware */
	if (getvars != 0) {
		if(getvars[0] != 0){
			get_cgi_led_val(getvars);
		}
	}

	for (int i = 0; i < config.length; i++){
		if(!strcmp(user, config.users[i])){
			get_leds(config.pblocks[i]+2);
		}
	}
	create_led_entry();

	printf("<a role=\"button\" href=gpio?user=%s class=\"btn btn-primary\">Update</a>\n", user);

	printf("<div id=\"webcam\">");
	printf("<img src= ");
	printf(ip_cam);
	printf("/>\n");
	printf("</div>");

	return 0;
}

