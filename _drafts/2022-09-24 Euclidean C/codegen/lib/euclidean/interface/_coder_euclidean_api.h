/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_euclidean_api.h
 *
 * MATLAB Coder version            : 5.4
 * C/C++ source code generated on  : 25-Sep-2022 00:36:09
 */

#ifndef _CODER_EUCLIDEAN_API_H
#define _CODER_EUCLIDEAN_API_H

/* Include Files */
#include "emlrt.h"
#include "tmwtypes.h"
#include <string.h>

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
void euclidean(real_T x_data[], int32_T x_size[1], real_T cb_data[],
               int32_T cb_size[2], real_T y_min_data[], int32_T y_min_size[1],
               real_T y_max_data[], int32_T y_max_size[1], real_T idx[2],
               real_T distance[2]);

void euclidean_api(const mxArray *const prhs[2], int32_T nlhs,
                   const mxArray *plhs[4]);

void euclidean_atexit(void);

void euclidean_initialize(void);

void euclidean_terminate(void);

void euclidean_xil_shutdown(void);

void euclidean_xil_terminate(void);

#ifdef __cplusplus
}
#endif

#endif
/*
 * File trailer for _coder_euclidean_api.h
 *
 * [EOF]
 */
