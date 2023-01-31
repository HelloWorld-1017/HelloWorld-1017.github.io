/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_predictLabelsSVM_api.c
 *
 * Code generation for function '_coder_predictLabelsSVM_api'
 *
 */

/* Include files */
#include "_coder_predictLabelsSVM_api.h"
#include "predictLabelsSVM.h"
#include "predictLabelsSVM_data.h"
#include "predictLabelsSVM_types.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[200];

static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[200];

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *x,
                                 const char_T *identifier))[200];

static const mxArray *emlrt_marshallOut(const emlrtStack *sp,
                                        const cell_wrap_0 u[100]);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[200]
{
  real_T(*y)[200];
  y = c_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[200]
{
  static const int32_T dims[2] = {100, 2};
  real_T(*ret)[200];
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 2U, (void *)&dims[0]);
  ret = (real_T(*)[200])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *x,
                                 const char_T *identifier))[200]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[200];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(x), &thisId);
  emlrtDestroyArray(&x);
  return y;
}

static const mxArray *emlrt_marshallOut(const emlrtStack *sp,
                                        const cell_wrap_0 u[100])
{
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  int32_T iv[2];
  int32_T i;
  y = NULL;
  i = 100;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(1, &i));
  iv[0] = 1;
  for (i = 0; i < 100; i++) {
    b_y = NULL;
    iv[1] = u[i].f1.size[1];
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a((emlrtCTX)sp, u[i].f1.size[1], m,
                             &u[i].f1.data[0]);
    emlrtAssign(&b_y, m);
    emlrtSetCell(y, i, b_y);
  }
  return y;
}

void predictLabelsSVM_api(const mxArray *prhs, const mxArray **plhs)
{
  cell_wrap_0 label[100];
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  real_T(*x)[200];
  st.tls = emlrtRootTLSGlobal;
  /* Marshall function inputs */
  x = emlrt_marshallIn(&st, emlrtAlias(prhs), "x");
  /* Invoke the target function */
  predictLabelsSVM(&st, *x, label);
  /* Marshall function outputs */
  *plhs = emlrt_marshallOut(&st, label);
}

/* End of code generation (_coder_predictLabelsSVM_api.c) */
