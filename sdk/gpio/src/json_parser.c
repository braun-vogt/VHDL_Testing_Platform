#include <stdio.h>
#include <json-c/json.h>

void parse_JSON(){
	FILE *fp;
	char buffer[1024];
	struct json_object *parsed_json;
	struct json_object *user;
	struct json_object *design;
	struct json_object *pblock;
	struct json_object *pins;
	struct json_object *pin;
	int n_pins;

	fp = fopen("../test.json","r");
	fread(buffer, 1024, 1, fp);
	fclose(fp);

	parsed_json = json_tokener_parse(buffer);

	json_object_object_get_ex(parsed_json, "user", &user);
	json_object_object_get_ex(parsed_json, "design", &design);
	json_object_object_get_ex(parsed_json, "pblock", &pblock);
	json_object_object_get_ex(parsed_json, "pins", &pins);

	printf("User: %s\n", json_object_get_string(user));
	printf("Design: %s\n", json_object_get_string(design));
	printf("PBlock: %d\n", json_object_get_int(pblock));

	n_pins = json_object_array_length(pins);
	printf("Found %d pins\n",n_pins);

	for(int i=0;i<n_pins;i++) {
		pin = json_object_array_get_idx(pins, i);
		printf("%d. %s\n",i+1,json_object_get_string(pin));
	}
}
