void settingsSetup(){
  int fontSize = 15;
  int pos_gap = fontSize*4;
  int tf_width = 100;
  int btn_width = 60;
  PFont font = createFont("arial",fontSize);
  cp5 = new ControlP5(this);
        
  cp5.addTextfield("Initial_Prey")
     .setPosition(720, 20)
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;

   cp5.addTextfield("Simulation_Time")
     .setPosition(720, 20+pos_gap)
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
     
   cp5.addTextfield("CELL_Y")
     .setPosition(720, 20+(pos_gap*2))
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
     
   cp5.addTextfield("CELL_X")
     .setPosition(720 + tf_width + 20, 20+(pos_gap*2))
     .setSize(tf_width, fontSize*2)
     .setFont(createFont("arial",fontSize))
     .setAutoClear(false)
     ;
       
  cp5.addBang("save")
     .setPosition(720, 640)
     .setSize(btn_width, fontSize*2)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  cp5.addBang("run")
     .setPosition(720+(1*(btn_width+10)), 640)
     .setSize(btn_width, fontSize*2)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;   
     
  cp5.addBang("plot")
     .setPosition(720+(2*(btn_width+10)), 640)
     .setSize(btn_width, fontSize*2)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ; 
     
  textFont(font);
  cp5.get(Textfield.class, "Initial_Prey").setText("10");
  cp5.get(Textfield.class, "Simulation_Time").setText("10"); 
}

public void save() {
  prob_prey = float(cp5.get(Textfield.class, "Initial_Prey").getText());
  prey_count = 0;
  predator_count = 0;
  init_pp(cells_x, cells_y);
  drawGrid();
}

public void run() {
  pause = !pause;
  if(pause){
    println("pause");
  }
  else{
    println("run");
  }
}

GPointsArray genPlotData(){
  println("settings");
    int nPoints = 100;
    GPointsArray points = new GPointsArray(nPoints);
    
    for (int i = 0; i < nPoints; i++) {
      points.add(i, 10*noise(0.1*i));
    }
    return points;
}

public void plot() {
  //println("plot");
  win = new PWindow(int(cp5.get(Textfield.class, "CELL_X").getText()), int(cp5.get(Textfield.class, "CELL_X").getText()), mainLeftMargin, genPlotData());
}

public void plot(GPointsArray data) {
  //println("plot");
  win = new PWindow(int(cp5.get(Textfield.class, "CELL_X").getText()), int(cp5.get(Textfield.class, "CELL_X").getText()), mainLeftMargin, data);
}
