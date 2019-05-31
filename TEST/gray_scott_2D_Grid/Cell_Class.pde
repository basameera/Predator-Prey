// A Cell object
class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x,y;   // x,y location
  float w,h;   // width and height
  color cellColor = color(0); //cell color
  private float a=0.0, b=0.0;

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, color Color) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    cellColor = Color;
    this.update();
  }
  
  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  }
  
  //and determine the color
  void update(){
    //this.cellColor = color(0, int( ((this.a) - (this.b))*255 ), 0);
    this.cellColor = color(int(this.a*255), int(this.b*255), 0);
  }

  void display() {
    // Color calculated using sine wave
    stroke(this.cellColor);
    fill(this.cellColor);
    rect(x,y,w,h); 
  }
  
  void display(color Color) {
    // Color calculated using sine wave
    fill(Color);
    rect(x,y,w,h); 
  }
}
