class Cell{
  int x;      // x, y: physical drawing location in window
  int y;
  int row;    // row, col: physical location in a grid
  int col;
  int cellNumber;
  
  int csize;
  
  int gcost;
  int hcost;
  int fcost;
  
  String cellName;
  
  color stateColor;
  
  // List status
  boolean inOpenList;
  boolean inClosedList;
  boolean traversable;
  
  
  // Constructor
  Cell(int r, int c, int cellSize, int number){
    row = r;
    col = c;
    cellNumber = number;
   
    csize = cellSize;
    x = col * csize;
    y = row * csize;
   
    gcost = 0;
    hcost = 0;
    fcost = 0;
    stateColor = color(255, 255, 255);
    
    //cellName = new String();
    
    inOpenList = false;
    inClosedList = false;
    traversable = true;
    
  }
  
  // method for drawing the object
  void display(){
    stroke(0);
    if(cellName != null){
      fill(24, 182, 242);
    }
    else {
      fill(stateColor);
    }
    rect(x, y, csize, csize);
    fill(0);
    // display cell number
    //text(cellNumber, x+cellSize/3, y+cellSize/3);
    
    textSize(12);
    // display gcost
    if(gcost != 0 && cellName == null){
      text(gcost, x+cellSize/8, y+cellSize/4);
    }
    
    if(hcost != 0 && cellName == null){
      text(hcost, x+5*cellSize/8, y+cellSize/4);
    }
    
    if(cellName != null){
      textSize(16);
      text(cellName, x+3*cellSize/8, y+5*cellSize/8);
    }
    else if(fcost != 0 && cellName == null){
      textSize(16);
      text(fcost, x+3*cellSize/8, y+5*cellSize/8);
    }
    
  }
  
}