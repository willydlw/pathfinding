#include "map.h"

#include <assert.h>
#include <float.h>				// DBL_MAX
#include <stdio.h>
#include <stdlib.h>				// rand


const int DEFAULT_ROWS = 5;
const int DEFAULT_COLS = 7;

const int MIN_ROWS = 2;
const int MIN_COLS = 2;


const char cellCharacter[4] = { ' ', '*', 'S', 'G'};

void initializeMap(int rows, int cols, Cell *map){

	for(int i = 0; i < rows; ++i){
		for(int j = 0; j < cols; ++j){
			(map + i * cols + j)->f = DBL_MAX;
			(map + i * cols + j)->g = DBL_MAX;
			(map + i * cols + j)->h = DBL_MAX;
            (map + i * cols + j)->parentr = -1;
            (map + i * cols + j)->parentc = -1;

            (map + i * cols + j)->cstate = EMPTY;
		}
	}
}

void printMap(int rows, int cols, Cell *map){

	for(int i = 0; i < rows; ++i){
		printHorizontalMapLines(cols);
		for(int j = 0; j < cols; ++j){
			printf(" %c |", cellCharacter[(map + i * cols + j)->cstate]);
		}
		printf("\n");
	}

	printHorizontalMapLines(cols);
}

void printHorizontalMapLines(int n)
{
	for(int i = 0; i < n; ++i){
		fprintf(stderr, "%4s", "----");
	}
	puts("");
}

void addCellStateRandom(int rows, int cols, Cell *map, int numToAdd, CellState cs)
{
	int r, c;
	int count = 0;

	assert(numToAdd >= 0);

	while( count < numToAdd){
		r = rand() % rows;
		c = rand() % cols;
		if( (map + r * cols + c)->cstate == EMPTY){
			(map + r * cols + c)->cstate = cs ;
			if(cs == START){
				(map + r * cols + c)->parentr = r;
				(map + r * cols + c)->parentc = c;
				(map + r * cols + c)->f = 0.0;
				(map + r * cols + c)->g = 0.0;
				(map + r * cols + c)->h = 0.0;
			}
			++count;
		}
	}
}

