---
title: Tolerance and Max-Epoch Settings May Affect Optimization Results *A Lot*
toc: false
categories:
 - Mathematics
tags:
 - Optimization
location: Buffalo, United States
date: 2025-11-26 03:02:38 -0500
last_modified_at: 2025-11-28 16:00:34 -0500
---

When solving optimization problems, in practice we usually need to specify a stopping condition, and specifying a sufficiently small tolerance (or threshold), like $10^{-6}$, $10^{-7}$, or $10^{-9}$ etc., may be the most common method --- at the end of each iteration, we compute the error $\boldsymbol{x}^{(k)}-\boldsymbol{x}^{(k-1)}$, and stop the iteration as long as its value is less than or equal to the prescribed tolerance. However, it should be noted that, sometimes, the tolerance setting will affect the final results *a lot*, especially when we conduct a series of optimizations where the initial points of current optimization are determined by the results of previous one. In this case, different tolerance settings will result in small difference at the beginning, and this difference will gradually accumulate, finally producing very different results.

For the same reason, max-epoch setting should be concerned similarly.