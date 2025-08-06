---
title: Transform A Warning into An Error in MATLAB --- Make warnings interrupt the running script like errors
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Programming
 - MATLAB Warnings and Errors
date: 2025-07-19 17:06:33 +0800
last_modified_at: 2025-08-06 11:54:25 +0800
---

When encountering errors, MATLAB will interrupt the running script and throw error message. When encountering warnings, however, MATLAB will only display warning message on the command window, but not interrupt the running script. For example, if we try to inverse a non-invertible matrix, we can see a warning, “Matrix is singular to working precision”, and MATLAB will still execute the subsequent code:

```matlab
clc, clear, close all

a = [0, 0, 0; 1, 2, 3; 4, 5, 6];

b = inv(a)

c = b+1
```

```
Warning: Matrix is singular to working precision. 
> In script1 (line 5)

b =
   Inf   Inf   Inf
   Inf   Inf   Inf
   Inf   Inf   Inf

c =
   Inf   Inf   Inf
   Inf   Inf   Inf
   Inf   Inf   Inf
```

Sometimes, the default behavior that warnings don’t interrupt the running script may disturb us when we debug the code --- we may hope that warnings, like errors, will also interrupt the code running. To this end, we can utilize the `warning` function[^1]. Similarly take the above example:

```matlab
clc, clear, close all

warning('error', 'MATLAB:singularMatrix')

a = [0, 0, 0; 1, 2, 3; 4, 5, 6];

b = inv(a)

c = b+1
```

then we’ll have:

```
Error using inv
Matrix is singular to working precision.

Error in script1 (line 7)
b = inv(a)
```

<div class="notice--primary" markdown="1">

What’s more, at this time we can use `try-catch` block[^4] to catch this error:

```matlab
clc, clear, close all

warning('error', 'MATLAB:singularMatrix')

a = [0, 0, 0; 1, 2, 3; 4, 5, 6];

try
    b = inv(a)
catch ME
    ME
end
```

```
ME = 
  MException with properties:

    identifier: 'MATLAB:singularMatrix'
       message: 'Matrix is singular to working precision.'
         cause: {}
         stack: [1×1 struct]
    Correction: []
```

</div>

It can be seen at this time, we can’t get the value of `b` and `c`, because we have transformed the warning `MATLAB:singularMatrix` into an error using the `warning` function (To reset it as a warning, we can use the code `warning('on', 'MATLAB:singularMatrix')`.)

By the way, the `warning` documentation[^1] doesn’t mention this point, and I found it on the Undocumented MATLAB[^2][^3].

In the above example, `'MATLAB:singularMatrix'` is a warning ID and is very important in this process. So, how obtain it? There are two ways.

(1) The first one is using `warning('on', 'verbose')`[^2]:

```matlab
clc, clear, close all

warning('on', 'verbose')

a = [0, 0, 0; 1, 2, 3; 4, 5, 6];

inv(a)
```

```
Warning: Matrix is singular to working precision.
(Type "warning off MATLAB:singularMatrix" to suppress this warning.)
 
> In script1 (line 7)
 
ans =
   Inf   Inf   Inf
   Inf   Inf   Inf
   Inf   Inf   Inf
```

After getting the warning ID, we can use `warning('off', 'verbose')` to reset the default setting. (“By default, the state of verbosity is set to `'off'` and the state of stack trace display is set to `'on'`.”[^1])

(2) The second one is using the `lastwarn` function[^5]:

```matlab
clc, clear, close all

a = [0, 0, 0; 1, 2, 3; 4, 5, 6];

inv(a)

[msg, warnID] = lastwarn
```

```
Warning: Matrix is singular to working precision. 

ans =
   Inf   Inf   Inf
   Inf   Inf   Inf
   Inf   Inf   Inf

msg =
    'Matrix is singular to working precision.'

warnID =
    'MATLAB:singularMatrix'
```

where the variable `warnID` is what we expect. I prefer this method.

<br>

**References**

[^1]: [MATLAB `warning`: Display warning message](https://www.mathworks.com/help/matlab/ref/warning.html).
[^2]: [Trapping warnings efficiently](https://undocumentedmatlab.com/articles/trapping-warnings-efficiently).
[^3]: [How to catch warnings?](https://www.mathworks.com/matlabcentral/answers/419823-how-to-catch-warnings).
[^4]: [MATLAB `try-catch` Block](/2023-01-12/16-12-03.html).
[^5]: [MATLAB `lastwarn`: Last warning message](https://www.mathworks.com/help/matlab/ref/lastwarn.html).
