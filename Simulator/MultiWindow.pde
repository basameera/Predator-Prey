
class PWindow extends PApplet {
  int leftMargin = 0;
  String plotName = "";
  GPointsArray abc;
  HashMap<String, GPointsArray> def;
  boolean hashData = false;
  
  void settings() {
    size(plotWindowW, plotWindowW*3/4);
  }
  
  PWindow(int leftMarg, GPointsArray pData, String plotName_) {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
    leftMargin = leftMarg;
    abc = pData;
    plotName = plotName_;
  }
  
  PWindow(int leftMarg, HashMap<String, GPointsArray> pData, String plotName_) {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
    leftMargin = leftMarg;
    def = pData;
    hashData = true;
    plotName = plotName_;
  }

  void setup() {
    surface.setLocation(leftMargin + 1000 + midGap, (displayHeight-height)/2);
    background(255);
    
    //drawPlot(genPlotData());
    if(hashData){
      drawPlot(def);
    }
    else {
      drawPlot(abc);
    }
    
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
    println("Plot window - drawPlot");
    
    // Create a new plot and set its position on the screen
    GPlot plot = new GPlot(this);
    plot.setPos(0, 0);
    plot.setDim(width-100, height-100);
    
    // Set the plot title and the axis labels
    plot.setTitleText("A very simple example");
    plot.getXAxis().setAxisLabelText("Simulation Time Steps (per 0.25 sec)");
    plot.getYAxis().setAxisLabelText("Animal Population");
    
    // Add the points
    plot.setPoints(points);
    plot.setLineColor(color(255, 0, 0));
    
    plot.addLayer("Layer2", genPlotData());
    plot.getLayer("Layer2").setLineColor(color(0, 0, 255));
    // Draw it!
    
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
  
  void drawPlot(HashMap<String, GPointsArray> hashPoints){
    // Prepare the points for the plot
    println("Plot window - drawPlot - Hash Points");
    
    // Create a new plot and set its position on the screen
    GPlot plot = new GPlot(this);
    plot.setPos(0, 0);
    plot.setDim(width-100, height-100);
    
    // Set the plot title and the axis labels
    plot.setTitleText("Reaction-Difussion with Gillespie at "+plotName);
    plot.getXAxis().setAxisLabelText("Simulation Time Steps (per 0.25 sec)");
    plot.getYAxis().setAxisLabelText("Animal Population");
    
    // Add the points
    plot.setPoints(hashPoints.get("Ut"));
    plot.setLineColor(color(0, 0, 255));
    
    plot.addLayer("Fox", hashPoints.get("Vt"));
    plot.getLayer("Fox").setLineColor(color(255, 0, 0));
    
    plot.beginDraw();
    plot.drawBox();
    plot.drawXAxis();
    plot.drawYAxis();
    plot.drawTitle();
    plot.drawLines();
    plot.drawGridLines(GPlot.VERTICAL);
    plot.drawLegend(new String[] {"Rabbit", "Fox"}, 
                    new float[] {0.1, 0.5}, 
                    new float[] {0.95, 0.95});
    plot.drawLabels();
    plot.endDraw();
  }
}
