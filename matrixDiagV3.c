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

int main()
{

  float value = 45.753;
  float angle = 0.45;

  int valueINT = to_fixed_point_value(value);
  int valueANGLE = to_fixed_point_angle(angle);
  // printf("Converted Value: %d\n", valueINT);
  // printf("Converted Angle: %d\n", valueANGLE);
  float outputConverted = to_float_value(valueINT * valueANGLE);
  float outputRegular = value * angle;
  // printf("Converted Answer: %d\n", valueINT * valueANGLE);
  // printf("Fixed Arithmetic : %f\n", outputConverted);
  // printf("Regular Arithmetic : %f\n", value * angle);

  return 0;
}