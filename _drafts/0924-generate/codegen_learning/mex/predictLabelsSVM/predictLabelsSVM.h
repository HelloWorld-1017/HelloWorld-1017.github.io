/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * predictLabelsSVM.h
 *
 * Code generation for function 'predictLabelsSVM'
 *
 */

#pragma once

/* Include files */
#include "predictLabelsSVM_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void predictLabelsSVM(const emlrtStack *sp, const real_T x[200],
                      cell_wrap_0 label[100]);

/* End of code generation (predictLabelsSVM.h) */
