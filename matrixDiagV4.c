#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type
#define TOLERANCE 0.0001

int to_fixed_point_angle(float value);
int to_fixed_point_value(float value);
float to_float_value(int value);
void printMatrixArray(int size, float matrix[size][size]);
void transposeMatrix(int size, int matrix[size][size], int transposed[size][size]);
void copyMatrix(int size, int source[size][size], int destination[size][size]);
bool checkOffDiagonalZeros(int size, float matrix[4][4]);

// Converts floating to fixed point
int to_fixed_point_angle(float value)
{
  return (int)roundf(value * 16384); // 16384 = 2 ^ 14 S.F
}

// Converts floating to fixed point
// 16 bit max value / range (2^11-1, 2^11)
int to_fixed_point_value(float value)
{
  return (int)roundf(value * 20); // 2 ^ 15 / 2 ^ 11 = 2 ^ 4 = 16
}

// Converts floating to fixed point
// 16 bit max value / range (2^11-1, 2^11)
float to_float_value(int value)
{
  return (float)(value / ((20.0) * (20.0))); // 2 ^ (4 + 14)
}

float to_float_value_extra(int value)
{
  return (float)(value / ((20.0) * (20.0) * (20.0))); // 2 ^ (4 + 14)
}

// Multiplies two matrices and stores in a resultant matrix
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

// Check if final result is correct
bool checkOffDiagonalZeros(int size, float matrix[4][4])
{
  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      // Comparing with 0 is an optimization
      if (i != j && fabsf(matrix[i][j]) >= TOLERANCE)
      {
        return false;
      }
    }
  }
  return true;
}

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

// Prints a matrix in an easy to read format
void printMatrixArray(int size, float matrix[size][size])
{
  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      printf("%f ", matrix[i][j]);
    }
    printf("\n");
  }
}

void printMatrixArrayInt(int size, int matrix[size][size])
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

// Converts array back to floating
void convert_4by4_array_float(int array[4][4], float result[4][4])
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = to_float_value(array[i][j]);
    }
  }
}

// Converts array back to floating
void convert_4by4_array_int(float array[4][4], int result[4][4])
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = to_fixed_point_value(array[i][j]);
    }
  }
}

void convert_4by4_array_int_angle(float array[4][4], int result[4][4])
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = to_fixed_point_angle(array[i][j]);
    }
  }
}

void convert_4by4_array_float_extra(int array[4][4], float result[4][4])
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = to_float_value_extra(array[i][j]);
    }
  }
}

