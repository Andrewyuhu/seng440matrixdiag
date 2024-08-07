#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type

// Converts floating to fixed point
int to_fixed_point_angle(float value)
{
    return (int)roundf(value * (1 << 11)); // 16384 = 2 ^ 11 S.F
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

    int inputArr[2][2] = {{12, 31}, {43, 54}};
    float angle = 23.3; // Demo Angle

    float floatSin = sinf(angle);
    int fixedSin = to_fixed_point_angle(floatSin);

    printf("Demo for a fixed point conversion and back");
    printf("Float Sin Value : %f\n", floatSin);
    printf("Fixed Sin Value : %d\n", fixedSin);
    printf("Fixed Sin Value Converted back to float: %f\n", fixedSin / (float)(1 << 11));
    printf("------------------------\n");

    return 0;
}