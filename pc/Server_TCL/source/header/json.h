
typedef struct json_s {
	char user[256];
	char design[256];
	int pblock;
	char peripheral[7][256];
	int peripheral_count;
	int pins[32];
	int pin_count;
} json_t;

void parse_json(json_t content[8], const char *file);
void add_user_json(json_t new_user, const char *file);

void addconnections(json_t *config,char connections[][256],int concount);

void add_new_json(json_t new_user, const char *file);
