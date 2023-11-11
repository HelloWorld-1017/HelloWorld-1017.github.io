/* Include Files */
#include "main.h"
#include "euclidean.h"
//#include "euclidean_terminate.h"

/* Function Declarations */
static void argInit_d3x1_real_T(double result_data[], int *result_size);
static void argInit_d3x216_real_T(double result_data[], int result_size[2]);
static double argInit_real_T(void);
static void main_euclidean(void);



static void argInit_d3x1_real_T(double result_data[], int *result_size)
{
  int idx0;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  *result_size = 2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result_data[idx0] = argInit_real_T();
  }
}

static void argInit_d3x216_real_T(double result_data[], int result_size[2])
{
  int idx0;
  int idx1;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 216;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 216; idx1++) {
      /* Set the value of the array element.
Change this value to the value that the application requires. */
      result_data[idx0 + 2 * idx1] = argInit_real_T();
    }
  }
}

static double argInit_real_T(void)
{
  return 0.0;
}

static void main_euclidean(void)
{
  double cb_data[648];
  double x_data[3];
  double y_max_data[3];
  double y_min_data[3];
  double distance[2];
  double idx[2];
  int cb_size[2];
  int x_size;
  int y_max_size;
  int y_min_size;
  /* Initialize function 'euclidean' input arguments. */
  /* Initialize function input argument 'x'. */
  argInit_d3x1_real_T(x_data, &x_size);
  /* Initialize function input argument 'cb'. */
  argInit_d3x216_real_T(cb_data, cb_size);
  /* Call the entry-point 'euclidean'. */
  euclidean(x_data, *(int(*)[1]) & x_size, cb_data, cb_size, y_min_data,
            *(int(*)[1]) & y_min_size, y_max_data, *(int(*)[1]) & y_max_size,
            idx, distance);
}

int main(int argc, char **argv)
{
  (void)argc;
  (void)argv;
  /* The initialize function is being called automatically from your entry-point
   * function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
You can call entry-point functions multiple times. */
  main_euclidean();
  /* Terminate the application.
You do not need to do this more than one time. */
//  euclidean_terminate();
  return 0;
}
