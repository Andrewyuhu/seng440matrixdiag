#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type
#define TOLERANCE 0.0001

// Function Definitions

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

void matrixMultiply(float mat1[4][4], float mat2[4][4], int storeInMat1)
{
  float result[4][4];

  // Perform matrix multiplication and store the result in a temporary matrix
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = 0;
      for (int k = 0; k < 4; k++)
      {
        result[i][j] += mat1[i][k] * mat2[k][j];
      }
    }
  }

  // Copy the result back to matrix mat1 or mat2 based on the flag storeInMat1
  if (storeInMat1)
  {
    for (int i = 0; i < 4; i++)
    {
      for (int j = 0; j < 4; j++)
      {
        mat1[i][j] = result[i][j];
      }
    }
  }
  else
  {
    for (int i = 0; i < 4; i++)
    {
      for (int j = 0; j < 4; j++)
      {
        mat2[i][j] = result[i][j];
      }
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
      for (int k = 0; k < 4; k++)
      {
        // Access mat2 as if it were transposed
        result[i][j] += mat1[i][k] * mat2[j][k];
      }
    }
  }

  // Copy the result back to matrix mat1 or mat2 based on the flag storeInMat1
  if (storeInMat1)
  {
    for (int i = 0; i < 4; i++)
    {
      for (int j = 0; j < 4; j++)
      {
        mat1[i][j] = result[i][j];
      }
    }
  }
  else
  {
    for (int i = 0; i < 4; i++)
    {
      for (int j = 0; j < 4; j++)
      {
        mat2[i][j] = result[i][j];
      }
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
