---
layout: single
title: Accelerate MATLAB Algorithm by Generating MEX Function
date: 2023-05-01 14:31:33 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Coder
---

# Introduction

在MATLAB中，我们可以将一些编写好的函数转换为MEX函数文件，之后在调用函数的时候，可以直接调用MEX文件形式的函数，这样做可以加快代码的运行速度。MATLAB官方给出了一个将计算欧式距离的函数`euclidean`转换为MEX文件的示例 [1]，本博客就记录一下对于这个示例的学习。


## MATLAB data file: `euclidean_data.mat`

数据文件`euclidean_data.mat`保存着矩阵`cb`和中心点`x`：

```
  Name      Size             Bytes  Class     Attributes
  cb        3x216             5184  double              
  x         3x1                 24  double              
```

其中：

- 变量`cb`保存着216个点的三维坐标；
- 变量`x`保存着一个点的三维坐标；

##  `euclidean.m` function

`euclidean`函数的定义如下：

```matlab
function [y_min,y_max,idx,distance] = euclidean(x,cb)
%EUCLIDEAN  Calculates the minimum and maximum euclidean distance between a 
%           point and a set of other points.
%   [Y_MIN, Y_MAX, IDX, DISTANCE] = EUCLIDEAN(X,CB) computes the euclidean 
%   distance between X and every column of CB. X is an M-by-1 vector and CB 
%   is an M-by-N matrix. Y_MIN and Y_MAX are M-by-1 vectors that are equal  
%   to the columns of CB that have the minimum and the maximun distances to 
%   X, respectively. IDX is a 2-dimensional vector that contains the column 
%   indices of Y_MIN and Y_MAX in CB. DISTANCE is a 2-dimensional vector 
%   that contains the minumum and maximum distances.
% 
%   Copyright 2018 The MathWorks, Inc.

% Initialize minimum distance as distance to first element of cb
% Initialize maximum distance as distance to first element of cb
idx(1)=1;
idx(2)=1;

distance(1)=norm(x-cb(:,1));
distance(2)=norm(x-cb(:,1));

% Find the vector in cb with minimum distance to x
% Find the vector in cb with maximum distance to x
for index=2:size(cb,2)
    d=norm(x-cb(:,index));
    if d < distance(1)
        distance(1)=d;
        idx(1)=index;
    end
    if d > distance(2)
        distance(2)=d;
        idx(2)=index;
    end
end

% Output the minimum and maximum distance vectors
y_min=cb(:,idx(1));
y_max=cb(:,idx(2));
end
```

该函数计算寻找矩阵`cb`中到中心点`x`距离最大和最小的点。其中：

- `y_min`和`y_max`保存`cb`中距离最小和距离最大的点的位置；
- `idx`是一个形状为`1x2`的向量，`idx(1)`表示`cb`中**当前**距离`x`最小的点的列索引，`idx(2)`表示`cb`中距离`x`最大的点的列索引。
- `distance`也是一个形状为`1x2`的向量，分别保存着`cb`中**当前**距离点`x`最小的距离值和最大的距离值；

## Test file: `test.m`

测试脚本`test.m`会加载`euclidean_data.mat`数据，测试`euclidean`函数：

```matlab
% Load test data 
load euclidean_data.mat

% Determine closest and farthest points and corresponding distances
[y_min,y_max,idx,distance] = euclidean(x,cb);

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

当我们运行测试函数后，会在命令行中显示距离最近的点和距离最远的点的信息（包括坐标，索引以及距离）：

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

<br>

# Preparations for Code Generation

我们可以使用Code Analyzer和Code Generation Readiness Tool这两个工具帮助检查编写的代码适用于code generation：

> The Code Analyzer in the MATLAB Editor continuously checks your code as you enter it. It reports issues and recommends modifications to maximize performance and maintainability. 
>
> The Code Generation Readiness Tool screens the MATLAB code for features and functions that are not supported for code generation.

另一方面需要注意的是，并不是所有的代码都能够进行code generation：

> Certain MATLAB built-in functions and toolbox functions, classes, and System objects that are supported for C/C++ code generation have specific code generation limitations. These limitations and related usage notes are listed in the **Extended Capabilities** sections of their corresponding reference pages. For more information, see [Functions and Objects Supported for C/C++ Code Generation](https://ww2.mathworks.cn/help/coder/ug/functions-and-objects-supported-for-cc-code-generation.html).

## Code Analyzer

在我们编写MATLAB代码时，软件会一直运行着Code Analyzer，检查代码是否有问题，如果没有检测到问题，就会在右上角有一个绿色的小对号：

![image-20230430200927498](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230430200927498.png?raw=true)

但是如果想要使Code Analyzer检查一些专门针对code generation的警告和错误，则还需要在函数声明的后面添加一个指令`%#codegen`：