// Preforms the bulk of the Jacobi ALGO
// Grabs a sub-array of the array
void getSubMatrix(float matrix[4][4], float leftMatrix[4][4], float rightMatrix[4][4], int start, int end)
{

  // Converts input matrices to FIXED POINT equivalents
  int matrixFP[4][4];
  int leftMatrixFP[4][4];
  int rightMatrixFP[4][4];
  convert_4by4_array_int(matrix, matrixFP);
  convert_4by4_array_int(rightMatrix, rightMatrixFP);
  convert_4by4_array_int(leftMatrix, leftMatrixFP);

  // Grab a sub array to calculate a rotation matrix
  int sweepMatrix[2][2] = {{matrix[start][start], matrix[start][end]},
                           {matrix[end][start], matrix[end][end]}};

  // These variables can remain as floats as the angle function requires it
  // Define variables for calculating needed rotation angles
  float angleR;
  float angleL;
  float angleSum;
  float angleDiff;
  angleSum = atan((float)((sweepMatrix[1][0] + sweepMatrix[0][1]) / (sweepMatrix[1][1] - sweepMatrix[0][0])));
  angleDiff = atan((float)((sweepMatrix[1][0] - sweepMatrix[0][1]) / (sweepMatrix[1][1] + sweepMatrix[0][0])));
  angleL = (angleSum - angleDiff) / 2.0; // The overhead to convert and convert back is most likely not worth it
  angleR = (angleSum - angleL);

  // S.F for cos / sin operations is 2^14 for 16 bit integers
  // Conversions from here can be fixed point
  int cosRotationR = to_fixed_point_value(cosf(angleR));
  int sinRotationR = to_fixed_point_value(sinf(angleR));
  int cosRotationL = to_fixed_point_value(cosf(angleL));
  int sinRotationL = to_fixed_point_value(sinf(angleL));

  printf("Fixed Point : \n");
  printf("Cos Value R : %d\n", cosRotationR);
  printf("Sin Value R: %d\n", sinRotationR);
  printf("Cos Value L: %d\n", cosRotationL);
  printf("Cos Value L: %d\n", sinRotationL);
  printf("Floating Point : \n");
  printf("Cos Value R : %f\n", cosf(angleR));
  printf("Sin Value R: %f\n", sinf(angleR));
  printf("Cos Value L: %f\n", cosf(angleL));
  printf("Cos Value L: %f\n", sinf(angleL));

  // Creating needed Matrices
  int Us[4][4] = {
      {16, 0, 0, 0},
      {0, 16, 0, 0},
      {0, 0, 16, 0},
      {0, 0, 0, 16}};
  int Vs[4][4] = {
      {16, 0, 0, 0},
      {0, 16, 0, 0},
      {0, 0, 16, 0},
      {0, 0, 0, 16}};

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

  // Tranpose needed matrices for multiplication
  transposeMatrix(4, Us, UTs);
  transposeMatrix(4, Vs, VTs);
  transposeMatrix(4, rightMatrixFP, VT);

  // Calculate new leftMatrix
  int resultHolder[4][4];

  // 2^14 + 2^14 so addition is fine here
  multiplyMatrices(4, leftMatrixFP, UTs, resultHolder);
  convert_4by4_array_float(resultHolder, leftMatrix); // Copies result back into the left matrix

  // Calculate middle matrix
  printf("Printing Rotation Matrix\n");
  printMatrixArrayInt(4, Us);

  // 2^14 + 2^4 so addition needs to be changed?
  multiplyMatrices(4, Us, matrixFP, resultHolder);

  printf("Printing Result Holder Matrix\n");
  printMatrixArrayInt(4, resultHolder);
  printf("---------------------\n");

  float tester[4][4];
  convert_4by4_array_float(resultHolder, tester);
  printf("Printing Result Holder Matrix Float\n");
  printMatrixArray(4, tester);
  printf("---------------------\n");

  printf("Printing VTs Matrix\n");
  printMatrixArrayInt(4, VTs);
  printf("---------------------\n");

  multiplyMatrices(4, resultHolder, VTs, matrixFP);

  printMatrixArrayInt(4, matrixFP);
  convert_4by4_array_float_extra(matrixFP, matrix);

  // Calculate right matrix
  multiplyMatrices(4, Vs, rightMatrixFP, resultHolder);
  convert_4by4_array_float(resultHolder, rightMatrix); // Copies result back into the right matrix
}

int main()
{
  float matrix[4][4] = {
      {31.0, 77.0, -11.0, 26.0},
      {-42.0, 14.0, 79.0, -53.0},
      {-68.0, -10.0, 45.0, 90.0},
      {34.0, 16.0, 38.0, -19.0}};

  float leftMatrix[4][4] = {
      {1.0, 0.0, 0.0, 0.0},
      {0.0, 1.0, 0.0, 0.0},
      {0.0, 0.0, 1.0, 0.0},
      {0.0, 0.0, 0.0, 1.0}};

  float rightMatrix[4][4] = {
      {1.0, 0.0, 0.0, 0.0},
      {0.0, 1.0, 0.0, 0.0},
      {0.0, 0.0, 1.0, 0.0},
      {0.0, 0.0, 0.0, 1.0}};

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
  printMatrixArray(4, matrix);
  return 0;
}