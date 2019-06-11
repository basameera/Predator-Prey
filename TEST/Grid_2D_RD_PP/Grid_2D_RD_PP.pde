import controlP5.*;

import grafica.*;

// https://www.youtube.com/watch?v=BV9ny785UNc
// Size of cells
int cellSize = 3;
int cols = 100;
int rows = cols;
int wh = 700;
// Colors
color baseColor = color(0);

// Plot window stuff
//ControlP5 cp5;
//PWindow win;
//int mainLeftMargin = 0;
//int plotWindowW = 850;
//int midGap = 20;

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
  for (int n = 0; n < 2; n++) {
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

  background(baseColor); // Fill in black in case cells don't cover all the windows  
}

void draw() {
  //println(frameRate);
  for (int i = 0; i < 10; i++) {
    update();
    swap();
  }
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].update();
      grid[i][j].display();
    }
  }
  
}
