/* Include Files */
#include "euclidean.h"
#include "norm.h"

/* Function Declarations */
static void b_binary_expand_op(double in1[2], const double in2_data[],
                               const int *in2_size, const double in3_data[],
                               const int in3_size[2]);

static double binary_expand_op(const double in1_data[], const int *in1_size,
                               const double in2_data[], const int in2_size[2],
                               int in3);

static void c_binary_expand_op(double in1[2], const double in2_data[],
                               const int *in2_size, const double in3_data[],
                               const int in3_size[2]);


static void b_binary_expand_op(double in1[2], const double in2_data[],
                               const int *in2_size, const double in3_data[],
                               const int in3_size[2])
{
  double b_in2_data[3];
  int i;
  int i1;
  int loop_ub;
  int stride_0_0;
  int stride_1_0;
  i = in3_size[0];
  stride_0_0 = (*in2_size != 1);
  stride_1_0 = (i != 1);
  if (i == 1) {
    loop_ub = *in2_size;
  } else {
    loop_ub = i;
  }
  for (i1 = 0; i1 < loop_ub; i1++) {
    b_in2_data[i1] = in2_data[i1 * stride_0_0] - in3_data[i1 * stride_1_0];
  }
  if (i == 1) {
    i = *in2_size;
  }
  in1[1] = b_norm(b_in2_data, i);
}


static double binary_expand_op(const double in1_data[], const int *in1_size,
                               const double in2_data[], const int in2_size[2],
                               int in3)
{
  double b_in1_data[3];
  int i;
  int i1;
  int loop_ub;
  int stride_0_0;
  int stride_1_0;
  i = in2_size[0];
  stride_0_0 = (*in1_size != 1);
  stride_1_0 = (i != 1);
  if (i == 1) {
    loop_ub = *in1_size;
  } else {
    loop_ub = i;
  }
  for (i1 = 0; i1 < loop_ub; i1++) {
    b_in1_data[i1] = in1_data[i1 * stride_0_0] -
                     in2_data[i1 * stride_1_0 + in2_size[0] * (in3 + 1)];
  }
  if (i == 1) {
    i = *in1_size;
  }
  return b_norm(b_in1_data, i);
}


static void c_binary_expand_op(double in1[2], const double in2_data[],
                               const int *in2_size, const double in3_data[],
                               const int in3_size[2])
{
  double b_in2_data[3];
  int i;
  int i1;
  int loop_ub;
  int stride_0_0;
  int stride_1_0;
  i = in3_size[0];
  stride_0_0 = (*in2_size != 1);
  stride_1_0 = (i != 1);
  if (i == 1) {
    loop_ub = *in2_size;
  } else {
    loop_ub = i;
  }
  for (i1 = 0; i1 < loop_ub; i1++) {
    b_in2_data[i1] = in2_data[i1 * stride_0_0] - in3_data[i1 * stride_1_0];
  }
  if (i == 1) {
    i = *in2_size;
  }
  in1[0] = b_norm(b_in2_data, i);
}


void euclidean(const double x_data[], const int x_size[1],
               const double cb_data[], const int cb_size[2],
               double y_min_data[], int y_min_size[1], double y_max_data[],
               int y_max_size[1], double idx[2], double distance[2])
{
  double b_x_data[3];
  int b_index;
  int i;
  int loop_ub;
  /*  Initialize minimum distance as distance to first element of cb */
  /*  Initialize maximum distance as distance to first element of cb */
  /*  Initialize minimum distance as distance to first element of cb */
  /*  Initialize maximum distance as distance to first element of cb */
  idx[0] = 1.0;
  idx[1] = 1.0;
  if (x_size[0] == cb_size[0]) {
    loop_ub = x_size[0];
    for (i = 0; i < loop_ub; i++) {
      b_x_data[i] = x_data[i] - cb_data[i];
    }
    distance[0] = b_norm(b_x_data, x_size[0]);
    loop_ub = x_size[0];
    for (i = 0; i < loop_ub; i++) {
      b_x_data[i] = x_data[i] - cb_data[i];
    }
    distance[1] = b_norm(b_x_data, x_size[0]);
  } else {
    c_binary_expand_op(distance, x_data, &x_size[0], cb_data, cb_size);
    b_binary_expand_op(distance, x_data, &x_size[0], cb_data, cb_size);
  }
  /*  Find the vector in cb with minimum distance to x */
  /*  Find the vector in cb with maximum distance to x */
  loop_ub = x_size[0];
  for (b_index = 0; b_index < 215; b_index++) {
    double d;
    if (x_size[0] == cb_size[0]) {
      for (i = 0; i < loop_ub; i++) {
        b_x_data[i] = x_data[i] - cb_data[i + cb_size[0] * (b_index + 1)];
      }
      d = b_norm(b_x_data, x_size[0]);
    } else {
      d = binary_expand_op(x_data, &x_size[0], cb_data, cb_size, b_index);
    }
    if (d < distance[0]) {
      distance[0] = d;
      idx[0] = (double)b_index + 2.0;
    }
    if (d > distance[1]) {
      distance[1] = d;
      idx[1] = (double)b_index + 2.0;
    }
  }
  /*  Output the minimum and maximum distance vectors */
  loop_ub = cb_size[0];
  y_min_size[0] = cb_size[0];
  for (i = 0; i < loop_ub; i++) {
    y_min_data[i] = cb_data[i + cb_size[0] * ((int)idx[0] - 1)];
  }
  loop_ub = cb_size[0];
  y_max_size[0] = cb_size[0];
  for (i = 0; i < loop_ub; i++) {
    y_max_data[i] = cb_data[i + cb_size[0] * ((int)idx[1] - 1)];
  }
}