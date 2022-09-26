#ifndef EUCLIDEAN_H
#define EUCLIDEAN_H

/* Include Files */
#include "rtwtypes.h"
#include <stddef.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
extern void euclidean(const double x_data[], const int x_size[1],
                      const double cb_data[], const int cb_size[2],
                      double y_min_data[], int y_min_size[1],
                      double y_max_data[], int y_max_size[1], double idx[2],
                      double distance[2]);

#ifdef __cplusplus
}
#endif

#endif
