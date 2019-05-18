//https://processing.org/examples/arrayobjects.html
class Animal { 
  int health, type; 
  int pos_x, pos_y;
  int next_x, next_y;
  int window_H, window_W;
  
  
  //Constructor
  Animal (int t, int x, int y, int w, int h) {  
    health = 100; 
    type = t;
    pos_x = x;
    pos_y = y;
    window_H = h;
    window_W = w;
  }
  
  int[] move(){
    next_x = pos_x + 1;
    next_y = pos_x;
    
    if (next_x>window_W)  next_x = window_W;
    if (next_y>window_H)  next_y = window_H;
    
    pos_x = next_x;
    pos_y = next_y;
    int[] output = new int[2];
    output[0] = pos_x;
    output[1] = pos_y;
    
    return output;
  }
} 
