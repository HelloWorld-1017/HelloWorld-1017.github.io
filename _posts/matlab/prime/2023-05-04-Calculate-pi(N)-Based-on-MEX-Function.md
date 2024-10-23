---
title: Calculate $\pi(N)$ Based on MATLAB MEX Function of Improved Segmented Sieve of Eratosthenes
toc: false
categories: 
 - Mathematics
 - MATLAB
tags:
 - Prime Obsession
 - Number Theory
 - MATLAB Software Development Tools
date: 2023-05-04 16:11:11 +0800
last_modified_at: 2024-10-23 19:28:01 +0800
---

在博客 [1] 中，我们基于改进的Segmented Sieve of Eratosthenes方法构建了一个用于计算指定区间素数个数的函数`helperSegmentedSieve2Num`：

```matlab
function numLRprimes = helperSegmentedSieve2Num(L,R,pList)
pList = pList(pList<=sqrt(R));
pList(pList==2) = [];

if rem(L,2) % L is odd
    isp = true(1,ceil((R-L+1)/2));
    for pj = pList
        if rem(ceil(L/pj),2) % ceil(L/pj) is odd
            minIdx = (ceil(L/pj)*pj-L+1+1)/2;
        else                 % ceil(L/pj) is even
            minIdx = ((ceil(L/pj)+1)*pj-L+1+1)/2;
        end
        maxIdx = (floor(R/pj)*pj-L+1+1)/2;
        idx = minIdx:pj:maxIdx;
        isp(idx) = false;
    end
else % L is even
    isp = true(1,floor((R-L+1)/2));
    for pj = pList
        if rem(ceil(L/pj),2) % ceil(L/pj) is odd
            minIdx = (ceil(L/pj)*pj-L+1)/2;
        else                 % ceil(L/pj) is even
            minIdx = ((ceil(L/pj)+1)*pj-L+1)/2;
        end
        maxIdx = (floor(R/pj)*pj-L+1)/2;
        idx = minIdx:pj:maxIdx;
        isp(idx) = false;
    end
end
numLRprimes = sum(isp);
end
```

并且在博客 [1] 的最后，将其用于计算$\pi(10^{12})$。但是，这种方法计算的速度还是太慢了；另一方面，使用MEX来代替原本的`.m`函数可以加快代码的运行速度 [2]。因此，本博客就将`helperSegmentedSieve2Num`函数转换为MEX函数的形式，看一下这种方式是否能够提升代码的运算速度，以及提升是否是明显的。

<br>

在转换为MEX函数之前，我们首先使用计算$\pi(10^{9})$为例测试一下前面的`helperSegmentedSieve2Num`函数。为此，编写一个脚本文件`test.m`：

```matlab
clc,clear,close all

tic
LowerLimit = 1e8;
UpperLimit = 1e9;
interval = 1e8;

plist = primes(LowerLimit);
num = numel(plist);

for i = 1:(UpperLimit/interval)-1
    numLRprimes = helperSegmentedSieve2Num(LowerLimit+(i-1)*interval,LowerLimit+i*interval,plist);
    num = num+numLRprimes;
end
toc
```

然后在命令行中执行命令：

```matlab
profile on; test; profile viewer
```

借助MATLAB的工具Profiler [3] 分析代码的运行。打开`helperSegmentedSieve2Num`的分析：

![image-20230502185719138](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230502185719138.png?raw=true)

可以看到，在计算$\pi(N)$这个应用场景下，`helperSegmentedSieve2Num`中判断区间左端值奇偶性的代码是不必要的（因为一定是偶数）。因此，为了简化代码，我们可以将左端值为奇数的分支删除掉，得到：

```matlab
function numLRprimes = helperSegmentedSieve2Num(L,R,pList)
pList = pList(pList<=sqrt(R));
pList(pList==2) = [];

isp = true(1,floor((R-L+1)/2));
for pj = pList
    if rem(ceil(L/pj),2) % ceil(L/pj) is odd
        minIdx = (ceil(L/pj)*pj-L+1)/2;
    else                 % ceil(L/pj) is even
        minIdx = ((ceil(L/pj)+1)*pj-L+1)/2;
    end
    maxIdx = (floor(R/pj)*pj-L+1)/2;
    idx = minIdx:pj:maxIdx;
    isp(idx) = false;
end

numLRprimes = sum(isp);
end
```

