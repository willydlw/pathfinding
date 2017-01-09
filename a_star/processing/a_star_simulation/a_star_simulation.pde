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

color obstacleColor = color(150);
color startColor = color(20, 69, 242);      // purple

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
boolean animate ;
boolean firstStep;
boolean pathNotFound;
Cell current;  

// Simulation state variables
boolean addObstacle;
boolean addStartLocation;
boolean addGoalLocation;
boolean atStartup;

int startTimeMs;
final int startDelayTimeMs = 2000;

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
 