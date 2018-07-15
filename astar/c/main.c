 #include <stdlib.h>		// malloc

#include "helper.h"
#include "map.h"




 int main(int argc, char **argv){

 	int rows, cols;

    parseCommandLine(argc, argv, &rows, &cols);

 	if(rows <= 0){
 		rows = DEFAULT_ROWS;
 	}

 	if(cols <= 0){
 		cols = DEFAULT_COLS;
 	}

 	Cell *map =(Cell*)malloc(rows * cols * sizeof(Cell));

 	initializeMap(rows, cols, map);
 	addCellStateRandom(rows, cols, map, 1, GOAL);
 	addCellStateRandom(rows, cols, map, 1, START);
 	addCellStateRandom(rows, cols, map, 4, OBSTACLE);
 	printMap(rows, cols, map);


 	return 0;
 }
