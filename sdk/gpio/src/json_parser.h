/*
 * json_parser.h
 *
 *  Created on: Apr 17, 2019
 *      Author: philipp
 */

#ifndef SRC_JSON_PARSER_H_
#define SRC_JSON_PARSER_H_

typedef struct json_s {
	char users[9][256];
	char designs[9][256];
	int pblocks[9];
	char peripherals[9][7][256];
	int peripheral_count[9];
	int pins[9][32];
	int pin_count[9];
	int length;
} json_t;

void parse_JSON(const char *file, json_t *config);

#endif /* SRC_JSON_PARSER_H_ */
