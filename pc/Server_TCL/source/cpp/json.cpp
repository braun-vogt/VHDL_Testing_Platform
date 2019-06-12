#include "../header/json.h"

void filljson(configpath_s *config, files_t *fileset,json_t *new_user, int currentfile, char *fset, char parnum)
{
    json_t data[8];
    int user=0;
    char name[256];
    char hilf[500];
    int pinnum[32];
    int anzahl=0;
    char portsnames[40][256];
    int ports=0;
    char *pointer;
    for(int i=0;i<32;i++)
    {
        pinnum[i]=-1;
    }

    //Get username  id
    sscanf(fileset->file[currentfile],"%*[^0-9]%d",&user);
    sprintf(name,"%d",user);
    //pointer=strstr(hilf,"_");
    //printf("%c",*pointer);
    //*pointer='\0';
    strcpy(new_user->user,name);

    if(config->verbose)
    {
        fprintf(config->log,"\nUser: %s \n",name);

    }
    //analys used ports

    ports_file_num(fileset,currentfile,&ports,config,portsnames,pinnum,&anzahl);

    if(config->verbose)
    {
        fprintf(config->log,"\n pinscount :%d \n", anzahl);
    }
    new_user->pin_count=anzahl;

    for(int b=0; b<32; b++)
    {
        if(config->verbose)
        {
            fprintf(config->log,"\n pinnum %d",pinnum[b]);
        }
        if(pinnum[b]!=-1)
        {
            new_user->pins[b]=pinnum[b];
        }

    }

    if(config->verbose)
    {
        fprintf(config->log,"\n PORTNUM %d",ports);
        fflush(config->log);
    }

    addconnections(new_user,portsnames,ports,*config);
    new_user->pblock=parnum;


    strcpy(hilf,fileset->file[currentfile]);
    pointer=strstr(hilf,".vhd");
    *pointer='\0';
    strcat(hilf,".bit");
    strcpy(new_user->design,hilf);

    if(config->verbose)
    {
        fprintf(config->log,"\ndesign: %s \n",hilf);
        fprintf(config->log,"\nnew user %s\n",new_user->design);
        fflush(config->log);
    }

    strcpy(hilf,config->jsonpath);
    strcat(hilf,"users.json");
    if(*fset)
    {
        add_new_json(*new_user, hilf);
        *fset=false;
    }
    else
    {
        add_user_json(*new_user, hilf);
    }


    parse_json(data, hilf);

    strcpy(hilf,config->jsonpath);
    strcat(hilf,"users.json");
    char hilf2[500];
    strcpy(hilf2, "scp ");
    strcat(hilf2, hilf);
    strcat(hilf2, " ");
    strcat(hilf2,config->scpbitdestpath);
    system(hilf2);
}
void addconnections(json_t *config,char connections[][256],int concount,configpath_s conf)
{
    int hilf=0;
    for(int i=0;i<concount;i++)
    {
        if(conf.verbose)
        {
            fprintf(conf.log,"\n Connections : \n %s",connections[i]);
            fflush(conf.log);
        }

        if(strcmp(connections[i],"CLK_MMC")==0 || strcmp(connections[i],"CLK_PLL")==0 || strcmp(connections[i],"RGB_LED1")==0 || strcmp(connections[i],"RGB_LED2")==0 || strcmp(connections[i],"LEDS")==0)
        {

            strcpy(config->peripheral[hilf],connections[i]);
            if(conf.verbose)
            {
                fprintf(conf.log,"\n %s \n",connections[i]);
                fflush(conf.log);
            }
            hilf++;
        }
        if(strcmp(connections[i],"PMOD_JB_OUT")==0 || strcmp(connections[i],"PMOD_JC_OUT")==0 || strcmp(connections[i],"PMOD_JD_OUT")==0 || strcmp(connections[i],"PMOD_JE_OUT")==0)
        {
            char cpy[256];
            strcpy(cpy,connections[i]);
            cpy[7]='\0';
            strcpy(config->peripheral[hilf],cpy);
            if(conf.verbose)
            {
                fprintf(conf.log,"\n %s \n",connections[i]);
                fflush(conf.log);
            }
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

void add_new_json(json_t new_user, const char *file){

	struct json_object *jobj;
	struct json_object *users;
	struct json_object *user;
	struct json_object *peripherals;
	struct json_object *pins_Array;

	jobj = json_object_new_object();

	users = json_object_new_array();

	user = json_object_new_object();

	json_object_object_add(user, "user", json_object_new_string(new_user.user));
	json_object_object_add(user, "design", json_object_new_string(new_user.design));
	json_object_object_add(user, "pblock", json_object_new_int(new_user.pblock));

	peripherals = json_object_new_array();

	for(int i = 0; i < new_user.peripheral_count; i++){
        json_object_array_add(peripherals, json_object_new_string(new_user.peripheral[i]));
    }

    json_object_object_add(user, "peripherals", peripherals);

	pins_Array = json_object_new_array();

	for(int i = 0; i < new_user.pin_count; i++){
        json_object_array_add(pins_Array, json_object_new_int(new_user.pins[i]));
	}

	json_object_object_add(user, "pins", pins_Array);

	json_object_array_add(users, user);

	json_object_object_add(jobj, "users", users);

    //printf("%s\n", json_object_to_json_string_ext(jobj, JSON_C_TO_STRING_SPACED | JSON_C_TO_STRING_PRETTY));

    FILE *fp;
    fp = fopen(file,"w");
    fprintf(fp, "%s\n", json_object_to_json_string_ext(jobj, JSON_C_TO_STRING_SPACED | JSON_C_TO_STRING_PRETTY));
	fclose(fp);

    json_object_put(jobj); // Delete the json object

}
