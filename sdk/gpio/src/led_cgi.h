/* led_cgi.h */
#ifndef LED_CGI_H
#define LED_CGI_H

int led_cgi_page	(char **getvars, int form_method);
int open_gpio_channel	(int gpio_base);
int close_gpio_channel	(int gpio_base);
int set_gpio_direction	(int gpio_base, int nchannel, char *direction);
int set_gpio_value	(int gpio_base, int nchannel, int value);

#endif
