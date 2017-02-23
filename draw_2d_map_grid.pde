/** Description: create a 7 x 7 2D map
*/

int cellHeight, cellWidth;
final int mapRows = 5;
final int mapCols = 10;

void setup(){
  size(500,500);
  cellHeight = height/mapRows;
  cellWidth = width/mapCols;
}

void draw(){
  background(255);
  
  // draw vertical lines
  for(int i = 1; i < mapCols; i +=1){
    // draws vertical line
    line(i*cellWidth, 0, i*cellWidth, height);
  }
  
  // draws horizontal line
  for(int i = 1; i < mapRows; i = i + 1){
    line(0, i*cellHeight, width, i*cellHeight);
  }
  
}