之后在函数声明后添加` %#codegen`指令检查代码是否适用于code generation。确认无误后，就使用以下代码生成MEX文件：

```matlab
clc,clear,close all

L = coder.typeof(double(1),[1,1],1);
R = coder.typeof(double(1),[1,1],1);
plist = primes(1e9)';
plist = coder.typeof(plist,[inf,1],1);

codegen -report helperSegmentedSieve2Num -args {L, R, plist}
```

结果出现了以下的错误：

![image-20230502191315858](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230502191315858.png?raw=true)

点击`View Error Report`：

![image-20230502191356874](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230502191356874.png?raw=true)

报错的原因是生成MEX文件时不支持`pj=pList`语句，我们需要将其修改为`j = 1:numel(pList)`，并添加`pj=pList(j)`语句，即：

```matlab
function numLRprimes = helperSegmentedSieve2Num(L,R,pList) %#codegen
pList = pList(pList<=sqrt(R));
pList(pList==2) = [];

isp = true(1,floor((R-L+1)/2));
for j = 1:numel(pList)
    pj = pList(j);
    if rem(ceil(L/pj),2) % ceil(L/pj) is odd
        minIdx = (ceil(L/pj)*pj-L+1)/2;
    else                 % ceil(L/pj) is even
        minIdx = ((ceil(L/pj)+1)*pj-L+1)/2;
    end
    maxIdx = (floor(R/pj)*pj-L+1)/2;
    idx = minIdx:pj:maxIdx;
    isp(idx) = false;
end
numLRprimes = sum(isp);
end
```

之后，再生成MEX函数文件即可。

注：关于上述的这个错误，函数声明后的`%#codegen`指令是检查不出来的。
{: .notice--primary}

<br>

在生成了MEX文件后，就可以测试`helperSegmentedSieve2Num`函数和`helperSegmentedSieve2Num_mex`函数计算$\pi(10^{12})$的运行速度：

```matlab
clc,clear,close all

LowerLimit = 1e9;
UpperLimit = 1e12;
interval = 1e9;

plist = primes(LowerLimit)';
num = numel(plist);

tic
for i = 1:(UpperLimit/interval)-1
    numLRprimes = ...
        helperSegmentedSieve2Num_mex(LowerLimit+(i-1)*interval,LowerLimit+i*interval,plist);
    num = num+numLRprimes;
end
toc
```

注：`helperSegmentedSieve2Num`的测试只需要将上述代码中的`helperSegmentedSieve2Num_mex`更改为`helperSegmentedSieve2Num`即可。
{: .notice--primary}

最终，使用`helperSegmentedSieve2Num_mex`函数文件的运行时间为：

```
Elapsed time is 8618.152032 seconds.
```

以及使用`helperSegmentedSieve2Num`函数文件的运行时间为：

```
Elapsed time is 9928.653218 seconds.
```

使用MEX函数计算速度快了大概1310.5 s（21.84 min）。虽然改为MEX函数后，运算速度得到了比较显著的提升，但这仍然是不够的。如果要计算$\pi(10^{18})$，这种方式还是不太行。。。

<br>

当完成以上的测试后，我突然想到，如果将区间间隔`interval`增大（当前为`interval = 1e9`），最大限度地利用内存空间，可能也会加快一些计算速度。

最后，测试结果表明（使用MEX函数），当间区间间隔为`2e9`，耗费时间：

```
Elapsed time is 8496.375233 seconds.
```

当区间间隔为`4e9`，耗费时间：

```
Elapsed time is 8480.572193 seconds.
```

虽然有所提升，但仍然是不够的~

<br>

**References**

[1] [Basic and Improved Segmented Sieve of Eratosthenes - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Basic-and-Improved-Segmented-Sieve-of-Eratosthenes/).

[2] [Accelerate MATLAB Algorithm by Generating MEX Function - What a starry night~](http://whatastarrynight.com/matlab/Accelerate-MATLAB-Algorithm-by-Generating-MEX-Function/).

[3] [Run code and measure execution time to improve performance - MATLAB - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/profiler-app.html).
