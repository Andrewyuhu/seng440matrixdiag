#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type
#define SIZE 4
#define PI 3.141592654
#define TOLERANCE 0.0001

// Function Definitions
void getSubMatrix(int matrix[SIZE][SIZE], int leftMatrix[SIZE][SIZE], int rightMatrix[SIZE][SIZE], int start, int end);
void printMatrixArray(int size, int matrix[size][size]);
void transposeMatrix(int size, int matrix[size][size], int transposed[size][size]);
void copyMatrix(int size, int source[size][size], int destination[size][size]);
int to_fixed_point_angle(float value);
float reverse_fixed_point_angles(int value);
bool checkOffDiagonalZeros(int size, int matrix[size][size]);

// Converts floating to fixed point
int to_fixed_point_angle(float value)
{
  return (int)(value * 16384); // 16384 = 2 ^ 14 S.F
}

float reverse_fixed_point_angles(int value)
{
  return (float)value / 16384.0; // 16384 = 2 ^ 14 S.F
};

// Check if final result is correct
bool checkOffDiagonalZeros(int size, int matrix[size][size])
{
  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      // Comparing with 0 is an optimization
      if (i != j && abs(matrix[i][j]) != 0)
      {
        return false;
      }
    }
  }
  return true;
}

// TODO : Ideally this can be removed!
// Takes a matrix and transposes it
void transposeMatrix(int size, int matrix[size][size], int transposed[size][size])
{
  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      transposed[j][i] = matrix[i][j];
    }
  }
}

// TODO : Ideally this can be removed
// Copies a matrix from one var to another
void copyMatrix(int size, int source[size][size], int destination[size][size])
{
  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      destination[i][j] = source[i][j];
    }
  }
}

// TODO : Technically overhead
// Prints a matrix in an easy to read format
void printMatrixArray(int size, int matrix[size][size])
{
  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      printf("%d ", matrix[i][j]);
    }
    printf("\n");
  }
}

void convert_4by4_array(int array[4][4], int result[4][4])
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = reverse_fixed_point_angles(array[i][j]);
    }
  }
}

// TODO : Look for ways to opitmize this
// Takes in a int size, multiplies mat1 and mat2 and stores result in result
void multiplyMatrices(int size, int mat1[size][size],
                      int mat2[size][size],
                      int result[size][size])
{

  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      result[i][j] = 0;
    }
  }

  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      for (int k = 0; k < size; k++)
      {
        result[i][j] += mat1[i][k] * mat2[k][j];
      }
    }
  }
}

