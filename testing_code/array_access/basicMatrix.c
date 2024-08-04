#include <stdio.h>

int main () {
    int matrix[2][2] = {{1,2},{3,64}};

    int row,col;
    for (row = 0; row < 2; row++) {
        for (col = 0; col < 2; col++) {
            printf("%d\n",matrix[row][col]);
        }
    }
    return 0;
}