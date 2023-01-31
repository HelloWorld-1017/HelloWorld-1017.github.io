/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_euclidean_api.c
 *
 * MATLAB Coder version            : 5.4
 * C/C++ source code generated on  : 25-Sep-2022 00:36:09
 */

/* Include Files */
#include "_coder_euclidean_api.h"
#include "_coder_euclidean_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;

emlrtContext emlrtContextGlobal = {
    true,                                                 /* bFirstTime */
    false,                                                /* bInitialized */
    131626U,                                              /* fVersionInfo */
    NULL,                                                 /* fErrorFunction */
    "euclidean",                                          /* fFunctionName */
    NULL,                                                 /* fRTCallStack */
    false,                                                /* bDebugMode */
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, /* fSigWrd */
    NULL                                                  /* fSigMem */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T **y_data, int32_T *y_size);

static const mxArray *b_emlrt_marshallOut(const real_T u[2]);

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *cb,
                               const char_T *identifier, real_T **y_data,
                               int32_T y_size[2]);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T **y_data, int32_T y_size[2]);

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T **ret_data, int32_T *ret_size);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *x,
                             const char_T *identifier, real_T **y_data,
                             int32_T *y_size);

static const mxArray *emlrt_marshallOut(const real_T u_data[],
                                        const int32_T *u_size);

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T **ret_data, int32_T ret_size[2]);

/* Function Definitions */
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T **y_data
 *                int32_T *y_size
 * Return Type  : void
 */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T **y_data, int32_T *y_size)
{
  real_T *r;
  int32_T i;
  e_emlrt_marshallIn(sp, emlrtAlias(u), parentId, &r, &i);
  *y_size = i;
  *y_data = r;
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const real_T u[2]
 * Return Type  : const mxArray *
 */
static const mxArray *b_emlrt_marshallOut(const real_T u[2])
{
  static const int32_T iv[2] = {0, 0};
  static const int32_T iv1[2] = {1, 2};
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m, &iv1[0], 2);
  emlrtAssign(&y, m);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *cb
 *                const char_T *identifier
 *                real_T **y_data
 *                int32_T y_size[2]
 * Return Type  : void
 */
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *cb,
                               const char_T *identifier, real_T **y_data,
                               int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  real_T *r;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(cb), &thisId, &r, y_size);
  *y_data = r;
  emlrtDestroyArray(&cb);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T **y_data
 *                int32_T y_size[2]
 * Return Type  : void
 */
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T **y_data, int32_T y_size[2])
{
  real_T *r;
  f_emlrt_marshallIn(sp, emlrtAlias(u), parentId, &r, y_size);
  *y_data = r;
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T **ret_data
 *                int32_T *ret_size
 * Return Type  : void
 */
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T **ret_data, int32_T *ret_size)
{
  static const int32_T dims = 3;
  const boolean_T b = true;
  emlrtCheckVsBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                            false, 1U, (void *)&dims, &b, ret_size);
  *ret_data = (real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *x
 *                const char_T *identifier
 *                real_T **y_data
 *                int32_T *y_size
 * Return Type  : void
 */
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *x,
                             const char_T *identifier, real_T **y_data,
                             int32_T *y_size)
{
  emlrtMsgIdentifier thisId;
  real_T *r;
  int32_T i;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(x), &thisId, &r, &i);
  *y_size = i;
  *y_data = r;
  emlrtDestroyArray(&x);
}

/*
 * Arguments    : const real_T u_data[]
 *                const int32_T *u_size
 * Return Type  : const mxArray *
 */
static const mxArray *emlrt_marshallOut(const real_T u_data[],
                                        const int32_T *u_size)
{
  static const int32_T i = 0;
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateNumericArray(1, (const void *)&i, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m, u_size, 1);
  emlrtAssign(&y, m);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T **ret_data
 *                int32_T ret_size[2]
 * Return Type  : void
 */
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T **ret_data, int32_T ret_size[2])
{
  static const int32_T dims[2] = {3, 216};
  int32_T iv[2];
  const boolean_T bv[2] = {true, false};
  emlrtCheckVsBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                            false, 2U, (void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  *ret_data = (real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const mxArray * const prhs[2]
 *                int32_T nlhs
 *                const mxArray *plhs[4]
 * Return Type  : void
 */
void euclidean_api(const mxArray *const prhs[2], int32_T nlhs,
                   const mxArray *plhs[4])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  real_T(*cb_data)[648];
  real_T(*x_data)[3];
  real_T(*y_max_data)[3];
  real_T(*y_min_data)[3];
  real_T(*distance)[2];
  real_T(*idx)[2];
  int32_T cb_size[2];
  int32_T x_size;
  int32_T y_max_size;
  int32_T y_min_size;
  st.tls = emlrtRootTLSGlobal;
  y_min_data = (real_T(*)[3])mxMalloc(sizeof(real_T[3]));
  y_max_data = (real_T(*)[3])mxMalloc(sizeof(real_T[3]));
  idx = (real_T(*)[2])mxMalloc(sizeof(real_T[2]));
  distance = (real_T(*)[2])mxMalloc(sizeof(real_T[2]));
  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "x", (real_T **)&x_data, &x_size);
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "cb", (real_T **)&cb_data,
                     cb_size);
  /* Invoke the target function */
  euclidean(*x_data, *(int32_T(*)[1]) & x_size, *cb_data, cb_size, *y_min_data,
            *(int32_T(*)[1]) & y_min_size, *y_max_data,
            *(int32_T(*)[1]) & y_max_size, *idx, *distance);
  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*y_min_data, &y_min_size);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(*y_max_data, &y_max_size);
  }
  if (nlhs > 2) {
    plhs[2] = b_emlrt_marshallOut(*idx);
  }
  if (nlhs > 3) {
    plhs[3] = b_emlrt_marshallOut(*distance);
  }
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void euclidean_atexit(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  euclidean_xil_terminate();
  euclidean_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void euclidean_initialize(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void euclidean_terminate(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * File trailer for _coder_euclidean_api.c
 *
 * [EOF]
 */
