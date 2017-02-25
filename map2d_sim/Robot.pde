class Robot{
  
  
  // From the top view, robot wheels have width and height
  int wheelWidth;
  int wheelHeight;
  
  // Top view, xy plane attributes
  int bodyRadius;
  
  color bodyColor;
  color wheelColor;
  
  // roboti's center in world coordinate system
  PVector worldCenter;
  
  float heading;
  
  
  
  
  Robot(int wwidth, int wheight, int bradius, int cx, int cy){
    wheelWidth = wwidth;
    wheelHeight = wheight;
    bodyRadius = bradius;
    worldCenter = new PVector(cx, cy);
    bodyColor = color(#0CD1F2);
    wheelColor = color(#000000);
    
    heading = 0;
  }
  
  void setHeading(float angle){
    heading = angle;
  }
  
  // top view, xy plane
  void display(){
    pushMatrix();
    translate(worldCenter.x, worldCenter.y);
    rotate(heading);
    smooth();
    rectMode(CENTER);
    stroke(0);
    // draw wheels
    fill(wheelColor);
    rect(-bodyRadius, 0, wheelWidth, wheelHeight);
    rect(bodyRadius, 0, wheelWidth, wheelHeight);
    
    // draw body
    fill(bodyColor);
    ellipse(0, 0, 2*bodyRadius, 2*bodyRadius);
    
    // draw robot's center point
    fill(0);
    ellipse(0, 0, bodyRadius/4, bodyRadius/4);
    
    // draw line to indicate robot's y axis
    stroke(#05525F);
    strokeWeight(2);
    line(0, 0, 0, -bodyRadius);
    popMatrix();
  }
} // end class definition