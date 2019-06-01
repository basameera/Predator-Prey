float[] A = {0.2, 0.3, 0.6};
int[] INT = {1, 4, 7};
char[] CH = {'a', 'b', 'c'};
String[] STR = {"abc", "def", "ghi"};

void setup(){
  size(200, 200);
  
  // int array
  println(randomChoice(INT, A));

  // other arrays
  println(randomChoice(CH, A));
  println(randomChoice(STR, A));
}
