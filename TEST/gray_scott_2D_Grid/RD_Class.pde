/*
* Reaction Diffusion Data
*/

float dA = 1.0;
float dB = 0.5;
float feed = 0.055;
float k = 0.062;

// Array of cells
//int[][] grid; 
Cell[][] grid;

// Buffer to record the state of the cells and use this while changing the others in the interations
//int[][] next;
Cell[][] next;
