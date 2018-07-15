#include <stdio.h>			// fprintf
#include <stdlib.h>			// atoi
#include <string.h>			// strcmp 

#include "helper.h"
#include "map.h"


void parseCommandLine(int argc, char **argv, int *rows, int *cols)
{
	for(int i = 1; i < argc-1; i = i + 1){
		if(strcmp(argv[i], "-r") == 0){
			int temp = atoi(argv[i+1]);
			if(temp <= MIN_ROWS){
				fprintf(stderr, "warning: argv[%d] %s violates mininimum row "
					"requirement: %d rows\n", i+1, argv[i+1], MIN_ROWS);
				fprintf(stderr, "using default rows: %d", DEFAULT_ROWS);
				*rows = DEFAULT_ROWS;
			}
			else{
				*rows = atoi(argv[i+1]);
				fprintf(stderr, "info: map rows: %d\n", *rows);
			}
			
		}
		else if(strcmp(argv[i], "-c") == 0){
			int temp = atoi(argv[i+1]);
			if(temp <= MIN_COLS){
				fprintf(stderr, "warning: argv[%d] %s violates mininimum column"
					"requirement: %d rows\n", i+1, argv[i+1], MIN_COLS);
				fprintf(stderr, "using default rows: %d", DEFAULT_COLS);
				*cols = DEFAULT_COLS;
			}
			else{
				*cols = temp;
				fprintf(stderr, "info: map cols: %d\n", *cols);
			}
			
		}
	}
}

