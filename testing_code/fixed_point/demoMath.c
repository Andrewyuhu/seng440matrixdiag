#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#define SIZE 4
#define PI 3.141592654
#define TOLERANCE 0.0001


int16_t toFixed(double floatingValue) {
  int16_t fixedVersion = (int16_t)(floatingValue*32);
  return fixedVersion;
}

double toDouble (int32_t intVal) {
  double doubleVersion = (double)(intVal) / (32 * 32);
  return doubleVersion;
}

int main() {
  
  double testerValue3 = 21.12121;
  double testerValue4 = 21.32131;
  double product2 = testerValue3 * testerValue4;
  printf("%f\n", product2);

  int16_t testerValue = toFixed(testerValue3);
  int16_t testerValue2 = toFixed(testerValue4);
  int32_t product = testerValue * testerValue2;
  double convertedProduct = toDouble(product);
  printf("%f\n", convertedProduct);
  
  return 0;
}
