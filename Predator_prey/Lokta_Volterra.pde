// Definition of parameters
float a = 1.0;
float b = 0.1;
float c = 1.5;
float d = 0.075;
float T_start = 0.0, T_end = 20.0;
float dt = 0.01;

float getU(float ut, float vt){
    return ut + (a*ut - b*ut*vt)*dt;
}
float getV(float ut, float vt){
    return vt + (-c*vt + d*ut*vt)*dt;
}

HashMap<String, GPointsArray> Lokta_Volterra(){
  println("Lokta");
  int nPoints = int((T_end+dt)/dt);
  GPointsArray Ut = new GPointsArray(nPoints);
  GPointsArray Vt = new GPointsArray(nPoints);
  
  float U_init = 10.0, V_init = 10.0;
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
