/*
* Reaction Diffusion Data
*/

//parameters
float dA = 1.0;
float dB = 0.5;
//float dt = 1.0;
//"coral growth" simulation (f=.0545, k=.062).
float feed = 0.055;
float k = 0.062;

float a = 1.0;
float b = 0.005;
float c = 0.6;
float d = 0.005;
float T_start = 0.0, T_end = 100.0;
float dt = 0.25;
float U_init = 50.0, V_init = 100.0;
float simTime = 0;
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
      if (random(0,1) < dt*a){
        u += 1;
      }
      if (u > 0) {
        float p = min(dt*b*v,1);
        if (random(0,1) < p) {
          u -= 1;
        }
      }
    }
    else {
      cV -= 1;
      if (random(0,1) < dt*c){
        v -= 1;
      }
      float p = min(dt*d*u,1);
      if (random(0,1) < p){
        v += 1;
      }
    }
  }
  return new tuple(u,v);
}

HashMap<String, GPointsArray> Gillespie(){
  println("RD class - Gillespie");
  int nPoints = int((T_end+dt)/dt);
  GPointsArray Ut = new GPointsArray(nPoints);
  GPointsArray Vt = new GPointsArray(nPoints);


  Ut.add(0, U_init);
  Vt.add(0, V_init);

  for(int t=1; t<nPoints; t++){
    tuple uv = iterate(Ut.getY(t-1),Vt.getY(t-1));
    Ut.add(t, uv.fst);
    Vt.add(t, uv.snd);
  }

  HashMap<String, GPointsArray> hm = new HashMap<String, GPointsArray>();

  // Putting key-value pairs in the HashMap
  hm.put("Ut", Ut);
  hm.put("Vt", Vt);

  return hm;
}
