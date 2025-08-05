---
title: MATLAB `inputname` Function --- Get variable name of function input
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Programming
date: 2025-08-04 12:52:33 +0800
last_modified_at: 2025-08-04 15:17:51 +0800
---

MATLAB `inputname` function is to return variable names of function input, and here is an example from the official documentation[^1]:

```matlab
function getname2(a, b, c) %#ok
for m = 1:nargin
    disp(['Calling variable ' num2str(m) ' is ''' inputname(m) '''.'])
end
```

```matlab
clc, clear, close all

x = {'hello', 'goodbye'};
y = struct('a', 42, 'b', 78);
z = rand(4);

getname2(x, y, z)
fprintf("\n")

getname2(1, 2, 3)
fprintf("\n")
% Call the function using values instead of variables.
% The inputname function returns an empty char array because its input does not have a name.

getname2(x, y.a, z)
fprintf("\n")
% Call the function using a field of y.
% Because the input argument contains dot indexing,
% the inputname function returns an empty char array for the second variable name and all subsequent variable names.

getname2(x{2}, y, z)
fprintf("\n")
% Call the function using the second cell of x.
% Because the input argument contains cell indexing,
% the inputname function returns an empty char array for the first variable name and all subsequent variable names.
```

```
Calling variable 1 is 'x'.
Calling variable 2 is 'y'.
Calling variable 3 is 'z'.

Calling variable 1 is ''.
Calling variable 2 is ''.
Calling variable 3 is ''.

Calling variable 1 is 'x'.
Calling variable 2 is ''.
Calling variable 3 is ''.

Calling variable 1 is ''.
Calling variable 2 is ''.
Calling variable 3 is ''.
```

<br>

**References**

[^1]: [MATLAB `inputname`: Variable name of function input](https://www.mathworks.com/help/matlab/ref/inputname.html).