
// Size of cells
int cellSize = 5;
int cols = 0;
int rows = 0;

// How likely for a cell to be alive at start (in percentage)
float probabilityOfAliveAtStart = 50;

// Colors for active/inactive cells
color colorA = color(0,255,0); //prey - green
color colorB = color(255,0,0); //predator - red
color colorBase = color(0);


void setup() {
  size (900, 900);
  cols = width/cellSize;
  rows = height/cellSize;
  grid = new Cell[cols][rows];
  next = new Cell[cols][rows];
  
  // Instantiate arrays 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*cellSize, j*cellSize, cellSize, cellSize);
      grid[i][j].a = 1.0;
      grid[i][j].update();
      
      next[i][j] = new Cell(i*cellSize, j*cellSize, cellSize, cellSize);
      next[i][j].a = 1.0;
      next[i][j].update();
    }
  }
  
  // pour chemical B to chemical A
  for (int i = int(cols/2)-1; i < int(cols/2)+10; i++) {
    for (int j = int(rows/2)-1; j < int(rows/2)+10; j++) {
      grid[i][j].b = 1;
      grid[i][j].update();
    }
  }

  // This stroke will draw the background grid
  stroke(255);
  noSmooth();
  //initCells();
  background(colorBase); // Fill in black in case cells don't cover all the windows
  
  //noLoop();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].display();
    }
  }
}

void draw() {
  RD();
  swap();
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].update();
      grid[i][j].display();
    }
  }
  
}
