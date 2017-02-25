/** Purpose: Create a 2D mape using Grid and Cell objects
*
*/

Grid gmap;      // 2D map object

Robot zumo;

void setup(){
  size(491,491);
  
  // initialize cell size
  int cellSize = 70;
  
  // calculate the number of rows and columns in 2D map
  int gridRows = floor(height / cellSize);
  int gridCols = floor(width  / cellSize);
  
  // allocate memory for grid object
  gmap = new Grid(gridRows, gridCols, cellSize);
  
  // create a new robot object centered in the window
  zumo = new Robot(5, 10, 15, width/2, height/2);
  
  
}

void draw(){
  background(0);
  
  // display the map
  gmap.displayGrid();
  
  zumo.display();
  
}