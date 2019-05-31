var grid;
var next;

var dA = 1;
var dB = 0.5;
var feed = 0.055;
var k = 0.062;

function setup() {
  createCanvas(200, 200);
  pixelDensity(1);
  grid = [];
  next = [];
  for (var x = 0; x < width; x++) {
    grid[x] = [];
    next[x] = [];
    for (var y = 0; x < height; y++) {
      grid[x][y] = {a:1, b:0}
      next[x][y] = {a:1, b:0}
    }
  }
  
  // pour chemical B to chemical A
  for (var i = 100; i < 110; i++) {
    for (var j = 100; j < 110; j++) {
      grid[i][j].b = 1;
    }
  }
  
}

function draw() {
  background(51);
  
  for(var x=1; x<width-1; x++){
    for(var y=1; y<height-1; y++){
      var a = grid[x][y].a;
      var b = grid[x][y].b;
      next[x][y].a =  a +
                      (dA*laplaceA(x,y)) -
                      (a*b*b) +
                      (feed*(1-a));
      next[x][y].b =  b +
                      (dB*laplaceB(x,y)) -
                      (a*b*b) +
                      ((k+feed)*b);
      
      next[x][y].a = constrain(next[x][y].a, 0, 1)
      next[x][y].b = constrain(next[x][y].b, 0, 1)
    }
  }
  
  
  loadPixels();
}





















function laplaceA(x,y){
  var sum=0;
  sum += grid[x][y].a * -1;
  sum += grid[x-1][y].a * 0.2;
  sum += grid[x+1][y].a * 0.2;
  sum += grid[x][y+1].a * 0.2;
  sum += grid[x][y-1].a * 0.2;
  sum += grid[x-1][y-1].a * 0.05;
  sum += grid[x-1][y+1].a * 0.05;
  sum += grid[x+1][y-1].a * 0.05;
  sum += grid[x+1][y+1].a * 0.05;
  return sum;
}

function laplaceB(x,y){
  var sum=0;
  sum += grid[x][y].b * -1;
  sum += grid[x-1][y].b * 0.2;
  sum += grid[x+1][y].b * 0.2;
  sum += grid[x][y+1].b * 0.2;
  sum += grid[x][y-1].b * 0.2;
  sum += grid[x-1][y-1].b * 0.05;
  sum += grid[x-1][y+1].b * 0.05;
  sum += grid[x+1][y-1].b * 0.05;
  sum += grid[x+1][y+1].b * 0.05;
  return sum;
}