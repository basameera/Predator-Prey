// A Cell object
class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x,y;   // x,y location
  float w,h;   // width and height
  color cellColor;

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, color Color) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    cellColor = Color;
  } 
  
  // Oscillation means increase angle
  void oscillate() {
    
  }

  void display() {
    // Color calculated using sine wave
    fill(cellColor);
    rect(x,y,w,h); 
  }
}
