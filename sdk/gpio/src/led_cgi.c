/* led_cgi.c - Simple CGI interface to control LEDs on microblaze 

   John Williams <jwilliams@itee.uq.edu.au>

*/

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>

#include <json-c/json.h>

#include "htmllib.h"
#include "cgivars.h"
#include "led_cgi.h"
#include "libgpio.h"
#include "libuio.h"

#include "parFlash.h"
#include "json_parser.h"

#define TRIGGER(x) ((x)==0?1:0)
#define ONOFF(x) ((x)==0?"dark":"success")

#define PINNUM 32

#define JSON_FILE "/home/root/par/users.json"

static char ip_cam[120] = "\"http://ictsrv012.ict.tuwien.ac.at/media/?action=snapshot\" alt=\"Live Video\"";

static int output_vals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static int input_vals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static int reset = 0;

static int firstFlash = 0;

static char user[256] = "default";

json_t config = {
		{"admin"},
		{"admin.vhd"},
		{0},
		{{"RGB_LED1", "RGB_LED2"}},
		{2},
		{{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}},
		{32},
		1
};

int printButton(int i){
	printf("<a role=\"button\" href=gpio?user=%s&pin%i=%i class=\"btn btn-%s\">Write %d</a>\n", user, i, TRIGGER(output_vals[i]), ONOFF(output_vals[i]), i);
	return 0;
}

int printInput(int i){
	printf("<a role=\"button\" href=# class=\"btn btn-%s\">Read %d</a>\n", ONOFF(input_vals[i]), i);
	return 0;
}

int set_pin(int device,int channel, int pinNumber, int val){
    GPIO vm = GPIO_init(device, 0);
	setPinMode(vm, channel, pinNumber + 1, OUTPUT);
	digitalWrite(vm, channel, pinNumber + 1, val);
    GPIO_Close(vm);
    return 0;
}

int set_mux_pins(int startPin, int val[4]){
    GPIO vm = GPIO_init(0, 0);
	setPinMode(vm, 1, startPin + 1, OUTPUT);
	setPinMode(vm, 1, startPin + 2, OUTPUT);
	setPinMode(vm, 1, startPin + 3, OUTPUT);
	setPinMode(vm, 1, startPin + 4, OUTPUT);
	digitalWrite(vm, 1, startPin + 1, val[0]);
	digitalWrite(vm, 1, startPin + 2, val[1]);
	digitalWrite(vm, 1, startPin + 3, val[2]);
	digitalWrite(vm, 1, startPin + 4, val[3]);
    GPIO_Close(vm);
    return 0;
}

int get_pins(int device){
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

int get_reset(int user){
	GPIO vm = GPIO_init(1, 0);
	setPinMode(vm, 1, user + 1, INPUT);
	reset = digitalRead(vm, 1, user + 1);

	GPIO_Close(vm);

    return 0;
}

int set_mux(int pblock, const char peripherals[7][256]){
	int pblock_mux[4] = {0,0,0,0};

	switch(pblock){
	case 0:
		pblock_mux[0] = 0;
		pblock_mux[1] = 0;
		pblock_mux[2] = 0;
		pblock_mux[3] = 0;
		break;
	case 1:
		pblock_mux[0] = 1;
		pblock_mux[1] = 0;
		pblock_mux[2] = 0;
		pblock_mux[3] = 0;
		break;
	case 2:
		pblock_mux[0] = 0;
		pblock_mux[1] = 1;
		pblock_mux[2] = 0;
		pblock_mux[3] = 0;
		break;
	case 3:
		pblock_mux[0] = 1;
		pblock_mux[1] = 1;
		pblock_mux[2] = 0;
		pblock_mux[3] = 0;
		break;
	case 4:
		pblock_mux[0] = 0;
		pblock_mux[1] = 0;
		pblock_mux[2] = 1;
		pblock_mux[3] = 0;
		break;
	case 5:
		pblock_mux[0] = 1;
		pblock_mux[1] = 0;
		pblock_mux[2] = 1;
		pblock_mux[3] = 0;
		break;
	case 6:
		pblock_mux[0] = 0;
		pblock_mux[1] = 1;
		pblock_mux[2] = 1;
		pblock_mux[3] = 0;
		break;
	case 7:
		pblock_mux[0] = 1;
		pblock_mux[1] = 1;
		pblock_mux[2] = 1;
		pblock_mux[3] = 0;
		break;
	default:
		pblock_mux[0] = 0;
		pblock_mux[1] = 0;
		pblock_mux[2] = 0;
		pblock_mux[3] = 0;
		break;
	}

	set_pin(0, 1, 0, 1);
	for(int i = 0; i < 7; i++){
		if(!strcmp(peripherals[i], "PMOD_JB")){
			set_mux_pins(1, pblock_mux);
		}else if(!strcmp(peripherals[i], "PMOD_JC")){
			set_mux_pins(5, pblock_mux);
		}else if(!strcmp(peripherals[i], "PMOD_JD")){
			set_mux_pins(9, pblock_mux);
		}else if(!strcmp(peripherals[i], "PMOD_JE")){
			set_mux_pins(13, pblock_mux);
		}else if(!strcmp(peripherals[i], "RGB_LED1")){
			set_mux_pins(17, pblock_mux);
		}else if(!strcmp(peripherals[i], "RGB_LED2")){
			set_mux_pins(21, pblock_mux);
		}else if(!strcmp(peripherals[i], "LEDS")){
			set_mux_pins(25, pblock_mux);
		}
	}
	return 0;
}

int create_pin_entry()
{
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
			printf("<a role=\"button\" href=gpio?user=%s&reset=%i class=\"btn btn-%s\">RESET</a>\n", user, TRIGGER(reset), ONOFF(reset));

		}
	}

	printf("</div>\n </div>\n");

	return 0;
}

