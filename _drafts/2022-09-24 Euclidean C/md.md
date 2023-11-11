[Generate C Code at the Command Line - MATLAB & Simulink - MathWorks China](https://ww2.mathworks.cn/help/coder/gs/generating-c-code-from-matlab-code-at-the-command-line.html)









## Create and Test a Function in MATLAB

首先，建立一个`euclidean`函数：

```matlab
function [y_min, y_max, idx, distance] = euclidean(x, cb)
%   Copyright 2018 The MathWorks, Inc.

% Initialize minimum distance as distance to first element of cb
% Initialize maximum distance as distance to first element of cb
idx(1)=1;
idx(2)=1;

distance(1)=norm(x-cb(:,1));
distance(2)=norm(x-cb(:,1));

% Find the vector in cb with minimum distance to x
% Find the vector in cb with maximum distance to x
for index = 2:size(cb, 2)
    d = norm(x-cb(:, index));
    if d < distance(1)
        distance(1) = d;
        idx(1) = index;
    end
    if d > distance(2)
        distance(2) = d;
        idx(2) = index;
    end
end

% Output the minimum and maximum distance vectors
y_min=cb(:, idx(1));
y_max=cb(:, idx(2));
end
```

该函数计算寻找矩阵`cb`中到中心点`x`距离最大和最小的点，并保存。其中：

- `y_min`和`y_max`保存`cb`中距离最小和距离最大的点的位置；
- `idx`是一个二维向量，`idx(1)`表示`cb`中距离`x`最小的点的列坐标，`idx(2)`表示`cb`中距离`x`最大的点的列坐标。
- `distance`也是一个二维向量，分别保存最大的距离值。

`euclidean_data.mat`文件中保存着这样的一个矩阵`cb`和中心点`x`：

```matlab
Name      Size             Bytes  Class     Attributes
  cb        3x216             5184  double              
  x         3x1                 24  double
```

以供我们测试`euclidean`函数：

```matlab
clc, clear, close all

% Load test data 
load euclidean_data.mat

% Determine closest and farthest points and corresponding distances
[y_min, y_max, idx, distance] = euclidean(x, cb);

% Display output for the closest point
disp('Coordinates of the closest point are: ');
disp(num2str(y_min'));
disp(['Index of the closest point is ', num2str(idx(1))]);
disp(['Distance to the closest point is ', num2str(distance(1))]);

disp(newline);

% Display output for the farthest point
disp('Coordinates of the farthest point are: ');
disp(num2str(y_max'));
disp(['Index of the farthest point is ', num2str(idx(2))]);
disp(['Distance to the farthest point is ', num2str(distance(2))]);
```

结果：

```
Coordinates of the closest point are: 
0.8         0.8         0.4
Index of the closest point is 171
Distance to the closest point is 0.080374

Coordinates of the farthest point are: 
0  0  1
Index of the farthest point is 6
Distance to the farthest point is 1.2923
```

以上是在三维空间中进行计算。该函数同样可以在二维空间中进行计算。测试函数：

```matlab
clc, clear, close all
% Load the test data
load euclidean_data.mat

% Create 2-D versions of x and cb
x2d=x(1:2, :);
cb2d=cb(1:2,1:6:216);

% Determine closest and farthest points and corresponding distances
[y_min, y_max, idx, distance] = euclidean(x2d, cb2d);

% Display output for the closest point
disp('Coordinates of the closest point are: ');
disp(num2str(y_min'));
disp(['Index of the closest point is ', num2str(idx(1))]);
disp(['Distance to the closest point is ', num2str(distance(1))]);

disp(newline);

% Display output for the farthest point
disp('Coordinates of the farthest point are: ');
disp(num2str(y_max'));
disp(['Index of the farthest point is ', num2str(idx(2))]);
disp(['Distance to the farthest point is ', num2str(distance(2))]);
```

```matlab
Coordinates of the closest point are: 
0.8         0.8
Index of the closest point is 29
Distance to the closest point is 0.078672


Coordinates of the farthest point are: 
0  0
Index of the farthest point is 1
Distance to the farthest point is 1.1357
```

## Generate C Code for the MATLAB Function

### Make the MATLAB Code Suitable for Code Generation

在输入MATLAB代码时，软件会一直运行着Code Analyzer，查看代码是否有问题，如果没有检测到问题，就会在右上角有一个小对号：

![image-20220924183415096](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924183415096.png)

但是如果想要使这些代码适用于Code Generation，需要在函数声明的后面添加一个注释`%#codegen`：

![image-20220924183636645](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924183636645.png)

注释`%#codegen`使Code Analyzer识别一些专门针对code generation的warnings和errors。

所有的这些warning都是同一种类型：

![image-20220924183922113](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924183922113.png)

表示这些变量在使用它们之前，必须首先进行定义。之所以出现这种warnings，是因为code generator需要根据这些变量的大小来分配内存。因此，我们需要借助于`ones`函数同时分配和初始化这些数组：

```matlab
% Initialize minimum distance as distance to first element of cb
% Initialize maximum distance as distance to first element of cb
idx = ones(1,2);

distance = ones(1,2)*norm(x-cb(:,1));
```

![image-20220924184303332](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924184303332.png)

可以看到，此时就没有warnings了。

### Open the MATLAB Coder App and Select Source Filse

之后，就打开MATLAB Coder APP：

![image-20220924184517598](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924184517598.png)

选择`euclidean`函数作为Entry-Point Function：

![image-20220924184621962](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924184621962.png)

An **entry-point function** is a top-level MATLAB function from which you generate code. APP会在当前文件夹创建一个`euclidean.prj`项目。

之后，点击Next按钮，进入到Define Input Types步骤：

![image-20220924184917823](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924184917823.png)

APP会运行Code Analyzer（我们在上一步骤中已经做过了）和Code Generation Readiness Tool来扫描entry-point function。Code Generation Readiness Tool会列出code generation不支持的特性和函数。如果App发现了问题，它就会打开Review Code Generation Readiness页面，我们可以在那里面看到问题报告，并修复问题。在这个例子中，由于App没有监测到问题，就直接打开了Define Input Types页面。
{: .notice--primary}

MATLAB中的一些自建函数和工具箱函数、类、系统对象不支持code generation。这些限制和相关的使用说明，详见[Functions and Objects Supported for C/C++ Code Generation](https://ww2.mathworks.cn/help/coder/ug/functions-and-objects-supported-for-cc-code-generation.html)。
{: .notice--primary}

之后，我们就需要定义Input Types。由于C语言使用static typing，因此在code generation time（AKA compile time），code generator必须定义所有变量的class，size和complexity。我们必须指定entry-point function输入的所有性质，可以使用以下方式：

- Instruct the app to automatically determine input properties by providing a script that calls the entry-point functions with sample inputs.
- Specify properties directly.

在本例中，我们可以选用第一种方式，指定之前的测试文件让App自动定义所有输入的属性：

![image-20220924190152674](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924190152674.png)

点击`Autodefine Input Types`按钮：

![image-20220924190235115](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924190235115.png)

之后点击`Next`按钮，进入到Check for Run-Time Issues步骤。

### Check for Run-Time Issues

![image-20220924190337863](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924190337863.png)

Check for Run-Time Issues步骤会基于entry-point functions生成一个`.mex`文件，运行该`.mex`文件并且报告问题。生成的MEX函数文件可以在MATLAB中直接调用，基于`.mex`函数文件检查和修复在生成的C代码中难以察觉的错误是一种很好的方式。

打开Check for Run-Time Issues对话框，选中一个调用entry-point function的测试文件（这里是`script1_testIn3D`），之后点击`Check for Issues`：

![image-20220924224623116](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924224623116.png)

在本例中，没有发现问题。

在默认情况下，App会收集执行次数。这些技术会帮助开发者了解测试文件使用`euclidean`函数的效果。为了查看行执行次数，点击`View MATLAB line execution counts`：

![image-20220924224951118](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924224951118.png)

把鼠标放在左侧的绿色条上，就可以看到行执行次数：

![image-20220924225356476](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924225356476.png)

点击`Next`按钮来到Generate Code步骤。

在生成独立的C/C++代码前，首先需要生成MEX function，之后运行生成的MEX function，确保和MATLAB函数有一样的效果。如果生成的MEX function的表现和MATLAB函数有所差异，或者产生了错误，就必须修正这些错误。否则，后面生成的代码可能是不可靠的，或者会有一些未定义的行为。
{: notice--primary}

### Generate C Code

![image-20220924225805647](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924225805647.png)

在Generate对话框中，设置Build type为Static Library（.lib），语言为C语言，其他使用默认值，之后点击`Generate`按钮：

![image-20220924230057632](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924230057632.png)

生成成功：

![image-20220924230118418](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924230118418.png)

此时，MATLAB Coder生成了一个standalone C static library `euclidean`，保存在`.\codegen\lib\euclidean`中。同样，在App页面的左侧也展示了source MATLAB files和generated output files：

![image-20220924230637968](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924230637968.png)

之后，点击Next来到Finish Workflow步骤。

### Review the Finish Workflow Page

![image-20220924230810144](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220924230810144.png)

这里展示了C语言保存的位置，和Example main Files和Reports所在的位置。

### Compare the Generated C Code to Original MATLAB Code

为了比较生成的C代码和原始的MATLAB代码，打开C语言文件`euclidean.c`和MATLAB文件`euclidean.m`。可以看到`euclidean.c`的主体部分：

```C
/* Function Definitions */
/*
 * Copyright 2018 The MathWorks, Inc.
 *
 * Arguments    : const double x[3]
 *                const double cb[648]
 *                double y_min[3]
 *                double y_max[3]
 *                double idx[2]
 *                double distance[2]
 * Return Type  : void
 */
void euclidean(const double x[3], const double cb[648], double y_min[3],
               double y_max[3], double idx[2], double distance[2])
{
  double absxk;
  double d;
  double d1;
  double d2;
  double d3;
  double d4;
  double scale;
  double t;
  int absxk_tmp;
  int b_index;
  /*  Initialize minimum distance as distance to first element of cb */
  /*  Initialize maximum distance as distance to first element of cb */
  /*  Initialize minimum distance as distance to first element of cb */
  /*  Initialize maximum distance as distance to first element of cb */
  idx[0] = 1.0;
  idx[1] = 1.0;
  scale = 3.3121686421112381E-170;
  absxk = fabs(x[0] - cb[0]);
  if (absxk > 3.3121686421112381E-170) {
    d = 1.0;
    scale = absxk;
  } else {
    t = absxk / 3.3121686421112381E-170;
    d = t * t;
  }
  absxk = fabs(x[1] - cb[1]);
  if (absxk > scale) {
    t = scale / absxk;
    d = d * t * t + 1.0;
    scale = absxk;
  } else {
    t = absxk / scale;
    d += t * t;
  }
  absxk = fabs(x[2] - cb[2]);
  if (absxk > scale) {
    t = scale / absxk;
    d = d * t * t + 1.0;
    scale = absxk;
  } else {
    t = absxk / scale;
    d += t * t;
  }
  d = scale * sqrt(d);
  /*  Find the vector in cb with minimum distance to x */
  /*  Find the vector in cb with maximum distance to x */
  d1 = x[0];
  d2 = x[1];
  d3 = x[2];
  d4 = d;
  for (b_index = 0; b_index < 215; b_index++) {
    double b_d;
    scale = 3.3121686421112381E-170;
    absxk_tmp = 3 * (b_index + 1);
    absxk = fabs(d1 - cb[absxk_tmp]);
    if (absxk > 3.3121686421112381E-170) {
      b_d = 1.0;
      scale = absxk;
    } else {
      t = absxk / 3.3121686421112381E-170;
      b_d = t * t;
    }
    absxk = fabs(d2 - cb[absxk_tmp + 1]);
    if (absxk > scale) {
      t = scale / absxk;
      b_d = b_d * t * t + 1.0;
      scale = absxk;
    } else {
      t = absxk / scale;
      b_d += t * t;
    }
    absxk = fabs(d3 - cb[absxk_tmp + 2]);
    if (absxk > scale) {
      t = scale / absxk;
      b_d = b_d * t * t + 1.0;
      scale = absxk;
    } else {
      t = absxk / scale;
      b_d += t * t;
    }
    b_d = scale * sqrt(b_d);
    if (b_d < d) {
      d = b_d;
      idx[0] = (double)b_index + 2.0;
    }
    if (b_d > d4) {
      d4 = b_d;
      idx[1] = (double)b_index + 2.0;
    }
  }
  distance[1] = d4;
  distance[0] = d;
  /*  Output the minimum and maximum distance vectors */
  b_index = 3 * ((int)idx[0] - 1);
  y_min[0] = cb[b_index];
  absxk_tmp = 3 * ((int)idx[1] - 1);
  y_max[0] = cb[absxk_tmp];
  y_min[1] = cb[b_index + 1];
  y_max[1] = cb[absxk_tmp + 1];
  y_min[2] = cb[b_index + 2];
  y_max[2] = cb[absxk_tmp + 2];
}

/*
 * File trailer for euclidean.c
 *
 * [EOF]
 */
```

由于我们是根据一个调用例子让MATLAB自动设置Input types，因此：

- `const double x[3]`对应MATLAB code中的输入`x`。`x`的大小为3，因此对应着total size是(3x1)；
- `const double cb[648]`对应MATLAB中的输入`cb`。`cb`的大小是648，对应着(3x216)。在这个例子中，生成的代码使用一维数组来表示MATLAB中的二维数组；
- 生成的代码有四个额外的输入参数：`y_min`，`y_max`，`idx`和`distance`。这些数组用于返回输出值。它们对应MATLAB代码中的`y_min`，`y_max`，`idx`和`distance`。

## Generate C Code for Variable-size

上面的C语言函数只能接受和用于在code generation时指定的例子相同大小的输入。但是，MATLAB函数时可以输入任何大小的数组的。假设我们想要生成的C代码的`x`和`cb`的维度有以下的性质：

- The first dimension of both `x` and `cb` can vary in size up to 3.

- The second dimension of `x` is fixed and has the value 1.

- The second dimension of `cb` can vary in size up to 216.

为了设置这些属性，需要在Define Input Types阶段导入调用示例文件后，修改变量大小：

![image-20220925003621071](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220925003621071.png)

其中，`:3` implies that the corresponding dimension can vary in size up to 3。之后进行后续步骤，生成的C代码中可以看到：

```c
void euclidean(const double x_data[], const int x_size[1],
               const double cb_data[], const int cb_size[2],
               double y_min_data[], int y_min_size[1], double y_max_data[],
               int y_max_size[1], double idx[2], double distance[2])
```

此时，C函数接收另外四个额外的输入参数：`x_size`，`cb_size`和`y_min_size`和`y_max_size`，在运行时分别指定了`x_data`，`cb_data`，`y_min_data`和`y_max_data`的大小。

## Usage of C Code

在`.\codegen\lib\euclidean\examples`中可以看到一个`main.c`的文件，这里面保存了C函数的调用示例。

首先看它的注释部分：

```c
/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: main.c
 *
 * MATLAB Coder version            : 5.4
 * C/C++ source code generated on  : 25-Sep-2022 00:36:09
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
```

该注释表明了这个文件是用于说明如何调用MATLAB Coder生成的entry-point function，并且提醒不要直接在这个文件上进行修改，复制一份再修改。





**References**

[1] [Generate C Code by Using the MATLAB Coder App - MathWorks](https://ww2.mathworks.cn/help/coder/gs/generating-c-code-from-matlab-code-using-the-matlab-coder-project-interface.html).

