// https://www.youtube.com/watch?v=BV9ny785UNc
// Size of cells
int cellSize = 3;
int cols = 0;
int rows = 0;

// Colors
color baseColor = color(0);

void setup() {
  size (900, 900);
  cols = width/cellSize;
  rows = height/cellSize;
  prev = new Cell[cols][rows];
  grid = new Cell[cols][rows];
  
  // Instantiate arrays 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float a = 1;
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
          float a = 1;
          float b = 1;
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
