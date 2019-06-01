import javax.swing.JOptionPane;

void errorMsg(String msg){
  JOptionPane.showMessageDialog(null, msg, "Error Message", JOptionPane.ERROR_MESSAGE);
}

//helper
int[] indexer(char[] input){
  int[] output = new int[input.length];
  for(int x=0; x<input.length; x++){
    output[x] = x; 
  }
  return output;
}

int[] indexer(String[] input){
  int[] output = new int[input.length];
  for(int x=0; x<input.length; x++){
    output[x] = x; 
  }
  return output;
}

int randomChoice(int[] input, float[] prob){
  if(input.length!=prob.length){
    errorMsg("Both input arrays should have the same length.");
  }
  
  float sum=0;
  float runningSum = 0;
  int rOption = input.length+1;
  float[] P = prob;
  
  for(int i=0; i<P.length; i++){
    sum += P[i];
  }
  
  //normalize
  if(sum!=1.0){
    for(int i=0; i<P.length; i++){
      P[i] /= sum;
    }
  }
  
  float rSample = random(1);
  if(rSample==0.000000000000){
    rSample += 0.000000001;
  }
  for(int i=0; i<P.length; i++){
    float low=0, high=0;
    if(i==0){
      low = 0;
    } else {
      low = P[i-1];
    }
    runningSum += low;
    high = runningSum + P[i];
    //compare
    if(rSample>runningSum && rSample<=high){
      rOption = input[i];
      break;
    }
  }
  return rOption;
}

char randomChoice(char[] input, float[] prob){
  if(input.length!=prob.length){
    errorMsg("Both input arrays should have the same length.");
  }
  
  float sum=0;
  float runningSum = 0;
  char rOption = ' ';
  float[] P = prob;
  
  for(int i=0; i<P.length; i++){
    sum += P[i];
  }
  
  //normalize
  if(sum!=1.0){
    for(int i=0; i<P.length; i++){
      P[i] /= sum;
    }
  }
  
  float rSample = random(1);
  if(rSample==0.000000000000){
    rSample += 0.000000001;
  }
  for(int i=0; i<P.length; i++){
    float low=0, high=0;
    if(i==0){
      low = 0;
    } else {
      low = P[i-1];
    }
    runningSum += low;
    high = runningSum + P[i];
    //compare
    if(rSample>runningSum && rSample<=high){
      rOption = input[i];
      break;
    }
  }
  return rOption;
}

String randomChoice(String[] input, float[] prob){
  if(input.length!=prob.length){
    errorMsg("Both input arrays should have the same length.");
  }
  
  float sum=0;
  float runningSum = 0;
  String rOption = " ";
  float[] P = prob;
  
  for(int i=0; i<P.length; i++){
    sum += P[i];
  }
  
  //normalize
  if(sum!=1.0){
    for(int i=0; i<P.length; i++){
      P[i] /= sum;
    }
  }
  
  float rSample = random(1);
  if(rSample==0.000000000000){
    rSample += 0.000000001;
  }
  for(int i=0; i<P.length; i++){
    float low=0, high=0;
    if(i==0){
      low = 0;
    } else {
      low = P[i-1];
    }
    runningSum += low;
    high = runningSum + P[i];
    //compare
    if(rSample>runningSum && rSample<=high){
      rOption = input[i];
      break;
    }
  }
  return rOption;
}
