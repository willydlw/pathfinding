#include "map.h"

#include <stdio.h>

const int DEFAULT_ROWS = 2;
const int DEFAULT_COLS = 3;

void initializeMap(int rows, int cols, Cell *map){

	for(int i = 0; i < rows; ++i){
		for(int j = 0; j < cols; ++j){
			(map + i * cols + j)->f = 0;
			(map + i * rows + j)->g = 0;
			(map + i * rows + j)->h = 0;
            (map + i * rows + j)->parent = 0;
		}
	}
}

void printMap(int rows, int cols, Cell *map){

	for(int i = 0; i < rows; ++i){
		for(int j = 0; j < cols; ++j){
			printf("%5d", (map + i * cols + j)->f);
			printf("%5d", (map + i * rows + j)->g);
			printf("%5d", (map + i * rows + j)->h);
            printf("%5d\n", (map + i * rows + j)->parent);
		}
	}

}

