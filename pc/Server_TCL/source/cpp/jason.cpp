#include "/home/pfirsichgnom/Dokumente/Codeblocks/Server_TCL/source/header/jason.h"

/*
typedef struct json_s {
	char user[256];
	char design[256];
	int pblock;
	char peripheral[9][256];
	int peripheral_count;
	int pins[32];
	int pin_count;
} json_t;
*/

jasonf_t file;

void addconnections(json_t *config,char **connections,int concount)
{
    int hilf=0;
    for(int i=0;i<concount;i++)
    {
        printf("\n Connections : \n %s",connections[i]);
        if(strcmp(connections[i],"CLK_MMC")==0 || strcmp(connections[i],"CLK_PLL")==0 || strcmp(connections[i],"RGB_LED")==0 || strcmp(connections[i],"RGB_LED2")==0)
        {
            strcpy(config->peripheral[hilf],connections[i]);
            hilf++;
        }
        else if(strcmp(connections[i],"PMOD_JB_OUT")==0 || strcmp(connections[i],"PMOD_JC_OUT")==0 || strcmp(connections[i],"PMOD_JD_OUT")==0 || strcmp(connections[i],"PMOD_JE_OUT")==0)
        {
            char cpy[256];
            strcpy(cpy,connections[i]);
            cpy[47]='\0';
            strcpy(config->peripheral[hilf],cpy);
            hilf++;
        }
    }
    config->peripheral_count=hilf;
}
char openjasonfile(char* jasonpath)
{

    char hilf[256]={0};
    strcpy(hilf,jasonpath);
    strcat(hilf,"usage.jason");
    file.mjason = fopen(hilf,"w+");
    if(file.mjason==0)
    {
        perror("error jasonfile");

        return -1;
    }


    strcpy(hilf,jasonpath);
    strcat(hilf,"usageblank.jason");
    file.sjason = fopen(hilf,"r+");
    if(file.mjason==0)
    {
        perror("error jasonfile");

        return -1;
    }
    return 0;
}
void closejasonfile()
{
    fclose(file.mjason);
    file.mjason=0;
    fclose(file.sjason);
    file.sjason=0;

}

char writejasonfile(char *filename,char *dfilename,char par,char** connections, char concount,int *pins,int pincount,char* jasonpath)
{

    struct json_object *jobj;
	struct json_object *users;
	struct json_object *user;
	struct json_object *peripherals;
	struct json_object *pins_Array;

	json_t config;

	strcpy(config.user,filename);
    strcpy(config.design,dfilename);
    config.pblock=par;
    addconnections(&config,connections,concount);

    for(int i=0;i <pincount;i++)
    {
        config.pins[i]=i;
    }
    config.pin_count=32;

	jobj = json_object_new_object();

	users = json_object_new_array();

	user = json_object_new_object();

	json_object_object_add(user, "user", json_object_new_string(config.user));
	json_object_object_add(user, "design", json_object_new_string(config.design));
	json_object_object_add(user, "pblock", json_object_new_int(config.pblock));
	peripherals = json_object_new_array();

	for(int i = 0; i < config.peripheral_count; i++){
        json_object_array_add(peripherals, json_object_new_string(config.peripheral[i]));
    }

    json_object_object_add(user, "peripherals", peripherals);

	pins_Array = json_object_new_array();

	for(int i = 0; i < config.pin_count; i++){
        json_object_array_add(pins_Array, json_object_new_int(config.pins[i]));
	}

	json_object_object_add(user, "pins", pins_Array);

	json_object_array_add(users, user);

	json_object_object_add(jobj, "users", users);

   // printf("%s\n", json_object_to_json_string_ext(jobj, JSON_C_TO_STRING_SPACED | JSON_C_TO_STRING_PRETTY));

    openjasonfile(jasonpath);
    fprintf(file.mjason, "%s\n", json_object_to_json_string_ext(jobj, JSON_C_TO_STRING_SPACED | JSON_C_TO_STRING_PRETTY));
    closejasonfile();
    openjasonfile(jasonpath);
    fprintf(file.sjason, "%s\n", json_object_to_json_string_ext(jobj, JSON_C_TO_STRING_SPACED | JSON_C_TO_STRING_PRETTY));
    closejasonfile();


    json_object_put(jobj); // Delete the json object

	return 1;
}

char parsjason()
{
	char buffer[2048];
	struct json_object *parsed_json;
	struct json_object *users;
	struct json_object *user;
	struct json_object *name;
	struct json_object *design;
	struct json_object *pblock;
	struct json_object *peripherals;
	struct json_object *peripheral;
	int n_peripherals;
    struct json_object *pins;
	struct json_object *pin;
	int n_pins;


	fread(buffer, 2048, 1, file.sjason);
    closejasonfile();

	parsed_json = json_tokener_parse(buffer);

    json_object_object_get_ex(parsed_json, "users", &users);

    for(int i = 0; i < json_object_array_length(users); i++){
        user = json_object_array_get_idx(users, i);

        json_object_object_get_ex(user, "user", &name);
        json_object_object_get_ex(user, "design", &design);
        json_object_object_get_ex(user, "pblock", &pblock);
        json_object_object_get_ex(user, "peripherals", &peripherals);
        json_object_object_get_ex(user, "pins", &pins);

        printf("User: %s\n", json_object_get_string(name));
        printf("Design: %s\n", json_object_get_string(design));
        printf("PBlock: %d\n", json_object_get_int(pblock));

        n_peripherals = json_object_array_length(peripherals);
        printf("Found %lu peripherals\n",n_peripherals);

        for(int i=0;i<n_peripherals;i++) {
            peripheral = json_object_array_get_idx(peripherals, i);
            printf("%lu. %s\n",i+1,json_object_get_string(peripheral));
        }


        n_pins = json_object_array_length(pins);
        printf("Found %lu pins\n",n_pins);

        for(int i=0;i<n_pins;i++) {
            pin = json_object_array_get_idx(pins, i);
            printf("%lu. %s\n",i+1,json_object_get_string(pin));
        }

    }
    return 0;
}
