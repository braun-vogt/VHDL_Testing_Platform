/*
 * json_parser.h
 *
 *  Created on: Apr 17, 2019
 *      Author: philipp
 */

#ifndef SRC_JSON_PARSER_H_
#define SRC_JSON_PARSER_H_

typedef struct json_s {
	char users[8][256];
	char designs[8][256];
	int pblocks[8];
	int pins[8][32];
	int pin_count[8];
	int length;
} json_t;

void parse_JSON(json_t *config);

#endif /* SRC_JSON_PARSER_H_ */
