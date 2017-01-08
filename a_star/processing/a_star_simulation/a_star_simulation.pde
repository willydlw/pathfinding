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

color obstacleColor = color(75);

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

boolean addObstacles = true;
boolean startup = true;
int countDown;
int displayTime = 1000;

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
}



void draw(){
  
  if(addObstacles){
    if(startup){
      background(255);
      textSize(24);
      fill(0, 240, 0);
      text("Left click to add obstacles", width/4, 7*height/24);
      text("Right click to end obstacle mode", width/4, 13*height/24);
      startup = false;
      countDown = 3;
      String msg = "Starting in " + countDown + " seconds";
      text(msg, width/4, 19*height/24);
      }
      else if(countDown > 1){
        background(255);
        text("Left click to add obstacles", width/4, 7*height/24);
        text("Right click to end obstacle mode", width/4, 13*height/24);
        countDown--;
        String msg = "Starting in " + countDown + " seconds";
        text(msg, width/4, 19*height/24);
      }
      else { // do nothing, but stay here until done adding obstacles
        path.theMap.displayGrid();
      }
  }
  else if(animate){
    if(firstStep){
      background(255);
      current = path.startPathAnimation();
      firstStep = false;
      path.theMap.displayGrid();
    }
    else if(pathNotFound){
      pathNotFound = path.findPathAnimation(); //<>//
      background(255);
      path.theMap.displayGrid();
    }
    else {
      path.theMap.displayGrid();
      noLoop();
    }
  }
  else {
    path.findPath();
    noLoop();                    // will stop after completing draw loop once more
  } 
  
  delay(displayTime);
  
}


void mousePressed(){
  if(mouseButton == LEFT){
    println("left, mouseX: " + mouseX + ", mouseY: " + mouseY);
    int col = floor(mouseX/cellSize);
    int row = floor(mouseY/cellSize);
    println("row: " + row + ", col: " + col );
    path.theMap.addObstacle(row, col, obstacleColor);
    fill(obstacleColor);
    rect(col*cellSize, row*cellSize, cellSize, cellSize);
  }
  else if(mouseButton == RIGHT){
    println("right");
    addObstacles = false;
  }
}
 