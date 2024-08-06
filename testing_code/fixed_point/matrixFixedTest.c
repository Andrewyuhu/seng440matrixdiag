#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type

int to_fixed_point_angle(float value);
int to_fixed_point_value(float value);
float to_float_value(int value);

// Converts floating to fixed point
int to_fixed_point_angle(float value)
{
  return (int)roundf(value * 16384); // 16384 = 2 ^ 14 S.F
}

int to_fixed_point_value(float value)
{
  return (int)roundf(value * 20); // 2 ^ 15 / 2 ^ 11 = 2 ^ 4 = 16
}

float to_float_value(int value)
{
  return (float)(value / (20.0 * 20.0)); // 2 ^ (4 + 14)
}

void multiplyMatricesFloat(int size, float mat1[2][2],
                           float mat2[2][2],
                           float result[2][2])
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

void printMatrixArrayFloat(int size, float matrix[2][2])
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

void convert_4by4_array_to_float(int array[2][2], float result[2][2])
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = to_float_value(array[i][j]);
    }
  }
}

void convert_4by4_array_to_int(float array[2][2], int result[2][2])
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      result[i][j] = to_fixed_point_value(array[i][j]);
    }
  }
}

void multiplyMatricesInt(int size, int mat1[2][2],
                         int mat2[2][2],
                         int result[2][2])
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

int main()
{

  float result[2][2];
  float floatArr1[2][2] = {{2.4, 2.3},
                           {22.42, 232.1}};

  float floatArr2[2][2] = {{74, 4.3},
                           {43.2, 54.2}};

  multiplyMatricesFloat(2, floatArr1, floatArr2, result);
  printMatrixArrayFloat(2, result);

  int resultInt[2][2];
  float resultIntConverted[2][2];
  int intArr1[2][2];
  int intArr2[2][2];
  convert_4by4_array_to_int(floatArr1, intArr1);
  convert_4by4_array_to_int(floatArr2, intArr2);
  multiplyMatricesInt(2, intArr1, intArr2, resultInt);
  convert_4by4_array_to_float(resultInt, resultIntConverted);
  printf("--------------------------\n");
  printMatrixArrayFloat(2, resultIntConverted);

  return 0;
}