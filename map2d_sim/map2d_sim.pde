/** Purpose: Create a 2D mape using Grid and Cell objects
*
*/

Grid gmap;      // 2D map object

Robot zumo;
final float pixels_per_cm = 5;
final float map_width_inches = 7.0f * 12.0f;
final float map_width_cm = map_width_inches * 2.54f;
final float map_pixel_width = map_width_cm * pixels_per_cm;

PVector A7;


void setup(){
  /* map_pixel_width = map_width_cm * pixels_per_cm;
     7.0 tiles * 12 in/tile * 2.54 cm/in * 5 pixels/cm = 1067
   
     P2D (Processing 2D): 2D graphics renderer that makes use of OpenGL-compatible 
     graphics hardware.
  */
  size(854, 854, P2D);
  
  // initialize cell size
  int cellSize = 70;
  
  // calculate the number of rows and columns in 2D map
  int gridRows = floor(height / cellSize);
  int gridCols = floor(width  / cellSize);
  
  // allocate memory for grid object
  gmap = new Grid(gridRows, gridCols, cellSize);
  
  // create a new robot object centered in the window
  zumo = new Robot(5, 10, 15, cellSize/2, gridRows*cellSize-cellSize/2);
  
  
}

void draw(){
  background(0);
  
  // display the map
  gmap.display();
  
  zumo.display();
  
}