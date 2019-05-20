void settingsSetup(){
  PFont font = createFont("arial",20);
  cp5 = new ControlP5(this);
        
  cp5.addTextfield("Initial_Prey")
     .setPosition(720, 20)
     .setSize(200,40)
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     ;

   cp5.addTextfield("Simulation_Time")
     .setPosition(720, 100)
     .setSize(200,40)
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     ;
       
  cp5.addBang("save")
     .setPosition(720, 640)
     .setSize(80,40)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  cp5.addBang("run")
     .setPosition(820, 640)
     .setSize(80,40)
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