void getSubMatrix(int matrix[SIZE][SIZE], int leftMatrix[SIZE][SIZE], int rightMatrix[SIZE][SIZE], int start, int end)
{

  // Allocate memory for the submatrix
  int sweepMatrix[2][2];
  sweepMatrix[0][0] = matrix[start][start];
  sweepMatrix[0][1] = matrix[start][end];
  sweepMatrix[1][0] = matrix[end][start];
  sweepMatrix[1][1] = matrix[end][end];

  // Define variables for calculating needed rotation angles
  float angleR;
  float angleL;
  float angleSum;
  float angleDiff;

  // It is probably not actually good to convert these to fixed point because
  // angle functions require floats or doubles!
  angleSum = atan((float)((sweepMatrix[1][0] + sweepMatrix[0][1]) / (sweepMatrix[1][1] - sweepMatrix[0][0])));
  angleDiff = atan((float)((sweepMatrix[1][0] - sweepMatrix[0][1]) / (sweepMatrix[1][1] + sweepMatrix[0][0])));
  angleL = (angleSum - angleDiff) / 2.0;
  angleR = (angleSum - angleL);

  // S.F for cos / sin operations is 2^14 for 16 bit integers
  // Conversions from here can be fixed point
  int cosRotationR = to_fixed_point_angle(cosf(angleR));
  int sinRotationR = to_fixed_point_angle(sinf(angleR));
  int cosRotationL = to_fixed_point_angle(cosf(angleL));
  int sinRotationL = to_fixed_point_angle(sinf(angleL));

  // TODO : Values below here should all just be integers
  int resultMatrix[2][2];

  // Initilization of left Rotation Matrix
  int rotateMatrix[2][2] = {
      {cosRotationL, -sinRotationL},
      {sinRotationL, cosRotationL}};

  multiplyMatrices(2, rotateMatrix, sweepMatrix, resultMatrix);

  // Redfine rotate matrix for RIGHT rotation
  rotateMatrix[0][0] = cosRotationR;
  rotateMatrix[0][1] = sinRotationR;
  rotateMatrix[1][0] = -sinRotationR;
  rotateMatrix[1][1] = cosRotationR;
  multiplyMatrices(2, resultMatrix, rotateMatrix, sweepMatrix);

  // This section deals with applying the smaller rotations to main matrices
  // leftMatrix is U, rightMatrix is V

  // Creating needed Matrices
  int Us[4][4] = {
      {1, 0, 0, 0},
      {0, 1, 0, 0},
      {0, 0, 1, 0},
      {0, 0, 0, 1}};
  int Vs[4][4] = {
      {1, 0, 0, 0},
      {0, 1, 0, 0},
      {0, 0, 1, 0},
      {0, 0, 0, 1}};

  int UTs[4][4];
  int VTs[4][4];
  int VT[4][4];

  // Add rotation angles to U
  // TODO : These can really be defined as one operation
  Us[start][start] = cosRotationL;
  Us[start][end] = -sinRotationL;
  Us[end][start] = sinRotationL;
  Us[end][end] = cosRotationL;

  // Add rotation angles to V
  Vs[start][start] = cosRotationR;
  Vs[start][end] = -sinRotationR;
  Vs[end][start] = sinRotationR;
  Vs[end][end] = cosRotationR;

  // TODO : Do we really need to transpose? This causes more code and requires more registers
  // Tranpose needed matrices for multiplication
  transposeMatrix(4, Us, UTs);
  transposeMatrix(4, Vs, VTs);
  transposeMatrix(4, rightMatrix, VT);

  // Calculate new leftMatrix
  int resultHolder[4][4];
  multiplyMatrices(4, leftMatrix, UTs, resultHolder);
  convert_4by4_array(resultHolder, leftMatrix); // Copies result back into the left matrix

  int test[4][4];
  // Calculate middle matrix
  multiplyMatrices(4, Us, matrix, resultHolder);
  multiplyMatrices(4, resultHolder, VTs, matrix);
  copyMatrix(4, matrix, test);
  convert_4by4_array(test, matrix);

  // Calculate right matrix
  multiplyMatrices(4, Vs, rightMatrix, resultHolder);
  convert_4by4_array(resultHolder, rightMatrix); // Copies result back into the right matrix
}

int main()
{

  // Init of needed matrices for calculation
  int matrix[SIZE][SIZE] = {
      {31, 77, -11, 26},
      {-42, 14, 79, -53},
      {-68, -10, 45, 90},
      {34, 16, 38, -19}};

  int leftMatrix[4][4] = {
      {1, 0, 0, 0},
      {0, 1, 0, 0},
      {0, 0, 1, 0},
      {0, 0, 0, 1}};

  int rightMatrix[4][4] = {
      {1, 0, 0, 0},
      {0, 1, 0, 0},
      {0, 0, 1, 0},
      {0, 0, 0, 1}};

  int iterations = 0;

  // Checks if matrix is diagonal, sets initial condition
  bool diagMatrix = checkOffDiagonalZeros(4, matrix);

  // Perform sweeps / rotations until the matrix has been diagonalized
  while (diagMatrix == false)
  {
    getSubMatrix(matrix, leftMatrix, rightMatrix, 0, 1);
    getSubMatrix(matrix, leftMatrix, rightMatrix, 0, 2);
    getSubMatrix(matrix, leftMatrix, rightMatrix, 0, 3);
    getSubMatrix(matrix, leftMatrix, rightMatrix, 1, 2);
    getSubMatrix(matrix, leftMatrix, rightMatrix, 1, 3);
    getSubMatrix(matrix, leftMatrix, rightMatrix, 2, 3);
    iterations++;
    printf("Iteration: %d\n", iterations);
    printMatrixArray(4, matrix);
    diagMatrix = checkOffDiagonalZeros(4, matrix);
  }
  printf("Final Result:\n");
  printMatrixArray(4, matrix);

  return 0;
}
