/* Purpose: A* pathfinding simulation
*
*  A* finds the least cost (shortest ) path from a designated start location to
*  the goal location.
*
*  Running the program
*    Start Screen counts down and displays following messages
*      - Left mouse click place obstacle
*      - Right mouse click stops obstacle placement
*
*   Place obstacle mode
*      - Grid appears
*      - Left mouse click turns cell gray, making that cell an obstacle
*      - Right mouse click ends obstacle mode 
*
*  Place start node
*      - Left mouse click to choose start cell location
*      - A is shown to indicate start 
*
*  Place goal node
*      - Left mouse click to choose goal location
*      - B is shown to indicate goal 
*
*  Path finding simulation begins
*      - Starting at A, the shortest path to B is found
*      - The neighbors of A are evaluated, finding the cost of
*          traveling from A to its neighbor. 
*      - Costs are shown in each cell
*          Upper left, g cost: cost from A to that cell
*          Upper right, h cost: cost from that cell to goal
*          Center, f cost     : total of g and h cost
*
*      - Find cell with lowest f cost and assign costs to traversable neighbors
*          Cells in the open list are shown in green
*          Cells in the closed list are shown in red
*
*      - Continue until the shortest (least cost) path to goal is found or it is
*          determined there is no path
*
*      - The path is shown in the console window and also in yellow on the grid
*
*
*   Note: in this version, diagonal, horizontal, and vertical moves are allowed
*
*
*   Author: Diane Williams
*   Date: 1/8/2017
*
*
*/

import java.util.ArrayList;

// Global Cost Constants
static final int diagonalCost = 14;          // cost of moving one cell diagonally
static final int straightCost = 10;          // cost of moving one cell horizontally (dx) or vertically (dy)

// Grid cell colors
final color obstacleColor = color(150);            // gray
final color startColor = color(20, 69, 242);       // purple

// Start screen display time
final int startDelayTimeMs = 5000;              // milliseconds

// Grid variables
Grid gmap;               // 2D map object

int gridRows;            // number of rows in grid
int gridCols;            // number of cols in grid

int cellSize = 80;       // cells are square, size is both width and height


// Start and Goal Cells
Cell A;                  // start location
Cell B;                  // goal location


// A star algorithm object
Astar path;

// Global variables required for animation
// when animate is true, shows each iteration of updating map costs
// when animate is false, program finds the path and then displays final results
boolean animate ;
boolean firstStep;
Cell current;              // need global access to current to transition from first animation step to path finding



// State variables
boolean addObstacle;      
boolean addStartLocation;
boolean addGoalLocation;
boolean atStartup;
boolean pathNotFound;

// Start screen timing 
int startTimeMs;


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
  
  // initialize state variables
  animate = true;
  firstStep = true;
  pathNotFound = true;
  addObstacle = false;
  addStartLocation = false;
  addGoalLocation = false;
  atStartup = true;
  startTimeMs = millis();
}

void startScreen(int remainingTimeMs){
  background(255);
  textSize(24);
  fill(0, 240, 0);
  textAlign(CENTER, CENTER);
  text("A* Simulation", width/2, 3*height/24);
  text("Left click to add obstacles", width/2, 9*height/24);
  text("Right click to end obstacle mode", width/2, 13*height/24);
  String msg = "Starting in " + remainingTimeMs/1000 + " seconds";
  text(msg, width/2, 19*height/24);
}


void draw(){
  
  if(atStartup){
    surface.setTitle("Simulaion Start");
    int remainingTimeMs = startDelayTimeMs - (millis()-startTimeMs);
    startScreen(remainingTimeMs);
    if(remainingTimeMs <= 0){
      atStartup = false;
      addObstacle = true;
    }
    return;
  }
  else if(addObstacle){
    background(255); //<>//
    fill(0);
    surface.setTitle("Add Obstacles");
    gmap.displayGrid();
    return;
  }
  else if(addStartLocation){
    surface.setTitle("Add Start Location");
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(startColor);
    text("left click to add start", width/5, height/5);
    return;
  }
  else if(addGoalLocation){
    surface.setTitle("Add Goal Location");
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(startColor);
    text("left click to add goal", width/5, height/5);
    return;
  } 
  else if(animate){
    if(firstStep){
      delay(1000);
      // create A star algorithm object
      path = new Astar(A, B, gmap); 
      background(255);
      current = path.startPathAnimation();
      firstStep = false;
      path.theMap.displayGrid();
      return;
    }
    else if(pathNotFound){
      pathNotFound = path.findPathAnimation(); //<>//
      background(255);
      path.theMap.displayGrid();
    }
    else {
      path.theMap.displayGrid();
      if(path.goalFound == false){
        println("No path found from B to A");
      }
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
    
    int col = floor(mouseX/cellSize);
    int row = floor(mouseY/cellSize);
   
    if(addObstacle){
      gmap.addObstacle(row, col, obstacleColor);
      fill(obstacleColor);
      rect(col*cellSize, row*cellSize, cellSize, cellSize);
    }
    else if(addStartLocation){
      A = gmap.addStartGoal(row, col, startColor, "A");
      background(255);
      gmap.displayGrid();
      addStartLocation = false;
      addGoalLocation = true;
    }
    else if(addGoalLocation){
      background(255);
      B = gmap.addStartGoal(row, col, startColor, "B");
      gmap.displayGrid();
    
      addGoalLocation = false;
    } 
  }
  else if(mouseButton == RIGHT){
    println("right");
    if(addObstacle){
      addObstacle = false;
      addStartLocation = true;
    }
  } 
}
 