int get_cgi_pin_val(char **getvars)
{
	int val = 0, number = 0;

	for (int j = 0; getvars[j]; j+= 2) {
		if (!strcmp(getvars[j], "user")) {
			sscanf(getvars[j+1],"%s",user);
		}

		if(sscanf(getvars[j], "pin%i", &number)){
			sscanf(getvars[j+1],"%i",&val);
			for (int i = 0; i < config.length; i++){
				if(!strcmp(user, config.users[i])){
					for(int j = 0; j < config.pin_count[i]; j++){
						if(config.pins[i][j] == number){
							output_vals[number] = val;
							set_pin(config.pblocks[i]+2, 2,number,val);
						}
					}
				}
			}
		}

		if(!strcmp(getvars[j], "reset")){
			sscanf(getvars[j+1],"%i",&val);
			for (int i = 0; i < config.length; i++){
				if(!strcmp(user, config.users[i])){
					reset = val;
					set_pin(1, 1,config.pblocks[i],val);
				}
			}
		}

	}
	return 0;
}

int led_cgi_page(char **getvars, int form_method)
{

	printf("<nav class=\"navbar navbar-expand-lg navbar-light bg-light\">\n");
	printf("<div class=\"container-fluid\">\n");
	printf("<span class=\"navbar-brand mb-0 h1\">VHDL Testing Platform</span>\n");
	printf("<ul class=\"nav navbar-nav navbar-right\">\n");
	fflush(stdout);

	parse_JSON(JSON_FILE, &config);

	/* Drive the hardware */
	if (getvars != 0) {
		if(getvars[0] != 0){
			get_cgi_pin_val(getvars);
		}
	}

    printf("<li>User: <a data-toggle=\"modal\" href=\"#userModal\">%s</a></li>\n</ul>\n", user);
	printf("</div>\n</nav>\n");
	fflush(stdout);

	for (int i = 0; i < config.length; i++){
		if(!strcmp(user, config.users[i])){
			if(flash_par_bitfile(config.designs[i]) == 0){
				firstFlash = 1;
			}else{
				firstFlash = 0;
			}
			set_mux(config.pblocks[i], config.peripherals[i]);
			set_pin(1, 1, config.pblocks[i], 1);
			set_pin(1, 1, config.pblocks[i], reset);
			break;
		}
	}

	fflush(stdout);

	for (int i = 0; i < config.length; i++){
		if(!strcmp(user, config.users[i])){
			get_reset(config.pblocks[i]);
			get_pins(config.pblocks[i]+2);
		}
	}
	create_pin_entry();

	printf("<h6>%s </h6>\n", firstFlash ? "Welcome!" : "Welcome Back!");

	printf("<a role=\"button\" href=gpio?user=%s class=\"btn btn-primary\">Update</a>\n", user);
	printf("<iframe width=\"640\" height=\"480\" src=\"http://ictsrv012.ict.tuwien.ac.at/videostream.cgi?user=admin&pwd=\" frameborder=\"0\" allowfullscreen></iframe>\n");
	printf("<div id=\"webcam\">");
	printf("<img src= ");
	printf(ip_cam);
	printf("/>\n");
	printf("</div>\n");

	return 0;
}
