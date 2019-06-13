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
float T_start = 0.0, T_end = 50.0;
float dt = 0.25;
float a_init = 50.0, b_init = 100.0;
float simTime = 0;
int simSteps = 0;

int nPoints = int((T_end+dt)/dt);

// Array of cells
Cell[][] prev;

// Buffer to record the state of the cells and use this while changing the others in the interations
Cell[][] grid;

float[][][] simData_A = new float[nPoints][0][0];
float[][][] simData_B = new float[nPoints][0][0];

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
      
      simData_A[simSteps][i][j] = newspot.a;
      simData_B[simSteps][i][j] = newspot.b;
      
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

HashMap<String, GPointsArray> Gillespie(){
  println("RD class - Gillespie");
  GPointsArray Ut = new GPointsArray(nPoints);
  GPointsArray Vt = new GPointsArray(nPoints);


  Ut.add(0, a_init);
  Vt.add(0, b_init);

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

void saveToFile(float[] A, float[]B){
  JSONArray arrayA = new JSONArray();
  JSONArray arrayB = new JSONArray();
  JSONObject simData = new JSONObject();
  for(int i=0; i<A.length; i++){
     arrayA.setFloat(i, A[i]);
     arrayB.setFloat(i, B[i]);
  }
  simData.setJSONArray("A", arrayA);
  simData.setJSONArray("B", arrayB);
  saveJSONObject(simData, "data/data_0.json"); 
}

HashMap<String, GPointsArray> getSimData(int pcy, int pcx){
  println("RD class - getSimData - Gillespie");
  GPointsArray Ut = new GPointsArray(nPoints);
  GPointsArray Vt = new GPointsArray(nPoints);
  float[] A = new float[nPoints];
  float[] B = new float[nPoints];
  
  for(int t = 0; t<nPoints; t++){
    Ut.add(t, simData_A[t][pcx][pcy]);
    Vt.add(t, simData_B[t][pcx][pcy]);
    A[t] = simData_A[t][pcx][pcy];
    B[t] = simData_B[t][pcx][pcy];
    
  }
  saveToFile(A, B);
  HashMap<String, GPointsArray> hm = new HashMap<String, GPointsArray>();

  // Putting key-value pairs in the HashMap
  hm.put("Ut", Ut);
  hm.put("Vt", Vt);

  return hm;
}

//void update() {
//  for (int i = 1; i < cols-1; i++) {
//    for (int j = 1; j < rows-1; j ++) {
//      float a = prev[i][j].a;
//      float b = prev[i][j].b;

//      Cell newspot = grid[i][j]; //new values of the pixel
//      newspot.a = a + (dA*laplaceA(i,j) - a*b*b + feed*(1-a))*dt;
//      newspot.b = b + (dB*laplaceB(i,j) + a*b*b - (k+feed)*b)*dt;

//      newspot.a = constrain(newspot.a, 0, 1);
//      newspot.b = constrain(newspot.b, 0, 1);
//    }
//  }
//}
