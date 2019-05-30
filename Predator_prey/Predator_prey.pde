/*
1. Cell states - prey(green), predator(red), ground(black) - appear with probability
2. GUI - simulation and control buttons in separate areas
3. Creature class - include health

4. Invoke python program with Processing
5. Simulation time
6. Num. of Preys, Predators at each instance
*/
import controlP5.*;
import grafica.*;
import java.util.Map;

ControlP5 cp5;

Animal[] PREYS;
Animal[] PREDATORS;

PWindow win;

float prob_prey = 2.0, prob_predator = 2.0; //initial probabilities
color color_prey = color(0, 200, 0), color_predator = color(200, 0, 0), color_ground = color(0);
int state_ground = 0, state_prey = 1, state_predator = 2;
int prey_count = 0, predator_count = 0;

// Size of cells
int cellSize = 50;
int settings_width = 0, cells_x = 0, cells_y = 0;
int HEIGHT=0, WIDTH=0;
int mainLeftMargin = 0;
int plotWindowW = 850;
int midGap = 20;

// Variables for timer
int interval = 100;
int lastRecordedTime = 0;

// Array of cells
int[][] cells; 
// Buffer to record the state of the cells and use this while changing the others in the interations
int[][] cellsBuffer; 

// Pause
boolean pause = true;

// === functions ===
void init_pp(int x_cells, int y_cells){
// Initialization of cells
  for (int x=0; x<x_cells; x++) {
    for (int y=0; y<y_cells; y++) {
      float state = random (0, 100);
      int value = 100;
      if (state>=0 && state<prob_prey) { 
        value = state_prey;
        prey_count++;
      }
      else if (state>=prob_prey && state<(prob_prey+prob_predator)) { 
        value = state_predator;
        predator_count++;
      }
      else {
        value = state_ground;
      }
      cells[x][y] = int(value); // Save state of each cell
    }
  }
  
  PREYS = new Animal[prey_count];
  PREDATORS = new Animal[predator_count];
  
  //init all animals
  int prey_n = 0, predator_n = 0;
  for (int x=0; x<x_cells; x++) {
    for (int y=0; y<y_cells; y++) {
      if(cells[x][y]==state_prey){
        PREYS[prey_n++] = new Animal(state_prey, x, y, x_cells, y_cells);
      }
      else if(cells[x][y]==state_predator){
        PREDATORS[predator_n++] = new Animal(state_predator, x, y, x_cells, y_cells);
      }
    }
  }
  
}

public void settings() {
  size(1000, 700);
  noSmooth();
  
}

void setup() {
  mainLeftMargin = (displayWidth-width-midGap-plotWindowW)/2;
  surface.setLocation(mainLeftMargin, (displayHeight-height)/2);
  settings_width = width - height;
  HEIGHT = height;
  WIDTH = height;
  cells_x = (width-settings_width)/cellSize;
  cells_y = height/cellSize;
  
  // Instantiate arrays
  cells = new int[cells_x][cells_y];
  cellsBuffer = new int[cells_x][cells_y];
  // This stroke will draw the background grid
  stroke(48);

  

  settingsSetup();


  //init_gameoflife();
  init_pp(cells_x, cells_y);
  background(0); // Fill in black in case cells don't cover all the windows
  drawGrid();
  
  plotNewWindow(Lokta_Volterra());
}

void drawGrid(){
  for (int x=0; x<cells_x; x++) {
    for (int y=0; y<cells_y; y++) {    
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
}

void draw() {

  //Draw grid
  drawGrid();
  
   //Iterate if timer ticks
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      //iteration();
      for(int n=0; n<PREYS.length; n++){
        int[] next_pos = PREYS[n].moveLeft();
        cells[next_pos[0]][next_pos[1]] = state_ground;
        cells[next_pos[2]][next_pos[3]] = state_prey;
      }
      
      for(int n=0; n<PREDATORS.length; n++){
        int[] next_pos = PREDATORS[n].moveDown();
        cells[next_pos[0]][next_pos[1]] = state_ground;
        cells[next_pos[2]][next_pos[3]] = state_predator;
      }
      
      lastRecordedTime = millis();
    }
  }


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

void mousePressed() {
  if(pause && mouseY>=0 && mouseY<=HEIGHT && mouseX>=0 && mouseX<=WIDTH){
    int cx = mouseX/cellSize;
    int cy = mouseY/cellSize;
    println(cy, cx, cells[cx][cy]);
    cp5.get(Textfield.class, "CELL_Y").setText(str(cy));
    cp5.get(Textfield.class, "CELL_X").setText(str(cx));

  }
}