![image-20230430201133200](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230430201133200.png?raw=true)

此时`euclidean`函数中所有的这些warning都是同一种类型：

![image-20230430201309842](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230430201309842.png?raw=true)

表示这些变量在使用它们之前，必须首先进行定义。之所以出现这种warnings，是因为code generator需要根据这些变量的大小来分配内存。因此，我们需要在最开始使用`ones`函数同时分配和初始化这些数组：

```matlab
% Initialize minimum distance as distance to first element of cb
% Initialize maximum distance as distance to first element of cb
idx = ones(1,2);
distance = ones(1,2)*norm(x-cb(:,1));
```

之后，Code Analyzer的警告就消失了：

![image-20230430201504827](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230430201504827.png?raw=true)

## Code Generation Readiness Tool

除此之外，我们还可以使用命令：

```matlab
coder.screener('euclidean')
```

来打开Code Generation Readiness Tool检查代码是否还有问题：

![image-20230430201752298](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230430201752298.png?raw=true)

<br>

# Code Generation

在检查完代码后，就可以使用`codege`命令来生成代码：

```matlab
% Load the test data
load euclidean_data.mat
% Generate code for euclidean.m with codegen. Use the test data as example 
% input. Validate MEX by using test.m.
codegen -report euclidean.m -args {x, cb} -test test
```

其中：

- 在默认情况下，`codegen`命令会在当前文件夹生成一个名为`euclidean_mex`函数；

- `-report`选项让`codegen`生成一份代码生成报告，我们可以根据该报告来调试代码生成的问题，并且验证我们所编写的MATLAB代码是否适合code generation；

- `-args`选项会指定entry-point function（入口函数）`euclidean`的样本输入参数（sample input parameters）`{x,cb}`。代码生成器会根据这些信息来确定输入参数的class，size和complexity；

  注：“这些信息”就是指变量`x`和`cb`。可以看到，在运行`codegen`前我们已经通过`load euclidean_data.mat`加载了`x`和`cb`。
  {: .notice--primary}

- `-test`选项会在生成代码后立即运行测试文件`test.m`以供用户查看效果。但是此时`test.m`中会调用`euclidean_mex`函数，而不是`euclidean`函数；

在运行完之后，命令行中会显示这样的信息：

```
Code generation successful: View report

Running test file: 'test'
with MEX function
'euclidean_mex'.
Coordinates of the closest point are: 
0.8         0.8         0.4
Index of the closest point is 171
Distance to the closest point is 0.080374

Coordinates of the farthest point are: 
0  0  1
Index of the farthest point is 6
Distance to the farthest point is 1.2923
```

并且会在当前文件夹中生成一个`euclidean_mex.mexw64`函数文件以及一个`codegen`文件夹，`codegen`文件夹中包含着代码生成的相关文件：

```
└─codegen
    │  tree.txt
    │  
    └─mex
        └─euclidean
            │  .gitignore
            │  build.ninja
            │  buildInfo.mat
            │  compile_commands.json
            │  euclidean.c
            │  euclidean.h
            │  euclidean_data.c
            │  euclidean_data.h
            │  euclidean_initialize.c
            │  euclidean_initialize.h
            │  euclidean_mex.bat
            │  euclidean_mex.exp
            │  euclidean_mex.lib
            │  euclidean_mex.mexw64
            │  euclidean_mex.mexw64.manifest
            │  euclidean_terminate.c
            │  euclidean_terminate.h
            │  euclidean_types.h
            │  rtwtypes.h
            │  rt_nonfinite.c
            │  rt_nonfinite.h
            │  SetEnv.bat
            │  _clang-format
            │  
            ├─build
            │  └─win64
            │          .ninja_log
            │          buildLog.log
            │          c_mexapi_version.obj
            │          euclidean.obj
            │          euclidean_data.obj
            │          euclidean_initialize.obj
            │          euclidean_terminate.obj
            │          rt_nonfinite.obj
            │          _coder_euclidean_api.obj
            │          _coder_euclidean_info.obj
            │          _coder_euclidean_mex.obj
            │          
            ├─html
            │      report.mldatx
            │      
            └─interface
                    _coder_euclidean_api.c
                    _coder_euclidean_api.h
                    _coder_euclidean_info.c
                    _coder_euclidean_info.h
                    _coder_euclidean_mex.c
                    _coder_euclidean_mex.h
```

对于这个示例，这些文件是没有什么作用的，删掉`codegen`文件夹不影响`euclidean_mex.mexw64`函数的调用。

<br>

# Call for MEX Function

## Call for `euclidean_mex.mexw64`

将`test.m`文件中调用函数的部分修改为：

