class Astar{
  
  final color openListColor = color(#0AFA98);          // green
  final color closedListColor = color(255, 25, 75);    // red
  final color obstacleColor = color(75);
  
  Cell A;          // start cell
  Cell B;          // goal cell
  Grid theMap;
  
  // cells to be evaluated
  ArrayList<Cell> openList; 
    
  // cells already evaluated
  ArrayList<Cell> closedList; 
  
  boolean goalFound;
  
  
  Astar(Cell start, Cell goal, Grid gmap){
    A = start;
    B = goal;
    theMap = gmap;
    goalFound = false;
    
    // allocate memory for open and closed lists
    int initialListSize = floor(gmap.cellCount/10);
    
    openList = new ArrayList<Cell>(initialListSize); 
    closedList = new ArrayList<Cell>(initialListSize);    
  
  }
  
  void findPath(){
    
    // zero all gcost, hcost and fcost to clear the map
    theMap.resetGrid(false); //<>//
    
    // clear open and closed lists
    openList.clear();
    closedList.clear();
    
    // add the start node to open list
    openList.add(A);
    A.inOpenList = true;
    A.stateColor = openListColor; 
    
    
    Cell current = A;
    
    // loop 
    while(openList.size() > 0){ //<>//
      
      // set current to node in OPEN list with lowest f cost
      // assuming that open list is not empty. Should find a path before 
      //   emptying the open list
      int listIndex = findLowestFCost();
    
      // remove current from the open list
      current = openList.remove(listIndex);
      current.inOpenList = false;
    
      // add current to the closed list
      closedList.add(current);
      current.inClosedList = true;
      // cells in closed list are shown in red
      current.stateColor = closedListColor;
      
      // if current is the target node,  path found
      if(current == B){
        path.goalFound = true;
        println("\nTarget Node Reached");
        println("Path from goal node B to start node A shown in red");
        print("B -> ");
        B.stateColor = color(255, 255, 0);
        current = gmap.cellArray[current.parentIndex];
        current.stateColor = color(255, 255, 10);
        int num;
        while(current != A){
          num = gmap.gridIndex(current.row, current.col);
          print(num + "-> ");
          current = gmap.cellArray[current.parentIndex];
          current.stateColor = color(255, 255, 10);
        }
        
        println(" A");
        return;
      }
      else{
        updateNeighborCost(current, A, B);
        redraw();
      }
    }
    
  }
  
  Cell startPathAnimation(){
    // zero all gcost, hcost and fcost to clear the map
    theMap.resetGrid(false);
    
    // store cell names, reset cleared any that were stored
    A.cellName = new String("A");
    B.cellName = new String("B");
    
    // clear open and closed lists
    openList.clear();
    closedList.clear();
    
    // add the start node to open list
    openList.add(A);
    A.inOpenList = true;
    A.stateColor = openListColor; 
    
    return A;
  }
  
  
  boolean findPathAnimation(){
    // if no path is found, open list will be empty at some point
    // This will end the path finding.
    if(openList.size() > 0){
      
      // set current to node in OPEN list with lowest f cost
      // assuming that open list is not empty. Should find a path before 
      //   emptying the open list
      int listIndex = findLowestFCost();
    
      // remove current from the open list
      current = openList.remove(listIndex);
      current.inOpenList = false;
    
      // add current to the closed list
      closedList.add(current);
      current.inClosedList = true;
      // cells in closed list are shown in red
      current.stateColor = closedListColor;
      
      // if current is the target node,  path found
      if(current == B){
        path.goalFound = true;
        // Display output in console
        println("\nTarget Node Reached");
        println("Path from goal node B to start node A shown in red");
        print("B -> ");
        
        // show path from B to A in yellow
        B.stateColor = color(255, 255, 0);
        current = gmap.cellArray[current.parentIndex];
        current.stateColor = color(255, 255, 0);
        
        int num;
        while(current != A){
          num = gmap.gridIndex(current.row, current.col);
          print(num + "-> ");
          current = gmap.cellArray[current.parentIndex];
          current.stateColor = color(255, 255, 0);
        }
        
        println(" A");
        return false;      
      }
      else{
        updateNeighborCost(current, A, B);
        return true;
      }
    }
    return false;
  }
  
  
  int findLowestFCost(){
    int fcost = openList.get(0).fcost;
    int lowIndex = 0;
    
    for(int i = 1; i < openList.size(); i++){
      if(openList.get(i).fcost < fcost){
        lowIndex = i;
        fcost = openList.get(i).fcost;
      }
      else if(openList.get(i).fcost == fcost){
        if(openList.get(i).hcost < openList.get(lowIndex).hcost){
          lowIndex = i;
        }
      }
    }
    
    return lowIndex;
  }
  

  void updateNeighborCost(Cell current, Cell start, Cell goal){
    
    // update cost values in current C's 8 neighbors
    /*
         UL   U   UR
          L   C    R
         LL   L   LR
    */
    
    int neighborIndex;
    
    // update current's neighbors
    for(int nr = current.row-1; nr <= current.row+1; nr++){
      for(int nc = current.col-1; nc <= current.col+1; nc++){
        // upper left neighbor located at r-1, c-1
        neighborIndex = gmap.gridIndex(nr, nc);
        if(neighborIndex != -1){                // neighbor exists
          
          // if the neighbor is not traversable or neighbor is in closed list
          //    skip to the next neighbor
          if( gmap.cellArray[neighborIndex].traversable && !gmap.cellArray[neighborIndex].inClosedList){
            // find cost of new path 
            int new_gcost = calcCost(gmap.cellArray[neighborIndex], current) + current.gcost;
            int new_hcost = calcCost(gmap.cellArray[neighborIndex], goal);
            int new_fcost = new_gcost + new_hcost;
            
            // if new path to neighbor is shorter OR neighbor is not in OPEN list
            if(new_fcost < gmap.cellArray[neighborIndex].fcost || !gmap.cellArray[neighborIndex].inOpenList){
              gmap.cellArray[neighborIndex].gcost = new_gcost;
              gmap.cellArray[neighborIndex].hcost = new_hcost;
              gmap.cellArray[neighborIndex].fcost = new_fcost;
              
              // set parent of neighbor to current
              gmap.cellArray[neighborIndex].parentIndex = gmap.gridIndex(current.row, current.col);
              
              // if neighbor is not in OPEN list
              if(!gmap.cellArray[neighborIndex].inOpenList){
                // add neighbor to OPEN
                openList.add(gmap.cellArray[neighborIndex]);
                gmap.cellArray[neighborIndex].inOpenList = true;
                // show cells in the open list as green
                gmap.cellArray[neighborIndex].stateColor = color(#0AFA98);
              }
            }
          }
        } 
      }
    }
  }
  
  
  
  
  // Calculate the cost of the shortest movement from the node to the goal
  int calcCost(Cell node, Cell goal){
      
    int dx, dy, cost;
    dx = abs(node.col - goal.col);
    dy = abs(node.row - goal.row);
      
    /* straight line travel to diagonal neighbor requires traversing both
    *  dx and dy.
    *
    *  UL  dx
    *      ---
    *    dy| node
    *
    *  straightCost * (dx + dy)
    *
    *  Longer paths may consist of both straight line and diagonal moves.
    *  For diagonal moves, the cost of the straight line dx and dy travel is subtracted
    *  so that it is not double counted in the formula below.
    *
    *  Helpful explanation found at http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html
    */
    cost = straightCost * (dx + dy) + (diagonalCost - 2 * straightCost) * min(dx,dy);
    
    /*
    println("\nFunction Calc Cost");
    println("goal            row: " + goal.row + ", col: " + goal.col);
    println("node neighbor row: " + node.row + ", col: " + node.col);
    println("difference      row: " + dy);
    println("difference      col: " + dx);
    println("straight line cost : " + straightCost * (dx + dy));
    println("cost               : " + cost);
    */
    
    return cost;
      
  }
}