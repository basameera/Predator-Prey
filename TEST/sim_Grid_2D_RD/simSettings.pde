void simSettingsSetup(){
  int fontSize = 15;
  int pos_gap = fontSize*4;
  int tf_width = 100;
  int btn_width = 60;
  PFont font = createFont("arial",fontSize);
  cp5 = new ControlP5(this);
        
  cp5.addTextfield("init_prey")
     .setPosition(height+20, 20)
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
     
  cp5.addTextfield("init_predator")
     .setPosition(height+20 + tf_width + 20, 20)
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;

   cp5.addTextfield("Simulation_Time")
     .setPosition(height+20, 20+pos_gap)
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
     
   cp5.addTextfield("CELL_Y")
     .setPosition(height+20, 20+(pos_gap*2))
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
     
   cp5.addTextfield("CELL_X")
     .setPosition(height+20 + tf_width + 20, 20+(pos_gap*2))
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
       
  cp5.addBang("reset")
     .setPosition(height+20, 640)
     .setSize(btn_width, fontSize*2)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  cp5.addBang("run")
     .setPosition(height+20+(1*(btn_width+10)), 640)
     .setSize(btn_width, fontSize*2)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;   
     
  cp5.addBang("plot")
     .setPosition(height+20+(2*(btn_width+10)), 640)
     .setSize(btn_width, fontSize*2)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ; 
     
  textFont(font);
  cp5.get(Textfield.class, "init_prey").setText(str(int(a_init)));
  cp5.get(Textfield.class, "init_predator").setText(str(int(b_init)));
  cp5.get(Textfield.class, "Simulation_Time").setText(str(int(T_end))); 
}

void readSimSettings(){
  T_end = float(cp5.get(Textfield.class, "Simulation_Time").getText());
  a_init = float(cp5.get(Textfield.class, "init_prey").getText());
  b_init = float(cp5.get(Textfield.class, "init_predator").getText());
  
  println("sim time:", T_end);
  println("Prey:", a_init);
  println("Predator:", b_init);
}

public void reset() {
  println("simSettings - reset");
  readSimSettings();
  simTime = 0;
  initDraw();
}

public void run() {
  readSimSettings();
  pause = !pause;
  simData_A = new float[nPoints][cols][rows];
  simData_B = new float[nPoints][cols][rows];
  if(pause){
    println("simSettings - pause");
  }
  else{
    println("simSettings - run");
  }
}

GPointsArray genPlotData(){
  println("simSettings - genPlotData");
  int nPoints = 100;
  GPointsArray points = new GPointsArray(nPoints);
  
  for (int i = 0; i < nPoints; i++) {
    points.add(i, 10*noise(0.1*i));
  }
  return points;
}

public void plot() {
  println("simSettings - plot");
  int pcx = int(cp5.get(Textfield.class, "CELL_X").getText());
  int pcy = int(cp5.get(Textfield.class, "CELL_Y").getText());
  println(pcy, pcx);
  
  plotNewWindow(getSimData(pcy, pcx), String.format("Cell (%d, %d)", pcy, pcx));
}

public void plotNewWindow(GPointsArray data, String plotName) {
  println("simSettings - plotNewWindow - GPointsArray");
  win = new PWindow(mainLeftMargin, data, plotName);
}

public void plotNewWindow(HashMap<String, GPointsArray> data, String plotName) {
  println("simSettings - plotNewWindow - HashMap");
  win = new PWindow(mainLeftMargin, data, plotName);
}
