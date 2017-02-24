/** Create a simple robot model that spins about its center.
*
*  Date: 2/24/17
*/

Robot sparky;

void setup() {
  size(200, 200);
  
  // create a new robot object centered in the window
  sparky = new Robot(20, 50, 20, width/2, height/2);
  
}

void draw() {
  background(220);
  sparky.heading = radians(frameCount);
  sparky.display();
}