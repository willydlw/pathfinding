class Cell{
  
  // define the cell attributes
  int x;            // x,y upper left corner of rectangle
  int y;
  
  int row;          // row, col physical location in a grid
  int col;
  
  int cellSize;    // square, width and height are the same
  
  color stateColor;
  
  // Constructor
  Cell(int r, int c, int csize){
    row = r;
    col = c;
    cellSize = csize;
    
    // x, y are physical coordinates
    x = col * cellSize;    
    y = row * cellSize; 
    
    stateColor = color(220);
  }
  
  void display(){
    rectMode(CORNER);
    stroke(0);      // black stroke border
    strokeWeight(1);
    fill(stateColor);
    rect(x, y, cellSize, cellSize);
  }
  
  
} // end class Cell