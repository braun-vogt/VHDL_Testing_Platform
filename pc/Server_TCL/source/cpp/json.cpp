#include <stdio.h>
#include <json-c/json.h>
#include <string.h>
#include "/home/pfirsichgnom/Dokumente/Codeblocks/Server_TCL/source/header/json.h"

void addconnections(json_t *config,char connections[][256],int concount)
{
    int hilf=0;
    for(int i=0;i<concount;i++)
    {
        printf("\n Connections : \n %s",connections[i]);
        if(strcmp(connections[i],"CLK_MMC")==0 || strcmp(connections[i],"CLK_PLL")==0 || strcmp(connections[i],"RGB_LED")==0 || strcmp(connections[i],"RGB_LED2")==0)
        {
            printf("\n %s \n",connections[i]);
            strcpy(config->peripheral[hilf],connections[i]);
            hilf++;
        }
        else if(strcmp(connections[i],"PMOD_JB_OUT")==0 || strcmp(connections[i],"PMOD_JC_OUT")==0 || strcmp(connections[i],"PMOD_JD_OUT")==0 || strcmp(connections[i],"PMOD_JE_OUT")==0)
        {
            char cpy[256];
            strcpy(cpy,connections[i]);
            cpy[7]='\0';
            strcpy(config->peripheral[hilf],cpy);
            hilf++;
        }
    }
    config->peripheral_count=hilf;
}

void parse_json(json_t content[8], const char *file){
	FILE *fp;
	char buffer[9999];

	struct json_object *parsed_json;
	struct json_object *users;
	struct json_object *user;
	struct json_object *name;
	struct json_object *design;
	struct json_object *pblock;
	struct json_object *peripherals;
	struct json_object *peripheral;
    struct json_object *pins;
	struct json_object *pin;

	fp = fopen(file,"r");
	int read = fread(buffer, 9999, 1, fp);
	fclose(fp);

    if(read > 0){

        parsed_json = json_tokener_parse(buffer);

        json_object_object_get_ex(parsed_json, "users", &users);

        for(int i = 0; i < json_object_array_length(users); i++){
            user = json_object_array_get_idx(users, i);

            json_object_object_get_ex(user, "user", &name);
            json_object_object_get_ex(user, "design", &design);
            json_object_object_get_ex(user, "pblock", &pblock);
            json_object_object_get_ex(user, "peripherals", &peripherals);
            json_object_object_get_ex(user, "pins", &pins);

            strcpy(content[i].user, json_object_get_string(name));
            strcpy(content[i].design, json_object_get_string(design));
            content[i].pblock = json_object_get_int(pblock);

            content[i].peripheral_count = json_object_array_length(peripherals);

            for(int j=0;j<json_object_array_length(peripherals);j++) {
                peripheral = json_object_array_get_idx(peripherals, j);
                strcpy(content[i].peripheral[j], json_object_get_string(peripheral));
            }

            content[i].pin_count = json_object_array_length(pins);

            for(int j=0;j<json_object_array_length(pins);j++) {
                pin = json_object_array_get_idx(pins, j);
                content[i].pins[j] = json_object_get_int(pin);
            }

        }

        //printf("%s\n", json_object_to_json_string_ext(parsed_json, JSON_C_TO_STRING_SPACED | JSON_C_TO_STRING_PRETTY));

        json_object_put(parsed_json); // Delete the json object
    }
}

void add_user_json(json_t new_user, const char *file){
	FILE *fp;
	char buffer[9999];

	struct json_object *jobj;
	struct json_object *users;
	struct json_object *user;
	struct json_object *name;
	struct json_object *design;
	struct json_object *pblock;
	struct json_object *peripherals;
    struct json_object *pins;

	fp = fopen(file,"r");
	if(fp==0)
	{
        perror("opening json file" );
	}
	fread(buffer, 9999, 1, fp);
	fclose(fp);

    if(strlen(buffer) > 0){
        jobj = json_tokener_parse(buffer);

        json_object_object_get_ex(jobj, "users", &users);

        for(int i = 0; i < json_object_array_length(users); i++){
            user = json_object_array_get_idx(users, i);

            json_object_object_get_ex(user, "user", &name);
            json_object_object_get_ex(user, "design", &design);
            json_object_object_get_ex(user, "pblock", &pblock);
            json_object_object_get_ex(user, "peripherals", &peripherals);
            json_object_object_get_ex(user, "pins", &pins);

        }
    }else{
        jobj = json_object_new_object();
        users = json_object_new_array();
        json_object_object_add(jobj,"users", users);
    }

    if(json_object_array_length(users) >= 8){
        users = json_object_new_array();
        json_object_object_add(jobj, "users", users);
    }

	user = json_object_new_object();

	json_object_object_add(user, "user", json_object_new_string(new_user.user));
	json_object_object_add(user, "design", json_object_new_string(new_user.design));
	json_object_object_add(user, "pblock", json_object_new_int(new_user.pblock));

	peripherals = json_object_new_array();

	for(int i = 0; i < new_user.peripheral_count; i++){
        json_object_array_add(peripherals, json_object_new_string(new_user.peripheral[i]));
    }

    json_object_object_add(user, "peripherals", peripherals);

	pins = json_object_new_array();

	for(int i = 0; i < new_user.pin_count; i++){
        json_object_array_add(pins, json_object_new_int(new_user.pins[i]));
	}

	json_object_object_add(user, "pins", pins);

	json_object_array_add(users, user);

    //printf("%s\n", json_object_to_json_string_ext(jobj, JSON_C_TO_STRING_SPACED | JSON_C_TO_STRING_PRETTY));

    fp = fopen(file,"w");
    fprintf(fp, "%s\n", json_object_to_json_string_ext(jobj, JSON_C_TO_STRING_SPACED | JSON_C_TO_STRING_PRETTY));
	fclose(fp);

    json_object_put(jobj); // Delete the json object
}
