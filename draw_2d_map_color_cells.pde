/** Description: create a 7 x 7 2D map
*/

int cellHeight, cellWidth;
final int mapRows = 7;
final int mapCols = 7;

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
  
  for(int r = 0; r < mapRows; r +=1){
    fill(int(random(256)),int(random(256)), int(random(256)));
    for(int c = 0; c < mapCols; c +=1){
    // draw rectangles in the first row
    rect(c*cellWidth, r*cellHeight, cellWidth, cellHeight);
    }
  }
     
  delay(500);
  
}