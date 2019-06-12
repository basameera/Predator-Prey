/*
* Reaction Diffusion Data
*/

//parameters
float dA = 4;
float dB = 4;
// euler
//float ap = 1.0;
//float bp = 0.1;
//float cp = 1.5;
//float dp = 0.075;
//float dt = 0.01;
//float T_start = 0.0, T_end = 200.0;
//float a_init = 10.0, b_init = 10.0;
// Use these for gillespie
float ap = 1.0;
float bp = 0.005;
float cp = 0.6;
float dp = 0.005;
float T_start = 0.0, T_end = 200.0;
float dt = 0.25;
float a_init = 50.0, b_init = 100.0;

// Starting values


int nPoints = int((T_end+dt)/dt);

GPointsArray Ut = new GPointsArray(nPoints);
GPointsArray Vt = new GPointsArray(nPoints);

int timestamp = 1;
// Array of cells
Cell[][] prev;

// Buffer to record the state of the cells and use this while changing the others in the interations
Cell[][] grid;

class tuple
{
  float fst,snd;
  tuple(float _fst, float _snd)
  {
    fst=_fst;
    snd=_snd;
  }
}

tuple iterate(float u, float v){
  float cU = u;
  float cV = v;
  while (cU > 0 && cV > 0){
    float pyorpd = random(0, cU + cV);
    if (pyorpd < cU) {
      cU -= 1;
      if (random(0,1) < dt*ap){
        u += 1;
      }
      if (u > 0) {
        float p = min(dt*bp*v,1);
        if (random(0,1) < p) {
          u -= 1;
        }
      }
    }
    else {
      cV -= 1;
      if (random(0,1) < dt*cp){
        v -= 1;
      }
      float p = min(dt*dp*u,1);
      if (random(0,1) < p){
        v += 1;
      }
    }
  }
  return new tuple(u,v);
}


void update() {
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j ++) {
      float a = prev[i][j].a;
      float b = prev[i][j].b;

      Cell newspot = grid[i][j]; //new values of the pixel
      //newspot.a = a + (dA*laplaceA(i,j) - bp*a*b + ap*a)*dt;
      //newspot.b = b + (dB*laplaceB(i,j) + dp*a*b - cp*b)*dt;
      tuple nv = iterate(a,b);
      
      newspot.a = nv.fst + dA*laplaceA(i,j)*dt;
      newspot.b = nv.snd + dB*laplaceB(i,j)*dt;

      newspot.a = constrain(newspot.a, 0, 2000);
      newspot.b = constrain(newspot.b, 0, 2000);
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
