/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: norm.c
 *
 * MATLAB Coder version            : 5.4
 * C/C++ source code generated on  : 25-Sep-2022 00:36:09
 */

/* Include Files */
#include "norm.h"
#include <math.h>

/* Function Definitions */
/*
 * Arguments    : const double x_data[]
 *                int x_size
 * Return Type  : double
 */
double b_norm(const double x_data[], int x_size)
{
  double y;
  int k;
  if (x_size == 0) {
    y = 0.0;
  } else {
    y = 0.0;
    if (x_size == 1) {
      y = fabs(x_data[0]);
    } else {
      double scale;
      scale = 3.3121686421112381E-170;
      for (k = 0; k < x_size; k++) {
        double absxk;
        absxk = fabs(x_data[k]);
        if (absxk > scale) {
          double t;
          t = scale / absxk;
          y = y * t * t + 1.0;
          scale = absxk;
        } else {
          double t;
          t = absxk / scale;
          y += t * t;
        }
      }
      y = scale * sqrt(y);
    }
  }
  return y;
}

/*
 * File trailer for norm.c
 *
 * [EOF]
 */
