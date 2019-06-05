// Definition of parameters
// Use these for gillespie
float a = 1.0;
float b = 0.005;
float c = 0.6;
float d = 0.005;
float T_start = 0.0, T_end = 20.0;
float dt = 0.25;
float U_init = 50.0, V_init = 100.0;

// Use these for forward-euler
//float a = 1.0;
//float b = 0.1;
//float c = 1.5;
//float d = 0.075;
//float T_start = 0.0, T_end = 20.0;
//float dt = 0.01;
//float U_init = 10.0, V_init = 10.0;

class tuple
{
  float fst,snd;
  tuple(float _fst, float _snd)
  {
    fst=_fst;
    snd=_snd;
  }
}

float getU(float ut, float vt){
    return ut + (a*ut - b*ut*vt)*dt;
}
float getV(float ut, float vt){
    return vt + (-c*vt + d*ut*vt)*dt;
}

HashMap<String, GPointsArray> Forward_Euler(){
  println("Lokta");
  int nPoints = int((T_end+dt)/dt);
  GPointsArray Ut = new GPointsArray(nPoints);
  GPointsArray Vt = new GPointsArray(nPoints);

  Ut.add(0, U_init);
  Vt.add(0, V_init);

  for(int t=1; t<nPoints; t++){
    Ut.add(t, getU(Ut.getY(t-1), Vt.getY(t-1)));
    Vt.add(t, getV(Ut.getY(t-1), Vt.getY(t-1)));
  }

  HashMap<String, GPointsArray> hm = new HashMap<String, GPointsArray>();

  // Putting key-value pairs in the HashMap
  hm.put("Ut", Ut);
  hm.put("Vt", Vt);

  return hm;
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
  println("Lokta");
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
