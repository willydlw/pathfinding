#ifndef MAP_H_INCLUDED
#define MAP_H_INCLUDED

extern const int DEFAULT_ROWS;
extern const int DEFAULT_COLS;

typedef struct Cell_t{
	int f;
	int g;
	int h;
	int parent;
} Cell;

void initializeMap(int rows, int cols, Cell *map);

void printMap(int rows, int cols, Cell *map);

#endif
