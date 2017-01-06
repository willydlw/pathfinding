class Grid{
  Cell[] cellArray;
  int rows;
  int cols;
  int cellCount;
  
  Grid(int numRows, int numCols){
    rows = numRows;
    cols = numCols;
    cellCount = rows*cols;
    
    cellArray = new Cell[cellCount];
    
    // populate the grid with cell objects
    int index = 0;
    for(int r = 0; r < rows; r++){
      for(int c = 0; c < cols; c++){
        // construct Cell object with upper left coordinates of its rectangular area
        cellArray[index++] = new Cell(r, c, cellSize, r*cols + c);
      }
    }
  }
  
  int gridIndex(int r, int c){
    //println("function gridIndex, r: " + r + ", c: " + c);
    if( r < 0 || c < 0 || r > gridRows-1 || c > gridCols-1){
      return -1;
    }
    else {
      return r * gridCols + c;
    }
  }

   void displayGrid(){
    for(Cell g : cellArray){
      g.display();
    }
  }
  
  void zeroCost(){
    for(int i = 0; i < gmap.cellCount; i++){
      cellArray[i].gcost = 0;
      cellArray[i].hcost = 0;
      cellArray[i].fcost = 0;
    }
  }
}