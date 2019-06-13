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
  surface.setLocation(0, (displayHeight-height)/2);
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
      float a = a_init; //init with all preys
      float b = 0;
      // Initialize each object
      prev[i][j] = new Cell(a, b, i*cellSize, j*cellSize, cellSize, cellSize);
      grid[i][j] = new Cell(a, b, i*cellSize, j*cellSize, cellSize, cellSize);
    }
  }
  
  //random init of predators
  for (int n = 0; n < 1; n++) {
    int margin = 5;
    if(cols-margin>0 && rows-margin>0){
      int startx = int(random(margin, cols-margin));
      int starty = int(random(margin, rows-margin));
      //int startx = 32;
      //int starty = 60;
      for (int i = startx; i < startx+5; i++) {
        for (int j = starty; j < starty+5; j ++) {
          float a = 0;
          float b = b_init;
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
    //println(frameRate);
    for (int i = 0; i < 1; i++) {
      update();
      swap();
      simTime += dt;
      simSteps++;
      progressBar.setValue(map(simSteps, 0, nPoints, 0, 100));
    }
    if(simTime%10==0.0){
      println("Progress:", int(simTime), "/", int(T_end)); 
    }
    
    if(simTime>=T_end){
      pause = true;
      //noLoop();
      println("Sim Done");
      lblStatus.setText("Simulation Done");
      lblStatus.setColorValue(0xff00ff00);
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
    tf_cell_y.setText(str(cy));
    tf_cell_x.setText(str(cx));

  }
}
