/* led_cgi.h */
#ifndef LED_CGI_H
#define LED_CGI_H

int led_cgi_page	(char **getvars, int form_method);
int set_pin(int device,int channel, int pinNumber, int val);

#endif
