



GPointsArray genPlotData(){
  println("Multi window");
  int nPoints = 100;
  GPointsArray points = new GPointsArray(nPoints);
  
  for (int i = 0; i < nPoints; i++) {
    points.add(i, 10*noise(0.1*i));
  }
  return points;
}

public void plot() {
  println("def plot");
  //GPointsArray data = genPlotData();
  //win = new PWindow(int(cp5.get(Textfield.class, "CELL_X").getText()), int(cp5.get(Textfield.class, "CELL_X").getText()), mainLeftMargin, data);
  //plotNewWindow(Forward_Euler());
}

public void plotNewWindow(GPointsArray data) {
  println("plot");
  win = new PWindow(int(cp5.get(Textfield.class, "CELL_X").getText()), int(cp5.get(Textfield.class, "CELL_X").getText()), mainLeftMargin, data);
}

public void plotNewWindow(HashMap<String, GPointsArray> data) {
  println("plot");
  win = new PWindow(0, 0, mainLeftMargin, data);
}
