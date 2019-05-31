/*
* Reaction Diffusion Data
*/

float dA = 1.0;
float dB = 0.5;
//float feed = 0.055;
//float k = 0.062;
float feed = 0.0545;
float k = 0.062;
// f=.0545, k=.062

// Array of cells
//int[][] grid; 
Cell[][] grid;

// Buffer to record the state of the cells and use this while changing the others in the interations
//int[][] next;
Cell[][] next;

Cell[][] temp;

// Reaction Diffusion - update a, b values
void RD(){
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
      float a = grid[i][j].a;
      float b = grid[i][j].b;
      next[i][j].a =  a + 
                      (dA * laplaceA(i, j)) - 
                      (a*b*b) +
                      (feed*(1.0-a));
      next[i][j].b =  b + 
                      (dB * laplaceB(i, j)) - 
                      (a*b*b) +
                      ((k+feed)*b);
                      
      next[i][j].a = constrain(next[i][j].a, 0.0, 1.0);
      next[i][j].b = constrain(next[i][j].b, 0.0, 1.0);
    }
  }
  
}

void swap(){
  grid = next;
}

float laplaceA(int x, int y){
  float sum = 0.0;
  sum += grid[x][y].a * -1;
  sum += grid[x-1][y].a * 0.2;
  sum += grid[x+1][y].a * 0.2;
  sum += grid[x][y+1].a * 0.2;
  sum += grid[x][y-1].a * 0.2;
  sum += grid[x-1][y-1].a * 0.05;
  sum += grid[x-1][y+1].a * 0.05;
  sum += grid[x+1][y-1].a * 0.05;
  sum += grid[x+1][y+1].a * 0.05;
  return sum;
}

float laplaceB(int x, int y){
  float sum = 0.0;
  sum += grid[x][y].b * -1;
  sum += grid[x-1][y].b * 0.2;
  sum += grid[x+1][y].b * 0.2;
  sum += grid[x][y+1].b * 0.2;
  sum += grid[x][y-1].b * 0.2;
  sum += grid[x-1][y-1].b * 0.05;
  sum += grid[x-1][y+1].b * 0.05;
  sum += grid[x+1][y-1].b * 0.05;
  sum += grid[x+1][y+1].b * 0.05;
  return sum;
}