```matlab
% Determine closest and farthest points and corresponding distances
[y_min,y_max,idx,distance] = euclidean_mex(x,cb);
```

就可以进行MEX函数文件的调用。

## Comparing Running Speeds of `euclidean.m` and `euclidean_mex.mexw64`

我们可以测试对比一下调用`euclidean_mex`函数和`euclidean_mex`函数的运行速度：

```matlab
clc,clear,close all

%% Call euclidean_mex.mexw64 function
load euclidean_data.mat
tic
for i = 1:1e7
    [y_min,y_max,idx,distance] = euclidean_mex(x,cb);
end
toc

%% Call euclidean.m function
clear all
load euclidean_data.mat
tic
for i = 1:1e7
    [y_min,y_max,idx,distance] = euclidean(x,cb);
end
toc
```

```
Elapsed time is 78.149608 seconds.
Elapsed time is 263.293473 seconds.
```

可以看到明显的速度差异。

<br>

# Generate MEX Function for Variable-Size Inputs

假如我们想用`euclidean_mex.mexw64`函数只根据前两维坐标来判断欧式距离的大小：

```matlab
clc,clear,close all
load euclidean_data.mat

% Create 2-D versions of x and cb
x2d=x(1:2,:);
cb2d=cb(1:2,:);

% Determine closest and farthest points and corresponding distances
[y_min,y_max,idx,distance] = euclidean_mex(x2d,cb2d);
```

结果程序会报错：

```
Error using euclidean_mex
Incorrect size for expression 'x': expected [3x1] but found [2x1].

Error in script3 (line 10)
[y_min,y_max,idx,distance] = euclidean_mex(x2d,cb2d);
```

再比如，我们仍然使用三维坐标，但是输入的给定点的数量小于216个，同样是不可以的：

```matlab
clc,clear,close all

load euclidean_data.mat
cb=cb(1:2,1:2:end);

% Determine closest and farthest points and corresponding distances
[y_min,y_max,idx,distance] = euclidean_mex(x,cb);
```

```
Error using euclidean_mex
Incorrect size for expression 'cb': expected [3x216] but found [2x108].

Error in script3 (line 8)
[y_min,y_max,idx,distance] = euclidean_mex(x,cb);
```

报错的原因都是输入参数的size不正确。之所以会出现这样的报错，是因为我们在上面使用`codegen`生成代码时给`-args`选项传入的是**“这些信息”**，因此最终生成的`euclidean_mex.mexw64`函数文件只能接受和**“这些信息”**的class和size完全一致的输入参数。

假如我们想要使得`euclidean_mex.mexw64`函数的适用性更强一些，例如使其能够包容如下所示的输入参数：

- The first dimension of both `x` and `cb` can vary in size **up to** `3`.（能够处理三维及以下维度的数据）
- The second dimension of `x` is fixed and has the value `1`.（只有一个中心点）
- The second dimension of `cb` can vary in size **up to** `216`.（给定点的数量不超过216个）

则可以使用`coder.typeof`函数 [2] 来指定输入的属性。代码`coder.typeof(A,B,1)`能够指定输入的class和complexity和变量`A`是一致的，并且这里的输入是variable-size input（由`coder.typeof(A,B,1)`的输入参数`1`指定），而输入大小的变化的上界由向量`B`对应位置的元素指定。

例如，实现上述的需求，我们可以这样指定`codegen`的`-args`选项：

```matlab
% Load the test data
load euclidean_data.mat

% Use coder.typeof to specify variable-size inputs
eg_x=coder.typeof(x,[3 1],1);
eg_cb=coder.typeof(cb,[3 216],1);

% Generate code for euclidean.m using coder.typeof to specify
% upper bounds for the example inputs
codegen -report euclidean.m -args {eg_x,eg_cb}
```

以生成MEX文件。此时的`euclidean_mex.mexw64`文件可以处理variable-size input：

```matlab
% Load the test data
load euclidean_data.mat

% Create 2-D versions of x and cb
x2d=x(1:2,:);
cb2d=cb(1:2,1:6:216);

% Determine closest and farthest points and corresponding distances
[y_min,y_max,idx,distance] = euclidean_mex(x2d,cb2d);

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

```
Coordinates of the closest point are: 
0.8         0.8
Index of the closest point is 29
Distance to the closest point is 0.078672

Coordinates of the farthest point are: 
0  0
Index of the farthest point is 1
Distance to the farthest point is 1.1357
```

<br>

**References**

[1] [Accelerate MATLAB Algorithm by Generating MEX Function - MathWorks](https://ww2.mathworks.cn/help/coder/gs/generating-mex-functions-from-matlab-code-at-the-command-line.html).

[2] [coder.typeof - MathWorks](https://ww2.mathworks.cn/help/coder/ref/coder.typeof.html).