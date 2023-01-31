/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_predictLabelsSVM_mex.c
 *
 * Code generation for function '_coder_predictLabelsSVM_mex'
 *
 */

/* Include files */
#include "_coder_predictLabelsSVM_mex.h"
#include "_coder_predictLabelsSVM_api.h"
#include "predictLabelsSVM_data.h"
#include "predictLabelsSVM_initialize.h"
#include "predictLabelsSVM_terminate.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&predictLabelsSVM_atexit);
  /* Module initialization. */
  predictLabelsSVM_initialize();
  /* Dispatch the entry-point. */
  predictLabelsSVM_mexFunction(nlhs, plhs, nrhs, prhs);
  /* Module termination. */
  predictLabelsSVM_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, (const char_T *)"GBK", true);
  return emlrtRootTLSGlobal;
}

void predictLabelsSVM_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
                                  const mxArray *prhs[1])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *outputs;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 1, 4,
                        16, "predictLabelsSVM");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 16,
                        "predictLabelsSVM");
  }
  /* Call the function. */
  predictLabelsSVM_api(prhs[0], &outputs);
  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, &plhs[0], &outputs);
}

/* End of code generation (_coder_predictLabelsSVM_mex.c) */
