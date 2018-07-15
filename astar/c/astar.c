#include <assert.h>
#include <math.h>			// ceil
#include <stdlib.h>			// malloc
#include "astar.h"


void aStarSearch(int rows, int cols, Cell *grid, const Cell *start, const Cell *dest)
{
	
	// create open list
	// note: open list size of 25% arbitrarily chosen, needs testing
	//       to get a feel for the best starting size
	//       resizing can lead to inefficiency
	int openListSize = ceil(rows * cols * 0.25);
	assert(openListSize > 0);
	int openListIndex = 0;
	List* openListPtr = (List*) malloc(openListSize * sizeof(List));


	// create closed list 
	// note: this size may become a memory hog for a very large grid
	List *closedListPtr = (List*) malloc(rows*cols * sizeof(Lists);
	int closedListIndex = 0;


	// add start cell to open list
	openListPtr[openListIndex] = start;
	++openListIndex;


	// while the open list is not empty
	while(openListIndex > 0){
		// find the open list cell with the least f

		// remove it from the list
		
	}


	free(openListPtr);
	free(closeListPtr);
}

const Cell* findSmallestF(const List* list, int n)
{
	Cell *minCell = list[0].Cell;
	double minF = list[0].f;
	Cell
	for(int i = 1; i < n; ++i){
		if(list[i].f < minF){
			minF = list[i].F;
			minCell = list[i].Cell;
		}
	}

	return minCell;
}

