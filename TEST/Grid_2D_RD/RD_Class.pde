/*
* Reaction Diffusion Data
*/

//parameters
float dA = 1.0;
float dB = 0.5;
float dt = 1.0;
//"coral growth" simulation (f=.0545, k=.062).
float feed = 0.055;
float k = 0.062;


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
      newspot.a = a + (dA*laplaceA(i,j) - a*b*b + feed*(1-a))*dt;
      newspot.b = b + (dB*laplaceB(i,j) + a*b*b - (k+feed)*b)*dt;

      newspot.a = constrain(newspot.a, 0, 1);
      newspot.b = constrain(newspot.b, 0, 1);
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
