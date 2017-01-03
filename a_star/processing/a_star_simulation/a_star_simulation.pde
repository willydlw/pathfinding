/* A* Visualization */

import java.util.ArrayList;

// Grid information
Cell [] grid;            // array of Cell objects
int gridRows;            // number of rows in grid
int gridCols;            // number of cols in grid

int cellSize = 80;       // cells are square, size is both width and height
int cellCount;

// Start and Goal Cells
Cell A;
Cell B;

ArrayList<Cell> closedList;
ArrayList<Cell> openList;


static final int diagonalCost = 14;
static final int straightCost = 10;

void setup(){
  size(880, 480);
  gridRows = floor(height / cellSize);
  gridCols = floor(width / cellSize);
  cellCount = gridRows * gridCols;
  grid = new Cell[cellCount];
  
  // allocate memory for open and closed lists
  openList = new ArrayList<Cell>(5);
  closedList = new ArrayList<Cell>(5);
  
  // populate the grid with cell objects
  int index = 0;
  for(int r = 0; r < gridRows; r++){
    for(int c = 0; c < gridCols; c++){
      // construct Cell object with upper left coordinates of its rectangular area
      grid[index++] = new Cell(r, c, cellSize, r*gridCols + c);
    }
  }
  
  // for testing, set A as start location, B as goal location
  index = gridIndex(4,7);
  A = grid[index];
  A.cellName = new String("A");
  index = gridIndex(1,4);
  B = grid[index];
  B.cellName = new String("B");
  
  // add the start node to open list
  openList.add(A);
  A.inOpenList = true;
  
  noLoop();
  
}

void draw(){
  
  if(openList.size() > 0){
    // current = node in OPEN with lowest f cost
    int listIndex = findLowestFCost();
    
    // remove current from the open list
    Cell current = openList.remove(listIndex);
    current.inOpenList = false;
    
    // add current to the closed list
    closedList.add(current);
    current.inClosedList = true;
    
    // if current is the target node, return. path found
    if(current == B){
      println("\nTarget Node Reached");
      noLoop();
    }
    
  
    updateNeighborCost(current, A, B);
  }
  
  background(51);
  for(Cell g : grid){
    g.display();
  }

}


void zeroCost(){
  for(int i = 0; i < cellCount; i++){
    grid[i].gcost = 0;
    grid[i].hcost = 0;
    grid[i].fcost = 0;
  }
}




// G Cost based on distance from current to start
void updateNeighborCost(Cell current, Cell start, Cell goal){
  
  // update cost values in current C's 8 neighbors
  /*
       UL   U   UR
        L   C    R
       LL   L   LR
  */
  
  int neighborIndex;
  
  
  // update current's neighbors
  
  for(int nr = current.row-1; nr <= current.row+1; nr++){
    for(int nc = current.col-1; nc <= current.col+1; nc++){
      // upper left neighbor located at r-1, c-1
      neighborIndex = gridIndex(nr, nc); //<>//
      if(neighborIndex != -1){
        // upper left neighbor exists
        // find cost of path from start to C's upper left neighbor
        grid[neighborIndex].gcost = calcCost(grid[neighborIndex], start);
        grid[neighborIndex].hcost = calcCost(grid[neighborIndex], goal);
        grid[neighborIndex].fcost = grid[neighborIndex].gcost + grid[neighborIndex].hcost;
        grid[neighborIndex].stateColor = color(241, 250, 10);
      } 
    }
  }
}

int findLowestFCost(){
  int fcost = openList.get(0).fcost;
  int lowIndex = 0;
  
  for(int i = 1; i < openList.size(); i++){
    if(openList.get(i).fcost < fcost){
      lowIndex = i;
      fcost = openList.get(i).fcost;
    }
    else if(openList.get(i).fcost == fcost){
      if(openList.get(i).hcost < openList.get(lowIndex).hcost){
        lowIndex = i;
      }
    }
  }
  
  return lowIndex;
}

  
int calcCost(Cell node, Cell goal){
    
  int dx, dy, cost;
  dx = abs(node.col - goal.col);
  dy = abs(node.row - goal.row);
    
  /* straight line travel to diagonal neighbor requires traversing both
  *  dx and dy.
  *
  *  UL  dx
  *      ---
  *    dy| node
  *
  *  straightCost * (dx + dy)
  *
  *  Longer paths may consist of both straight line and diagonal moves.
  *  For diagonal moves, the cost of the straight line dx and dy travel is subtracted
  *  so that it is not double counted in the formula below.
  *
  *  Helpful explanation found at http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html
  */
  cost = straightCost * (dx + dy) + (diagonalCost - 2 * straightCost) * min(dx,dy);
  
  println("\nFunction Calc Cost");
  println("goal            row: " + goal.row + ", col: " + goal.col);
  println("node neighbor row: " + node.row + ", col: " + node.col);
  println("difference      row: " + dy);
  println("difference      col: " + dx);
  println("straight line cost : " + straightCost * (dx + dy));
  println("cost               : " + cost);
  
  return cost;
    
}
  
 
 

int gridIndex(int r, int c){
  //println("function gridIndex, r: " + r + ", c: " + c);
  if( r < 0 || c < 0 || r > gridRows-1 || c > gridCols-1){
    return -1;
  }
  else {
    return r * gridCols + c;
  }
}