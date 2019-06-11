/*
* Reaction Diffusion Data
*/

//parameters
float dA = 1.0;
float dB = 1.0;
float dt = 0.01;
//"coral growth" simulation (f=.0545, k=.062).
float feed = 0.055;
float k = 0.062;

float ap = 1.0;
float bp = 0.1;
float cp = 1.5;
float dp = 0.075;
float T_start = 0.0, T_end = 20.0;

// Starting values
float a_init = 10.0, b_init = 10.0;

// Array of cells
Cell[][] prev;

// Buffer to record the state of the cells and use this while changing the others in the interations
Cell[][] grid;

void update() {
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j ++) {
      float a = prev[i][j].a;
      float b = prev[i][j].b;

      Cell newspot = grid[i][j]; //new values of the pixel
      newspot.a = a + (dA*laplaceA(i,j) - bp*a*b + ap*a)*dt;
      newspot.b = b + (dB*laplaceB(i,j) + dp*a*b - cp*b)*dt;

      newspot.a = constrain(newspot.a, 0, 40);
      newspot.b = constrain(newspot.b, 0, 40);
    }
  }
}

void swap() {
  Cell[][] temp = prev;
  prev = grid;
  grid = temp;
}

float laplaceA(int i, int j){
  float laplaceA = 0;
  laplaceA += prev[i][j].a*-1;
  laplaceA += prev[i+1][j].a*0.2;
  laplaceA += prev[i-1][j].a*0.2;
  laplaceA += prev[i][j+1].a*0.2;
  laplaceA += prev[i][j-1].a*0.2;
  laplaceA += prev[i-1][j-1].a*0.05;
  laplaceA += prev[i+1][j-1].a*0.05;
  laplaceA += prev[i-1][j+1].a*0.05;
  laplaceA += prev[i+1][j+1].a*0.05;
  return laplaceA;
}

float laplaceB(int i, int j){
  float laplaceB = 0;
  laplaceB += prev[i][j].b*-1;
  laplaceB += prev[i+1][j].b*0.2;
  laplaceB += prev[i-1][j].b*0.2;
  laplaceB += prev[i][j+1].b*0.2;
  laplaceB += prev[i][j-1].b*0.2;
  laplaceB += prev[i-1][j-1].b*0.05;
  laplaceB += prev[i+1][j-1].b*0.05;
  laplaceB += prev[i-1][j+1].b*0.05;
  laplaceB += prev[i+1][j+1].b*0.05;
  return laplaceB;
}
