#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h> // Include <stdbool.h> for bool type
#define SIZE 4
#define PI 3.141592654
#define TOLERANCE 0.0001

// Function Definitions
void getSubMatrix(double matrix[SIZE][SIZE], double leftMatrix[SIZE][SIZE], double rightMatrix[SIZE][SIZE], int start, int end);
void printMatrixArray(int size, double matrix[size][size]);
void transposeMatrix(int size, double matrix[size][size], double transposed[size][size]);
void copyMatrix(int size, double source[size][size], double destination[size][size]);
bool checkOffDiagonalZeros(int size, double matrix[size][size]);

// Check if final result is correct
bool checkOffDiagonalZeros(int size, double matrix[size][size]) {
    int i,j;
    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            if (i != j && fabs(matrix[i][j]) > TOLERANCE) {
                return false;
            }
        }
    }
    return true;
}

// Takes a matrix and transposes it
void transposeMatrix(int size, double matrix[size][size], double transposed[size][size]) {
    int i,j;
    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            transposed[j][i] = matrix[i][j];
        }
    }
}

// Copies a matrix from one var to another
void copyMatrix(int size, double source[size][size], double destination[size][size]) {
    int i,j;
    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            destination[i][j] = source[i][j];
        }
    }
}

// Prints a matrix in an easy to read format
void printMatrixArray(int size, double matrix[size][size]) {
    int i,j;
    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            printf("%f ", matrix[i][j]);
        }
        printf("\n");
    }
}

// Takes in a int size, multiplies mat1 and mat2 and stores result in result
void multiplyMatrices(int size,double mat1[size][size],
                      double mat2[size][size],
                      double result[size][size]) {

    int i,j,k;
    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            result[i][j] = 0;
        }
    }

    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            for (k = 0; k < size; k++) {
                result[i][j] += mat1[i][k] * mat2[k][j];
            }
        }
    }
}


void getSubMatrix(double matrix[SIZE][SIZE], double leftMatrix[SIZE][SIZE], double rightMatrix[SIZE][SIZE], int start, int end) {

    // Allocate memory for the submatrix
    double sweepMatrix[2][2];
    sweepMatrix[0][0] = matrix[start][start];
    sweepMatrix[0][1] = matrix[start][end];
    sweepMatrix[1][0] = matrix[end][start];
    sweepMatrix[1][1] = matrix[end][end];

    // Define variables for calculating needed rotation angles
    double angleR;
    double angleL;
    double angleSum;
    double angleDiff;

    angleSum = atan((sweepMatrix[1][0] + sweepMatrix[0][1])/(sweepMatrix[1][1] - sweepMatrix[0][0]));
    angleDiff = atan((sweepMatrix[1][0] - sweepMatrix[0][1])/(sweepMatrix[1][1] + sweepMatrix[0][0]));

    angleL = (angleSum - angleDiff) / 2.0;
    angleR = (angleSum - angleL);

    // Apply the 2x2 rotations to the submatrix with the angles
    // End result of this section should return 2 values to be added to the matrix
    // NOTE : It is interesting because the non-diagonial elements are set to 0 always in the demo

    // Define all sin / cos calculations once to be reused
    double cosRotationR  = cos(angleR);
    double sinRotationR = sin(angleR);
    double cosRotationL = cos(angleL);
    double sinRotationL = sin(angleL);

    double resultMatrix[2][2];

    // Initilization of left Rotation Matrix
    double rotateMatrix[2][2] = {
    {cosRotationL, -sinRotationL},
    {sinRotationL, cosRotationL}
    };

    multiplyMatrices(2, rotateMatrix, sweepMatrix, resultMatrix);

    // Redfine rotate matrix for RIGHT rotation
    rotateMatrix[0][0] = cosRotationR;
    rotateMatrix[0][1] = sinRotationR;
    rotateMatrix[1][0] = -sinRotationR;
    rotateMatrix[1][1] = cosRotationR;
    multiplyMatrices(2, resultMatrix, rotateMatrix, sweepMatrix);

    // This section deals with applying the smaller rotations to main matrices
    // leftMatrix is U, rightMatrix is V

    // Init as one dimensional array
    double Us[4][4] = {
        {1.0, 0.0, 0.0, 0.0},
        {0.0, 1.0, 0.0, 0.0},
        {0.0, 0.0, 1.0, 0.0},
        {0.0, 0.0, 0.0, 1.0}
    };
    double Vs[4][4] = {
        {1.0, 0.0, 0.0, 0.0},
        {0.0, 1.0, 0.0, 0.0},
        {0.0, 0.0, 1.0, 0.0},
        {0.0, 0.0, 0.0, 1.0}
    };
    double UTs[4][4];
    double VTs[4][4];
    double VT[4][4];

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

    // Tranpose needed matrices for multiplication
    // We can modify the way multiplication works to prevent having to call the tranpose function
    transposeMatrix(4, Us, UTs);
    transposeMatrix(4, Vs, VTs);
    transposeMatrix(4, rightMatrix, VT);

    // Calculate new leftMatrix
    double resultHolder[4][4];
    multiplyMatrices(4,leftMatrix,UTs, resultHolder);
    copyMatrix(4, resultHolder, leftMatrix); // Copies result back into the left matrix

    // Calculate middle matrix
    multiplyMatrices(4, Us, matrix, resultHolder);
    multiplyMatrices(4, resultHolder, VTs, matrix); 

    // Calculate right matrix
    multiplyMatrices(4,Vs,rightMatrix, resultHolder);
    copyMatrix(4, resultHolder, rightMatrix); // Copies result back into the left matrix

}

int main() {

    // Init of needed matrices for calculation
    double matrix[SIZE][SIZE] = {
        {31.0, 77.0, -11.0, 26.0},
        {-42.0, 14.0, 79.0, -53.0},
        {-68.0, -10.0, 45.0, 90.0},
        {34.0, 16.0, 38.0, -19.0}
    };

    // Can be defined as a single one-dimensional array
    double leftMatrix[4][4] = {
        {1.0, 0.0, 0.0, 0.0},
        {0.0, 1.0, 0.0, 0.0},
        {0.0, 0.0, 1.0, 0.0},
        {0.0, 0.0, 0.0, 1.0}
    };

    // Can be defined as a single one-dimensional array
     double rightMatrix[4][4] = {
        {1.0, 0.0, 0.0, 0.0},
        {0.0, 1.0, 0.0, 0.0},
        {0.0, 0.0, 1.0, 0.0},
        {0.0, 0.0, 0.0, 1.0}
    };

    int iterations = 0;

    // Checks if matrix is diagonal, sets initial condition
    bool diagMatrix = checkOffDiagonalZeros(4,matrix);

    // Perform sweeps / rotations until the matrix has been diagonalized
    while (diagMatrix == false) {
      getSubMatrix(matrix,leftMatrix,rightMatrix,0,1);
      getSubMatrix(matrix,leftMatrix,rightMatrix,0,2);
      getSubMatrix(matrix,leftMatrix,rightMatrix,0,3);
      getSubMatrix(matrix,leftMatrix,rightMatrix,1,2);
      getSubMatrix(matrix,leftMatrix,rightMatrix,1,3);
      getSubMatrix(matrix,leftMatrix,rightMatrix,2,3);
      iterations++;
      printf("Iteration: %d\n", iterations);
      diagMatrix = checkOffDiagonalZeros(4,matrix);
    }

    printMatrixArray(4,matrix);
    
    return 0;
}
