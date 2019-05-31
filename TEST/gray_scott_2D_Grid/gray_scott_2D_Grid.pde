
// Size of cells
int cellSize = 2;
int cols = 0;
int rows = 0;

// How likely for a cell to be alive at start (in percentage)
float probabilityOfAliveAtStart = 50;

// Colors for active/inactive cells
color colorA = color(0,255,0); //prey - green
color colorB = color(255,0,0); //predator - red
color colorBase = color(0);


void setup() {
  size (700, 700);
  cols = width/cellSize;
  rows = height/cellSize;
  grid = new Cell[cols][rows];
  
  // Instantiate arrays 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      color ccc;
      if (random (100) > probabilityOfAliveAtStart) { 
        ccc = colorBase;
      }
      else {
        ccc = colorA;
      }
      grid[i][j] = new Cell(i*cellSize, j*cellSize, cellSize, cellSize, ccc);
    }
  }

  // This stroke will draw the background grid
  stroke(20);
  noSmooth();
  //initCells();
  background(colorBase); // Fill in black in case cells don't cover all the windows
  
  noLoop();
}

void draw() {
  //drawGrid();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].display();
    }
  }
}

//void initCells(){
//  // Initialization of cells
//  for (int x=0; x<width/cellSize; x++) {
//    for (int y=0; y<height/cellSize; y++) {
//      float state = random (100);
//      if (state > probabilityOfAliveAtStart) { 
//        state = 0;
//      }
//      else {
//        state = 1;
//      }
//      grid[x][y] = int(state); // Save state of each cell
//    }
//  }
//}

//void drawGrid(){
//  ////Draw grid
//  for (int x=0; x<width/cellSize; x++) {
//    for (int y=0; y<height/cellSize; y++) {
//      if (grid[x][y]==1) {
//        fill(colorA); // If alive
//      }
//      else {
//        fill(base); // If dead
//      }
//      rect (x*cellSize, y*cellSize, cellSize, cellSize);
//    }
//  }
//}
