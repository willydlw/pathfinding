#include <stdlib.h>			// atoi
#include <string.h>			// strcmp 

#include "helper.h"


void parseCommandLine(int argc, char **argv, int *rows, int *cols)
{
	for(int i = 1; i < argc-1; i = i + 1){
		if(strcmp(argv[i], "-r") == 0){
			*rows = atoi(argv[i+1]);
		}
		else if(strcmp(argv[i], "-c") == 0){
			*cols = atoi(argv[i+1]);
		}
	}
}

