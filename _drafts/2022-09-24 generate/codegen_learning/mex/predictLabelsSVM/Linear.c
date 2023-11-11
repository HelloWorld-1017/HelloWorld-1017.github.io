/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Linear.c
 *
 * Code generation for function 'Linear'
 *
 */

/* Include files */
#include "Linear.h"
#include "rt_nonfinite.h"
#include "blas.h"
#include <stddef.h>

/* Function Definitions */
void Linear(const real_T svT[48], const real_T x[200],
            real_T kernelProduct[2400])
{
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  real_T alpha1;
  real_T beta1;
  char_T TRANSA1;
  char_T TRANSB1;
  TRANSB1 = 'N';
  TRANSA1 = 'N';
  alpha1 = 1.0;
  beta1 = 0.0;
  m_t = (ptrdiff_t)100;
  n_t = (ptrdiff_t)24;
  k_t = (ptrdiff_t)2;
  lda_t = (ptrdiff_t)100;
  ldb_t = (ptrdiff_t)2;
  ldc_t = (ptrdiff_t)100;
  dgemm(&TRANSA1, &TRANSB1, &m_t, &n_t, &k_t, &alpha1, &x[0], &lda_t, &svT[0],
        &ldb_t, &beta1, &kernelProduct[0], &ldc_t);
}

/* End of code generation (Linear.c) */
