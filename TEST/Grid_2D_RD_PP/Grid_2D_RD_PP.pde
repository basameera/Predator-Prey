import controlP5.*;

import grafica.*;

import processing.dxf.*;

// https://www.youtube.com/watch?v=BV9ny785UNc
// Size of cells
int cellSize = 3;
int cols = 60;
int rows = cols;
int wh = 700;
// Colors
color baseColor = color(0);

// Plot window stuff
ControlP5 cp5;
PWindow win;
int mainLeftMargin = 0;
int plotWindowW = 850;
int midGap = 20;

void setup() {
  size (700, 700);
  cellSize= width/cols;

  prev = new Cell[cols][rows];
  grid = new Cell[cols][rows];
  
  // Instantiate arrays 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float a = 0;
      float b = 0;
      // Initialize each object
      prev[i][j] = new Cell(a, b, i*cellSize, j*cellSize, cellSize, cellSize);
      grid[i][j] = new Cell(a, b, i*cellSize, j*cellSize, cellSize, cellSize);
    }
  }
  
  //random initialization of 10 spots
  for (int n = 0; n < 10; n++) {
    int margin = 20;
    if(cols-margin>0 && rows-margin>0){
      int startx = int(random(margin, cols-margin));
      int starty = int(random(margin, rows-margin));
  
      for (int i = startx; i < startx+10; i++) {
        for (int j = starty; j < starty+10; j ++) {
          float a = a_init;
          float b = b_init;
          grid[i][j] = new Cell(a, b, i*cellSize, j*cellSize, cellSize, cellSize);
          prev[i][j] = new Cell(a, b, i*cellSize, j*cellSize, cellSize, cellSize);
        }
      }
    } else {
       println("Value ERROR: Margin out of range");
    }
  }
  float ta = 0;
  float tb = 0;
  
  for (int i = 1; i < rows - 1; i++) {
    for (int j = 1; j < cols - 1; j++) {
      ta += prev[i][j].a;
      tb += prev[i][j].b;
    }
  }
  
  Ut.add(0,log(ta));
  Vt.add(0,log(tb));
  background(baseColor); // Fill in black in case cells don't cover all the windows  
}

void draw() {
  //println(frameRate);
  for (int i = 0; i < 10; i++) {
    update();
    swap();
    
    float ta = 0;
    float tb = 0;
    
    for (int x = 1; x < rows - 1; x++) {
      for (int y = 1; y < cols - 1; y++) {
        ta += prev[x][y].a;
        tb += prev[x][y].b;
      }
    }
    
    Ut.add(timestamp,log(ta));
    Vt.add(timestamp,log(tb));
    
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
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].update();
      grid[i][j].display();
    }
  }
  
  
  
}
