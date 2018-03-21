#include "map.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>				// rand

const int DEFAULT_ROWS = 5;
const int DEFAULT_COLS = 7;


const char cellCharacter[4] = { ' ', '*', 'S', 'G'};

void initializeMap(int rows, int cols, Cell *map){

	for(int i = 0; i < rows; ++i){
		for(int j = 0; j < cols; ++j){
			(map + i * cols + j)->f = 0;
			(map + i * cols + j)->g = 0;
			(map + i * cols + j)->h = 0;
            (map + i * cols + j)->parent = 0;
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

void addRandomObstacles(int rows, int cols, Cell *map, int numObstacles)
{
	int r, c;
	int obstacleCount = 0;

	assert(numObstacles >= 0);

	while( obstacleCount < numObstacles){
		r = rand() % rows;
		c = rand() % cols;
		if( (map + r * cols + c)->cstate == EMPTY){
			(map + r * cols + c)->cstate = OBSTACLE ;
			++obstacleCount;
		}
	}
}

