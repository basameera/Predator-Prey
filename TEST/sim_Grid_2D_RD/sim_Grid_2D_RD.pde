/*

*/
// https://www.youtube.com/watch?v=BV9ny785UNc
import controlP5.*;
import grafica.*;
import java.util.Map;

ControlP5 cp5;
// Size of cells
int cellSize = 10;
int cols = 0;
int rows = 0;

int settings_width = 0;
int HEIGHT=0, WIDTH=0;
int mainLeftMargin = 0;
int plotWindowW = 850;
int midGap = 20;
// Pause
boolean pause = true;

PWindow win;

// Colors
color baseColor = color(0);

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
  cols = (width-settings_width)/cellSize;
  rows = height/cellSize;
  
  prev = new Cell[cols][rows];
  grid = new Cell[cols][rows];
  
  simSettingsSetup();
  
  background(baseColor); // Fill in black in case cells don't cover all the windows
  
  initDraw();
  
}

void initDraw(){
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
  
  //inital draw
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].update();
      grid[i][j].display();
    }
  } 
}

void draw() {
  if (!pause) {
    for (int i = 0; i < 10; i++) {
      update();
      swap();
      simTime += dt;
    }
    
    if(simTime>=T_end){
      pause = true;
      //noLoop();
      println("Sim Done");
    }
    
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].update();
        grid[i][j].display();
      }
    }
  }
}

void mousePressed() {
  if(pause && mouseY>=0 && mouseY<=HEIGHT && mouseX>=0 && mouseX<=WIDTH){
    int cx = mouseX/cellSize;
    int cy = mouseY/cellSize;
    println("mouse press cell selection:", cy, cx);
    cp5.get(Textfield.class, "CELL_Y").setText(str(cy));
    cp5.get(Textfield.class, "CELL_X").setText(str(cx));

  }
}
