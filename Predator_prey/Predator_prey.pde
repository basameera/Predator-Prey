/*
1. Cell states - prey(green), predator(red), ground(black) - appear with probability
2. GUI - simulation and control buttons in separate areas
3. Creature class - include health

*/

Animal h1 = new Animal(20);

float prob_prey = 15.0, prob_predator = 10.0; //initial probabilities
color color_prey = color(0, 200, 0), color_predator = color(200, 0, 0), color_ground = color(0);
int state_ground = 0, state_prey = 1, state_predator = 2;

int settings_width = 300;

// Size of cells
int cellSize = 10;

// How likely for a cell to be alive at start (in percentage)
float probabilityOfAliveAtStart = 15;

// Variables for timer
int interval = 100;
int lastRecordedTime = 0;

// Colors for active/inactive cells
color alive = color(0, 200, 0);
color dead = color(0);

// Array of cells
int[][] cells; 
// Buffer to record the state of the cells and use this while changing the others in the interations
int[][] cellsBuffer; 

// Pause
boolean pause = false;

// === functions ===
void init_pp(){
// Initialization of cells
  for (int x=0; x<(width-settings_width)/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      float state = random (0, 100);
      int value = 100;
      if (state>=0 && state<prob_prey) { 
        value = state_prey;
      }
      else if (state>=prob_prey && state<(prob_prey+prob_predator)) { 
        value = state_predator;
      }
      else {
        value = state_ground;
      }
      cells[x][y] = int(value); // Save state of each cell
    }
  } 
}



void setup() {
  size(1000, 700);
  
  // Instantiate arrays 
  cells = new int[width-settings_width/cellSize][height/cellSize];
  cellsBuffer = new int[width-settings_width/cellSize][height/cellSize];

  // This stroke will draw the background grid
  stroke(48);

  noSmooth();

  //init_gameoflife();
  init_pp();
  background(0); // Fill in black in case cells don't cover all the windows
}


void draw() {

  //Draw grid
  for (int x=0; x<(width-settings_width)/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      if (cells[x][y]==state_prey) {
        fill(color_prey);
      }
      else if (cells[x][y]==state_predator) {
        fill(color_predator);
      }
      else {
        fill(color_ground);
      }
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  // Iterate if timer ticks
  //if (millis()-lastRecordedTime>interval) {
  //  if (!pause) {
  //    iteration();
  //    lastRecordedTime = millis();
  //  }
  //}


}



void iteration() { // When the clock ticks
  // Save cells to buffer (so we opeate with one array keeping the other intact)
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }

  // Visit each cell:
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      // And visit all the neighbours of each cell
      int neighbours = 0; // We'll count the neighbours
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1;yy++) {  
          if (((xx>=0)&&(xx<width/cellSize))&&((yy>=0)&&(yy<height/cellSize))) { // Make sure you are not out of bounds
            if (!((xx==x)&&(yy==y))) { // Make sure to to check against self
              if (cellsBuffer[xx][yy]==1){
                neighbours ++; // Check alive neighbours and count them
              }
            } // End of if
          } // End of if
        } // End of yy loop
      } //End of xx loop
      // We've checked the neigbours: apply rules!
      if (cellsBuffer[x][y]==1) { // The cell is alive: kill it if necessary
        if (neighbours < 2 || neighbours > 3) {
          cells[x][y] = 0; // Die unless it has 2 or 3 neighbours
        }
      } 
      else { // The cell is dead: make it live if necessary      
        if (neighbours == 3 ) {
          cells[x][y] = 1; // Only if it has 3 neighbours
        }
      } // End of if
    } // End of y loop
  } // End of x loop
} // End of function

void keyPressed() {
  if (key=='r' || key == 'R') {
    // Restart: reinitialization of cells
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        float state = random (100);
        if (state > probabilityOfAliveAtStart) {
          state = 0;
        }
        else {
          state = 1;
        }
        cells[x][y] = int(state); // Save state of each cell
      }
    }
  }
  if (key==' ') { // On/off of pause
    pause = !pause;
  }
  if (key=='c' || key == 'C') { // Clear all
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
  }
}

void init_gameoflife(){
// Initialization of cells
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      float state = random (100);
      if (state > probabilityOfAliveAtStart) { 
        state = 0;
      }
      else {
        state = 1;
      }
      cells[x][y] = int(state); // Save state of each cell
    }
  } 
}
