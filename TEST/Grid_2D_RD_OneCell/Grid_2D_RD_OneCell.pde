import controlP5.*;

import grafica.*;

import processing.dxf.*;

// https://www.youtube.com/watch?v=BV9ny785UNc
// Size of cells
int cellSize = 100;
int cols = 0;
int rows = 0;

// Colors
color baseColor = color(0);


ControlP5 cp5;
PWindow win;
int mainLeftMargin = 0;
int plotWindowW = 850;
int midGap = 20;



void setup() {
  size (900, 900);
  cols = 1; // width/cellSize;
  rows = 1; //height/cellSize;
  prev = new Cell[cols][rows];
  grid = new Cell[cols][rows];
  
  // Instantiate arrays 

  float a = a_init;
  float b = b_init;

  prev[0][0] = new Cell(a, b, 0*cellSize, 0*cellSize, cellSize, cellSize);
  grid[0][0] = new Cell(a, b, 0*cellSize, 0*cellSize, cellSize, cellSize);
  
  Ut.add(0,prev[0][0].a);
  Vt.add(0,prev[0][0].b);
  
  //random initialization of 10 spots
  //for (int n = 0; n < 1; n++) {
  //  int margin = 20;
  //  if(cols-margin>0 && rows-margin>0){
  //    int startx = int(random(margin, cols-margin));
  //    int starty = int(random(margin, rows-margin));
  
  //    for (int i = startx; i < startx+10; i++) {
  //      for (int j = starty; j < starty+10; j ++) {
  //        float a = 1;
  //        float b = 1;
  //        grid[i][j] = new Cell(a, b, i*cellSize, j*cellSize, cellSize, cellSize);
  //        prev[i][j] = new Cell(a, b, i*cellSize, j*cellSize, cellSize, cellSize);
  //      }
  //    }
  //  } else if (cols == 1 && rows == 1){
  //    float a = 
      
  //  } else {
  //    println("Value ERROR: Margin out of range");

  //  }
  //}

  background(baseColor); // Fill in black in case cells don't cover all the windows
  
}

void draw() {
  //println(frameRate);
  for (int i = 0; i < 10; i++) {
    update();
    
    swap();
    
    Ut.add(timestamp, prev[0][0].a);
    Vt.add(timestamp, prev[0][0].b);
    timestamp++;
  }
  
  if (timestamp >= nPoints) {
    HashMap<String, GPointsArray> hm = new HashMap<String, GPointsArray>();

    // Putting key-value pairs in the HashMap
    hm.put("Ut", Ut);
    hm.put("Vt", Vt);
    
    plotNewWindow(hm);
    
    noLoop();
  }
  grid[0][0].update();
  grid[0][0].display();

  
}
