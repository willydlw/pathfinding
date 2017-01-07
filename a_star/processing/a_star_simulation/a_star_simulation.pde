/* Purpose: A* pathfinding simulation
*
*  A* finds the least cost (shortest ) path from a designated start location to
*  the goal location.
*
*  A is the start cell
*  B is the goal cell
*/

import java.util.ArrayList;

// Global Constants
static final int diagonalCost = 14;
static final int straightCost = 10;

// Grid variables
Grid gmap;               // 2D map object

int gridRows;            // number of rows in grid
int gridCols;            // number of cols in grid

int cellSize = 80;       // cells are square, size is both width and height


// Start and Goal Cells
Cell A;
Cell B;



// A star algorithm object
Astar path;

// Global variables required for animation
// when animate is true, shows each iteration of updating map costs
// when animate is false, program finds the path and then displays final results
boolean animate = true;
boolean firstStep = true;
boolean pathNotFound = true;
Cell current;             


void setup(){
  size(880, 480);
  frameRate(5);
  
  // calculate number of rows and columns in 2D map
  gridRows = floor(height / cellSize);
  gridCols = floor(width / cellSize);
  
  // allocate memory for grid object
  gmap = new Grid(gridRows, gridCols);
  
  
  // for testing, set A as start location, B as goal location
  int index = gmap.gridIndex(4,7);
  A = gmap.cellArray[index];
  
  index = gmap.gridIndex(1,4);
  B = gmap.cellArray[index];
  
  
  // create A star algorithm object
  path = new Astar(A, B, gmap);
  
  
  
  //noLoop();      // draw loop executes once only
  
}

void draw(){
  
  
  if(animate){
    if(firstStep){
      background(51);
      current = path.startPathAnimation(); //<>//
      path.theMap.displayGrid();
      delay(1000);
      firstStep = false;
    }
    else if(pathNotFound){
      pathNotFound = path.findPathAnimation(); //<>//
      background(51);
      path.theMap.displayGrid();
      delay(1000);
    }
    else {
      noLoop();
    }
  }
  else {
    path.findPath();
    path.theMap.displayGrid();
    noLoop();                    // will stop after completing draw loop once more
  }  //<>//
}

 //<>//
  
 