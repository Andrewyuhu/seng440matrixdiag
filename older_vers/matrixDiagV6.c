#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type
#define TOLERANCE 0.0001

void getSubMatrix(float matrix[4][4], float leftMatrix[4][4], float rightMatrix[4][4], int start, int end);
void printMatrixArray(int size, float matrix[size][size]);
bool checkOffDiagonalZeros(int size, float matrix[size][size]);

// Check if final result is correct
bool checkOffDiagonalZeros(int size, float matrix[size][size])
{
  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      if (i != j && fabs(matrix[i][j]) > TOLERANCE)
      {
        return false;
      }
    }
  }
  return true;
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

// Loop Unrolled Matrix Multiply
void matrixMultiply(float mat1[4][4], float mat2[4][4], int storeInMat1)
{
  float result[4][4];

  // Perform matrix multiplication with loop unrolling
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = 0;
      result[i][j] += mat1[i][0] * mat2[0][j];
      result[i][j] += mat1[i][1] * mat2[1][j];
      result[i][j] += mat1[i][2] * mat2[2][j];
      result[i][j] += mat1[i][3] * mat2[3][j];
    }
  }

  // Copy the result back to matrix mat1 or mat2 based on the flag storeInMat1
  if (storeInMat1)
  {
    for (int i = 0; i < 4; i++)
    {

      mat1[i][0] = result[i][0];
      mat1[i][1] = result[i][1];
      mat1[i][2] = result[i][2];
      mat1[i][3] = result[i][3];
    }
  }
  else
  {
    for (int i = 0; i < 4; i++)
    {
      mat2[i][0] = result[i][0];
      mat2[i][1] = result[i][1];
      mat2[i][2] = result[i][2];
      mat2[i][3] = result[i][3];
    }
  }
}

void multiplyWithTransposed(float mat1[4][4], float mat2[4][4], int storeInMat1)
{
  float result[4][4];

  // Perform matrix multiplication where mat2 is accessed as its transpose
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = 0;

      // Unroll the innermost loop
      result[i][j] += mat1[i][0] * mat2[j][0];
      result[i][j] += mat1[i][1] * mat2[j][1];
      result[i][j] += mat1[i][2] * mat2[j][2];
      result[i][j] += mat1[i][3] * mat2[j][3];
    }
  }

  // Copy the result back to matrix mat1 or mat2 based on the flag storeInMat1
  if (storeInMat1)
  {
    for (int i = 0; i < 4; i++)
    {
      mat1[i][0] = result[i][0];
      mat1[i][1] = result[i][1];
      mat1[i][2] = result[i][2];
      mat1[i][3] = result[i][3];
    }
  }
  else
  {
    for (int i = 0; i < 4; i++)
    {
      mat2[i][0] = result[i][0];
      mat2[i][1] = result[i][1];
      mat2[i][2] = result[i][2];
      mat2[i][3] = result[i][3];
    }
  }
}

void getSubMatrix(float matrix[4][4], float leftMatrix[4][4], float rightMatrix[4][4], int start, int end)
{

  float angleSum = atan((matrix[end][start] + matrix[start][end]) / (matrix[end][end] - matrix[start][start]));
  float angleDiff = atan((matrix[end][start] - matrix[start][end]) / (matrix[end][end] + matrix[start][start]));
  float angleL = (angleSum - angleDiff) / 2.0;
  float angleR = (angleSum - angleL);
  float cosRotationR = cos(angleR);
  float sinRotationR = sin(angleR);
  float cosRotationL = cos(angleL);
  float sinRotationL = sin(angleL);

  float Us[4][4] = {
      {1.0, 0.0, 0.0, 0.0},
      {0.0, 1.0, 0.0, 0.0},
      {0.0, 0.0, 1.0, 0.0},
      {0.0, 0.0, 0.0, 1.0}};
  float Vs[4][4] = {
      {1.0, 0.0, 0.0, 0.0},
      {0.0, 1.0, 0.0, 0.0},
      {0.0, 0.0, 1.0, 0.0},
      {0.0, 0.0, 0.0, 1.0}};

  // Add rotation angles to U
  Us[start][start] = cosRotationL;
  Us[start][end] = -sinRotationL;
  Us[end][start] = sinRotationL;
  Us[end][end] = cosRotationL;

  // Add rotation angles to V
  Vs[start][start] = cosRotationR;
  Vs[start][end] = -sinRotationR;
  Vs[end][start] = sinRotationR;
  Vs[end][end] = cosRotationR;

  // matrixMultiply(leftMatrix, UTs, 1); // LEFT MATRIX
  multiplyWithTransposed(leftMatrix, Us, 1);
  matrixMultiply(Us, matrix, 0); // MIDDLE MATRIX
  multiplyWithTransposed(matrix, Vs, 1);
  matrixMultiply(Vs, rightMatrix, 0); // RIGHT MATRIX
}

int main()
{

  // Init of needed matrices for calculation
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
    diagMatrix = checkOffDiagonalZeros(4, matrix);
  }

  printMatrixArray(4, matrix);

  return 0;
}
