#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type
#define TOLERANCE 0.0001

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

// Loop Unrolled Matrix Multiply
void matrixMultiply(int mat1[4][4], int mat2[4][4], int storeInMat1)
{
    int result[4][4];

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

void multiplyWithTransposed(int mat1[4][4], int mat2[4][4], int storeInMat1)
{
    int result[4][4];

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

// Converts [-1,1] to fixed point
int to_fixed(float angle)
{
    return (int)roundf(angle * (1 << 11));
}

void apply_to_fixed_in_place(float matrix[4][4])
{
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            matrix[i][j] = to_fixed(matrix[i][j]);
        }
    }
}

void getSubMatrix(int matrix[4][4], int start, int end)
{

    // This area we will calculate in floats due to the nature of sin / cos
    float angleSum = atan((float)(matrix[end][start] + matrix[start][end]) / (float)(matrix[end][end] - matrix[start][start]));
    float angleDiff = atan((float)(matrix[end][start] - matrix[start][end]) / (float)(matrix[end][end] + matrix[start][start]));
    float angleL = (angleSum - angleDiff) / 2.0;
    float angleR = (angleSum - angleL);

    // From here, we will operate fill in fixed point arithmetic
    int cosRotationR = to_fixed(cos(angleR));
    int sinRotationR = to_fixed(sin(angleR));
    int cosRotationL = to_fixed(cos(angleL));
    int sinRotationL = to_fixed(sin(angleL));

    int Us[4][4] = {
        {2047, 0, 0, 0},
        {0, 2047, 0, 0},
        {0, 0, 2047, 0},
        {0, 0, 0, 2047}};
    int Vs[4][4] = {
        {2047, 0, 0, 0},
        {0, 2047, 0, 0},
        {0, 0, 2047, 0},
        {0, 0, 0, 2047}};

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
    // multiplyWithTransposed(leftMatrix, Us, 1);
    matrixMultiply(Us, matrix, 0); // MIDDLE MATRIX
    multiplyWithTransposed(matrix, Vs, 1);
    // matrixMultiply(Vs, rightMatrix, 0); // RIGHT MATRIX
}

int main()
{

    // Init of needed matrices for calculation
    int matrix[4][4] = {
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

    getSubMatrix(matrix, 0, 1);

    printMatrixArray(4, matrix);

    return 0;
}
