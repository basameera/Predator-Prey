class PWindow extends PApplet {
  int leftMargin = 0;
  

  PWindow(int cx, int cy, int leftMarg) {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
    print(cx, cy);
    leftMargin = leftMarg;
    
  }

  void settings() {
    size(plotWindowW, 500);
  }

  void setup() {
    surface.setLocation(leftMargin + 1000 + midGap, (displayHeight-height)/2);
    background(150);
  }

  void draw() {
    //ellipse(random(width), random(height), random(50), random(50));
  }

  void mousePressed() {
    println("mousePressed in secondary window");
  }
  
  void exit()
  {
    dispose();
    win = null;
  }
}
