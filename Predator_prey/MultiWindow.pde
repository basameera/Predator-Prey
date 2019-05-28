
class PWindow extends PApplet {
  int leftMargin = 0;
  GPointsArray abc;
  
  void settings() {
    size(plotWindowW, plotWindowW*3/4);
  }
  
  PWindow(int cx, int cy, int leftMarg, GPointsArray pData) {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
    //println(cx, cy);
    leftMargin = leftMarg;
    abc = pData;
  }

  void setup() {
    surface.setLocation(leftMargin + 1000 + midGap, (displayHeight-height)/2);
    background(255);
    
    //drawPlot(genPlotData());
    drawPlot(abc);
  }
  
  GPointsArray genPlotData(){
    println("Multi window");
    int nPoints = 100;
    GPointsArray points = new GPointsArray(nPoints);
    
    for (int i = 0; i < nPoints; i++) {
      points.add(i, 10*noise(0.1*i));
    }
    return points;
  }
  
  GPointsArray Lokta_Volterra(){
    int nPoints = 100;
    GPointsArray points = new GPointsArray(nPoints);
    
    for (int i = 0; i < nPoints; i++) {
      points.add(i, 10*noise(0.1*i));
    }
    return points;
  }

  void draw() {
    //ellipse(random(width), random(height), random(50), random(50));
  }

  void mousePressed() {
    println("mousePressed in secondary window");
  }
  
  void exit()
  {
    dispose();
    win = null;
  }
  
  void drawPlot(GPointsArray points){
    // Prepare the points for the plot
    println("drawPlot");
    //println(points.getNPoints());
    // Create a new plot and set its position on the screen
    GPlot plot = new GPlot(this);
    plot.setPos(0, 0);
    plot.setDim(width-100, height-100);
    // or all in one go
    // GPlot plot = new GPlot(this, 25, 25);
    
    // Set the plot title and the axis labels
    plot.setTitleText("A very simple example");
    plot.getXAxis().setAxisLabelText("x axis");
    plot.getYAxis().setAxisLabelText("y axis");
    
    // Add the points
    plot.setPoints(points);
    plot.setLineColor(color(255, 0, 0));
    
    //plot.addLayer("Layer1", points);
    //plot.getLayer("Layer1").setLineColor(color(255, 0, 0));
    
    plot.addLayer("Layer2", genPlotData());
    plot.getLayer("Layer2").setLineColor(color(0, 0, 255));
    // Draw it!
    //plot.defaultDraw(); 
    
    plot.beginDraw();
    plot.drawBox();
    plot.drawXAxis();
    plot.drawYAxis();
    plot.drawTitle();
    plot.drawLines();
    plot.drawGridLines(GPlot.VERTICAL);
    plot.drawLegend(new String[] {"Layer1", "Layer2"}, 
                    new float[] {0.1, 0.5}, 
                    new float[] {0.95, 0.95});
    plot.drawLabels();
    plot.endDraw();
  }
}
