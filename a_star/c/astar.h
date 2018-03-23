#ifndef ASTAR_H_INCLUDED
#define ASTAR_H_INCLUDED

#include "map.h"				// Cell

typedef struct list_t{
		double f;
		Cell *ptr;
}List;

void aStarSearch(int rows, int cols, Cell *grid, const Cell *start, const Cell *dest);

const Cell* findSmallestF(const List *list, int n);


#endif
