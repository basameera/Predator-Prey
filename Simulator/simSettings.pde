Textfield lblStatus;
Textfield tf_prey;
Textfield tf_predator;
Textfield tf_simTime;
Textfield tf_cell_x;
Textfield tf_cell_y;
Slider progressBar;
int progressValue = 0;


void simSettingsSetup(){
  int fontSize = 15;
  int pos_gap = fontSize*4;
  int tf_width = 100;
  int btn_width = 60;
  PFont font = createFont("arial",fontSize);
  cp5 = new ControlP5(this);
  progressBar = new Slider(cp5, "");
  
  //header
  tf_prey = cp5.addTextfield("init_prey")
     .setPosition(height+20, 20)
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
     
  tf_predator = cp5.addTextfield("init_predator")
     .setPosition(height+20 + tf_width + 20, 20)
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;

   tf_simTime = cp5.addTextfield("Simulation_Time")
     .setPosition(height+20, 20+pos_gap)
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
     
   tf_cell_y = cp5.addTextfield("CELL_Y")
     .setPosition(height+20, 20+(pos_gap*2))
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
     
   tf_cell_x = cp5.addTextfield("CELL_X")
     .setPosition(height+20 + tf_width + 20, 20+(pos_gap*2))
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;

  tf_cell_y.setText("63");
  tf_cell_x.setText("35");
  

  lblStatus = cp5.addTextfield("status")
     .setPosition(height+20, 20+(pos_gap*4))
     .setSize(tf_width*2, fontSize*2)
     .setFont(createFont("arial", 20))
     .setAutoClear(true)
     .setFocus(false)
     ;
  
  lblStatus.setText("Ready");
  
  cp5.addTextlabel("pred")
    .setText("Predators")
    .setPosition(height+20, 20+(pos_gap*6))
    .setColorValue(0xffff0000)
    .setFont(createFont("arial", 20))
    ;
  cp5.addTextlabel("prey")
    .setText("Preys")
    .setPosition(height+20+100,20+(pos_gap*6))
    .setColorValue(0xff00ff00)
    .setFont(createFont("arial", 20))
    ;
  
  progressBar.setPosition(height+20, 20+(pos_gap*7))
   .setRange(0, 100)
   .setSize(250,30)
   .setFont(createFont("arial", 20))
   ;
  
  //footer
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
  tf_prey.setText(str(int(a_init)));
  tf_predator.setText(str(int(b_init)));
  tf_simTime.setText(str(int(T_end))); 
}

void readSimSettings(){
  T_end = float(tf_simTime.getText());
  a_init = float(tf_prey.getText());
  b_init = float(tf_predator.getText());
  nPoints = int((T_end+dt)/dt);
  println("\nsim time:", T_end);
  println("Prey:", a_init);
  println("Predator:", b_init);
  println("Sim Steps:", nPoints);
  println();
}

public void reset() {
  println("simSettings - reset");
  lblStatus.setText("Ready");
  lblStatus.setColorValue(0xff00ff00);
  readSimSettings();
  simTime = 0;
  simSteps = 0;
  progressBar.setValue(0);
  initDraw();
}

public void run() {
  readSimSettings();
  pause = !pause;
  simData_A = new float[nPoints][cols][rows];
  simData_B = new float[nPoints][cols][rows];
  if(pause){
    println("simSettings - pause");
    lblStatus.setText("Paused");
    lblStatus.setColorValue(0xff00ff00);
  }
  else{
    println("simSettings - run");
    lblStatus.setText("Running");
    lblStatus.setColorValue(0xffff0000);
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
  int pcx = int(tf_cell_x.getText());
  int pcy = int(tf_cell_y.getText());
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
