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

// Converts floating to fixed point
// 16 bit max value / range (2^11-1, 2^11)
int to_fixed_point_value(float value)
{
  return (int)roundf(value * 16); // 2 ^ 15 / 2 ^ 11 = 2 ^ 4 = 16
}

// Converts floating to fixed point
// 16 bit max value / range (2^11-1, 2^11)
float to_float_value(int value)
{
  return (float)(value / (16.0 * 16384.0)); // 2 ^ (4 + 14)
}

float to_float_value_shift(int value)
{
  return (float)(value >> 18);
}

int main()
{

  float value = 45.753;
  float angle = 0.45;

  int valueINT = to_fixed_point_value(value);
  int valueANGLE = to_fixed_point_angle(angle);
  int productConvert = valueINT * valueANGLE;
  float outputConverted = to_float_value(valueINT * valueANGLE);
  float outputRegular = value * angle;

  printf("Converted Output with fixed arithmetic: %f\n", outputConverted);
  printf("Regular floating arithmetic: %f\n", outputRegular);
  printf("Regular representation of a scaled product: %d\n", productConvert);
  printf("Hexadecimal representation of a scaled product: %08X\n", productConvert);

  // Test to see how the system holds float values
  float test = 3.256;
  unsigned int *p = (unsigned int *)&test;
  printf("Hexadecimal representation of a float 3.256 : %08X\n", *p);

  // Test to see how the system handles rounding
  float infiniteRound = 1 / 3.0;
  unsigned int *z = (unsigned int *)&infiniteRound;
  printf("Hexadecimal representation of a float 3.333... : %08X\n", *z);

  return 0;
}