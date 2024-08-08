#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type

#define SCALE 9
#define DESCALE 18
#define BASE ((1 << (SCALE)) - 1)
// Macro to convert float to fixed-point
#define TO_FIXED(angle) ((int)roundf((angle) * (1 << SCALE)))
// Macro to convert fixed-point to integer
#define FIXED_TO_INT(fixed) ((fixed) / (1 << DESCALE))

// Check if final result is correct
bool checkOffDiagonalZeros(int size, int matrix[size][size])
{
    int i, j;
    for (i = 0; i < size; i++)
    {
        for (j = 0; j < size; j++)
        {
            if (i != j && 0 != fabs(matrix[i][j]))
            {
                return false;
            }
            else
            {
            }
        }
    }
    return true;
}

// Prints a matrix in an easy to read format
void printMatrixArray(int size, int matrix[size][size])
{
    int i;
    for (i = 0; i < size; i++)
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
    int i, j;
    for (i = 0; i < 4; i++)
    {
        for (j = 0; j < 4; j++)
        {
            result[i][j] = 0;
            result[i][j] += mat1[i][0] * mat2[0][j];
            result[i][j] += mat1[i][1] * mat2[1][j];
            result[i][j] += mat1[i][2] * mat2[2][j];
            result[i][j] += mat1[i][3] * mat2[3][j];
        }
    }

    // Copy the result back to matrix mat1 or mat2 BASEd on the flag storeInMat1
    if (storeInMat1)
    {
        for (i = 0; i < 4; i++)
        {

            mat1[i][0] = result[i][0];
            mat1[i][1] = result[i][1];
            mat1[i][2] = result[i][2];
            mat1[i][3] = result[i][3];
        }
    }
    else
    {
        for (i = 0; i < 4; i++)
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
    int i;
    int j;
    for (i = 0; i < 4; i++)
    {
        for (j = 0; j < 4; j++)
        {
            result[i][j] = 0;

            // Unroll the innermost loop
            result[i][j] += mat1[i][0] * mat2[j][0];
            result[i][j] += mat1[i][1] * mat2[j][1];
            result[i][j] += mat1[i][2] * mat2[j][2];
            result[i][j] += mat1[i][3] * mat2[j][3];
        }
    }

    // Copy the result back to matrix mat1 or mat2 BASEd on the flag storeInMat1
    if (storeInMat1)
    {
        for (i = 0; i < 4; i++)
        {
            mat1[i][0] = result[i][0];
            mat1[i][1] = result[i][1];
            mat1[i][2] = result[i][2];
            mat1[i][3] = result[i][3];
        }
    }
    else
    {
        for (i = 0; i < 4; i++)
        {
            mat2[i][0] = result[i][0];
            mat2[i][1] = result[i][1];
            mat2[i][2] = result[i][2];
            mat2[i][3] = result[i][3];
        }
    }
}

// Reverts scaled matrix back to regular values
void apply_to_fixed_in_place(int matrix[4][4])
{
    int i;
    for (i = 0; i < 4; i++)
    {
        matrix[i][0] = FIXED_TO_INT(matrix[i][0]);
        matrix[i][1] = FIXED_TO_INT(matrix[i][1]);
        matrix[i][2] = FIXED_TO_INT(matrix[i][2]);
        matrix[i][3] = FIXED_TO_INT(matrix[i][3]);
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
    int cosRotationR = TO_FIXED(cos(angleR));
    int sinRotationR = TO_FIXED(sin(angleR));
    int cosRotationL = TO_FIXED(cos(angleL));
    int sinRotationL = TO_FIXED(sin(angleL));

    int Us[4][4] = {
        {BASE, 0, 0, 0},
        {0, BASE, 0, 0},
        {0, 0, BASE, 0},
        {0, 0, 0, BASE}};

    int Vs[4][4] = {
        {BASE, 0, 0, 0},
        {0, BASE, 0, 0},
        {0, 0, BASE, 0},
        {0, 0, 0, BASE}};

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

    matrixMultiply(Us, matrix, 0);
    multiplyWithTransposed(matrix, Vs, 1);
    apply_to_fixed_in_place(matrix);
}

int main()
{

    // Init of needed matrices for calculation
    int matrix[4][4] = {
        {31, 77, -11, 26},
        {-42, 14, 79, -53},
        {-68, -10, 45, 90},
        {34, 16, 38, -19}};

    int iterations = 0;

    // Checks if matrix is diagonal, sets initial condition bool diagMatrix = checkOffDiagonalZeros(4, matrix);
    bool diagMatrix = checkOffDiagonalZeros(4, matrix);

    // Perform sweeps / rotations until the matrix has been diagonalized
    while (diagMatrix == false)
    {
        getSubMatrix(matrix, 0, 1);
        getSubMatrix(matrix, 0, 2);
        getSubMatrix(matrix, 0, 3);
        getSubMatrix(matrix, 1, 2);
        getSubMatrix(matrix, 1, 3);
        getSubMatrix(matrix, 2, 3);
        iterations++;
        printf("Iteration: %d\n", iterations);
        diagMatrix = checkOffDiagonalZeros(4, matrix);
    }

    printMatrixArray(4, matrix);

    return 0;
}
