class Grid{
  
  Cell[] cellArray;
  
  int rows;
  int cols;
  int cellCount;
  
  // constructor
  Grid(int numRows, int numCols, int cellSize){
    rows = numRows;
    cols = numCols;
    cellCount = rows * cols;
    
    cellArray = new Cell[cellCount];
    
    // populate the grid with cell objects
    int index = 0;
    for(int r = 0; r < rows; r++){
      for(int c = 0; c < cols; c++){
        // construct Cell object
        cellArray[index++] = new Cell(r, c, cellSize);
      }
    }
  }
  
  void displayGrid(){
    for(Cell g : cellArray){
      g.display();
    }
  }
  
} // end class Grid