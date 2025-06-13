---
title: MATLAB Functions `all` and `any`
categories:
 - MATLAB
tags:
 - MATLAB Language Fundamentals
date: 2025-06-13 14:59:53 +0800
last_modified_at: 2025-06-13 14:59:53 +0800
---

# MATLAB `all` function

For MATLAB `all` function[^1], along the specified dimension of the input matrix `A`:

- if all elements are non-zero (so-called “<i class="emphasize">all</i> non-zero”), then `all(A)` is `1`;
- if there is at least one zero, then `all(A)` is `0`.

Here is an example:

```matlab
clc, clear, close all
rng("default")

A = randn(5,7);
A(:, 3:4) = 0;
A(3, :) = 0;

B = A;
B(3, :) = randn(1, width(A));

A

all(A)
all(A, 2)
all(A, "all")

B

all(B)
all(B, 2)
all(B, "all")
```

```
A =
    0.5377   -1.3077         0         0    0.6715    1.0347    0.8884
    1.8339   -0.4336         0         0   -1.2075    0.7269   -1.1471
         0         0         0         0         0         0         0
    0.8622    3.5784         0         0    1.6302    0.2939   -0.8095
    0.3188    2.7694         0         0    0.4889   -0.7873   -2.9443

ans =
  1×7 logical array
   0   0   0   0   0   0   0

ans =
  5×1 logical array
   0
   0
   0
   0
   0

ans =
  logical
   0

B =
    0.5377   -1.3077         0         0    0.6715    1.0347    0.8884
    1.8339   -0.4336         0         0   -1.2075    0.7269   -1.1471
    1.4384    0.3252   -0.7549    1.3703   -1.7115   -0.1022   -0.2414
    0.8622    3.5784         0         0    1.6302    0.2939   -0.8095
    0.3188    2.7694         0         0    0.4889   -0.7873   -2.9443
    
ans =
  1×7 logical array
   1   1   0   0   1   1   1

ans =
  5×1 logical array
   0
   0
   1
   0
   0

ans =
  logical
   0
```

<br>

# MATLAB `any` function

For MATLAB `any` function[^2], along the specified dimension of the input matrix `A`:

- if there is at least one non-zero (so-called “<i class="emphasize">any</i> non-zero”), then `any(A)` is `1`;
- if all elements are zero, then `any(A)` is `0`;

Here is an example:

```matlab
clc, clear, close all
rng("default")

A = randn(5,7);
A(:, 3:4) = 0;
A(3, :) = 0;

B = A;
B(3, :) = randn(1, width(A));

A

any(A)
any(A, 2)
any(A, "all")

B

any(B)
any(B, 2)
any(B, "all")
```

```
A =
    0.5377   -1.3077         0         0    0.6715    1.0347    0.8884
    1.8339   -0.4336         0         0   -1.2075    0.7269   -1.1471
         0         0         0         0         0         0         0
    0.8622    3.5784         0         0    1.6302    0.2939   -0.8095
    0.3188    2.7694         0         0    0.4889   -0.7873   -2.9443

ans =
  1×7 logical array
   1   1   0   0   1   1   1

ans =
  5×1 logical array
   1
   1
   0
   1
   1

ans =
  logical
   1

B =
    0.5377   -1.3077         0         0    0.6715    1.0347    0.8884
    1.8339   -0.4336         0         0   -1.2075    0.7269   -1.1471
    1.4384    0.3252   -0.7549    1.3703   -1.7115   -0.1022   -0.2414
    0.8622    3.5784         0         0    1.6302    0.2939   -0.8095
    0.3188    2.7694         0         0    0.4889   -0.7873   -2.9443

ans =
  1×7 logical array
   1   1   1   1   1   1   1

ans =
  5×1 logical array
   1
   1
   1
   1
   1

ans =
  logical
   1
```

<br>

**References**

- [Logical (Boolean) Operations](https://www.mathworks.com/help/matlab/logical-operations.html?s_tid=CRUX_lftnav).

[^1]: [MATLAB `all`: Determine if all array elements are nonzero or true](https://www.mathworks.com/help/matlab/ref/all.html).
[^2]: [MATLAB `any`: Determine if any array elements are nonzero](https://www.mathworks.com/help/matlab/ref/any.html).