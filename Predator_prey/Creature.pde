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
  
  int[] moveLeft(){
    int[] output = new int[4];
    output[0] = pos_x;
    output[1] = pos_y;
    
    if (pos_x<(window_W-1)){
      next_x = pos_x + 1;
    }
    if (pos_y<(window_H-1)){
      next_y = pos_y;
    }
    
    pos_x = next_x;
    pos_y = next_y;
    
    output[2] = pos_x;
    output[3] = pos_y;
    
    return output;
  }
  
  int[] moveDown(){
    int[] output = new int[4];
    output[0] = pos_x;
    output[1] = pos_y;
    
    if (pos_x<(window_W-1)){
      next_x = pos_x;
    }
    if (pos_y<(window_H-1)){
      next_y = pos_y + 1;
    }
    
    pos_x = next_x;
    pos_y = next_y;
    
    output[2] = pos_x;
    output[3] = pos_y;
    
    return output;
  }
} 
