#ifndef MAP_H_INCLUDED
#define MAP_H_INCLUDED

extern const int DEFAULT_ROWS;
extern const int DEFAULT_COLS;
extern const int MIN_ROWS;
extern const int MIN_COLS;

typedef enum { 
	EMPTY = 0,
	OBSTACLE = 1,
	START = 2,
	GOAL = 3
} CellState;

const char cellCharacter[4];

typedef struct Cell_t{
	double f;
	double g;
	double h;
	int parentr;				// parent row index
	int parentc;				// parent col index
	CellState cstate;
} Cell;

void initializeMap(int rows, int cols, Cell *map);



void printHorizontalMapLines(int n);

void printMap(int rows, int cols, Cell *map);


void addCellStateRandom(int rows, int cols, Cell *map, int numToAdd, CellState cs);


#endif
