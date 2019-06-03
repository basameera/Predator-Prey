// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for this video: https://youtu.be/BV9ny785UNc

// Written entirely based on
// http://www.karlsims.com/rd.html

// Also, for reference
// http://hg.postspectacular.com/toxiclibs/src/44d9932dbc9f9c69a170643e2d459f449562b750/src.sim/toxi/sim/grayscott/GrayScott.java?at=default

Cell[][] grid;
Cell[][] prev;

//parameters
float dA = 1.0;
float dB = 0.5;
float dt = 1.0;

//"mitosis" simulation (f=.0367, k=.0649)
//float feed = 0.0367;
//float k = 0.0649;

//"coral growth" simulation (f=.0545, k=.062).
float feed = 0.055;
float k = 0.062;


void setup() {
  size(500, 500);
  print(width, height);
  
  grid = new Cell[width][height];
  prev = new Cell[width][height];

  //full grid initialization
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j ++) {
      float a = 1;
      float b = 0;
      grid[i][j] = new Cell(a, b);
      prev[i][j] = new Cell(a, b);
    }
  }

  //random initialization of 10 spots
  for (int n = 0; n < 10; n++) {
    int startx = int(random(20, width-20));
    int starty = int(random(20, height-20));

    for (int i = startx; i < startx+10; i++) {
      for (int j = starty; j < starty+10; j ++) {
        float a = 1;
        float b = 1;
        grid[i][j] = new Cell(a, b);
        prev[i][j] = new Cell(a, b);
      }
    }
  }
}

void update() {
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {

      float a = prev[i][j].a;
      float b = prev[i][j].b;

      float laplaceA = 0;
      laplaceA += a*-1;
      laplaceA += prev[i+1][j].a*0.2;
      laplaceA += prev[i-1][j].a*0.2;
      laplaceA += prev[i][j+1].a*0.2;
      laplaceA += prev[i][j-1].a*0.2;
      laplaceA += prev[i-1][j-1].a*0.05;
      laplaceA += prev[i+1][j-1].a*0.05;
      laplaceA += prev[i-1][j+1].a*0.05;
      laplaceA += prev[i+1][j+1].a*0.05;

      float laplaceB = 0;
      laplaceB += b*-1;
      laplaceB += prev[i+1][j].b*0.2;
      laplaceB += prev[i-1][j].b*0.2;
      laplaceB += prev[i][j+1].b*0.2;
      laplaceB += prev[i][j-1].b*0.2;
      laplaceB += prev[i-1][j-1].b*0.05;
      laplaceB += prev[i+1][j-1].b*0.05;
      laplaceB += prev[i-1][j+1].b*0.05;
      laplaceB += prev[i+1][j+1].b*0.05;

      Cell newspot = grid[i][j]; //new values of the pixel
      newspot.a = a + (dA*laplaceA - a*b*b + feed*(1-a))*dt;
      newspot.b = b + (dB*laplaceB + a*b*b - (k+feed)*b)*dt;

      newspot.a = constrain(newspot.a, 0, 1);
      newspot.b = constrain(newspot.b, 0, 1);
    }
  }
}

void swap() {
  Cell[][] temp = prev;
  prev = grid;
  grid = temp;
}

void draw() {
  //println(frameRate);

  for (int i = 0; i < 1; i++) {
    update();
    swap();
  }

  loadPixels();
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {
      Cell spot = grid[i][j];
      float a = spot.a;
      float b = spot.b;
      int pos = i + j * width;
      //pixels[pos] = color((a-b)*255);
      pixels[pos] = color(a*255, 0, b*255);
      
    }
  }
  updatePixels();
}
