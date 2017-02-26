class ProximitySensor{
  
  float distancecm;        // units, cm
  float min_distancecm;    // minimum measured distance, cm
  float max_distancecm;    // maximum measured distance, cm
  
  float heading;           // world or robot coordinates?
  PVector location;        // world or robot coordinates?
  
  color sensorColor;
  int diameter;
  
  // constructor
  ProximitySensor(int wx, int wy, float angle, float mindistcm, 
                  float maxdistcm){
    
    location = new PVector(wx, wy);
    heading = angle;
    min_distancecm = mindistcm;
    max_distancecm = maxdistcm;
    sensorColor = color(#F57D0C);
    diameter = 15;
  }
  
  void display(){
    pushMatrix();
    translate(location.x, location.y);
    rotate(heading);
    
    smooth();
    fill(sensorColor);
    ellipse(0, 0, diameter, diameter);
    
    // draw line to indicate robot's y axis
    stroke(#05525F);
    strokeWeight(2);
    line(0, 0, 0, diameter);
    popMatrix();
  }
  
  float[] sweep(float startAngle, float stopAngle, float deltaTheta){
    int length = floor( (stopAngle-startAngle)/deltaTheta)+1;
    float []distance = new float[length];
    
    float angle = startAngle;
  
    for(int i = 0; i < length; i +=1, angle += deltaTheta){
      distance[i] = 10;
    }    
    return distance;
  }
  
    
  
  
} // end class definition