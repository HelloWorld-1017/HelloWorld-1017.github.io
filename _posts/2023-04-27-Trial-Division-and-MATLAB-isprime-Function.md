---
layout: single
title: Trial Division and MATLAB `isprime` Function
date: 2023-04-27 12:05:29 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Prime Obsession
 - Number Theory
 - MATLAB Mathematics
---

# Trial Division

试除法（trial division）是一种判定某个数$n$是否为素数的方式。想要判定某个数$n$是不是素数，我们只需要使用素数$2,3,5,\cdots$一个一个地去除$n$（因为任何一个合数都可以分解为素数之积，因此只需要尝试素数即可），直到其中有一个素数正好可以整除$n$，那么我们就可以说明$n$不是素数。这种尝试直到我们**将要**用来除的素数大于$\sqrt n$（即尝试的素数不超过$\sqrt n$，**小于等于**$\sqrt n$）时就停下来。

<br>

# MATLAB `isprime` Function

试除法的思想是很简单的，MATLAB的自建函数`isprime`就是通过这种方式来判断一个数是否是素数：

```matlab
function isp = isprime(X)
%ISPRIME True for prime numbers.
%   ISPRIME(X) is 1 for the elements of X that are prime, 0 otherwise.
%
%   Class support for input X:
%      float: double, single
%      integer: uint8, int8, uint16, int16, uint32, int32, uint64, int64
%   See also FACTOR, PRIMES.
%   Copyright 1984-2012 The MathWorks, Inc. 

isp = false(size(X));

if ~isempty(X)  
    X = X(:);
    if ~isreal(X) || any(X < 0) || any(floor(X) ~= X) || ...
            any(isinf(X))
        error(message('MATLAB:isprime:InputNotPosInt'));
    end
    
    n = max(X);
    if isinteger(X) || n <= flintmax(class(X))
        if (isa(X,'uint64') || isa(X,'int64')) && n > flintmax
            p = primes(2.^(nextpow2(n)/2));
        else
            p = primes(cast(sqrt(double(n)),class(X)));
        end
        for k = 1:numel(isp)
            Xk = X(k);
            isp(k) = (Xk>1) && all(rem(Xk, p(p<Xk)));
        end
    else
        fm = flintmax(class(X));
        p = primes(sqrt(fm));
        for k = 1:numel(isp)
            Xk = X(k);
            isp(k) = (Xk<fm) && (Xk>1) && all(rem(Xk, p(p<Xk)));
        end
    end
end
```

如果不考虑检查输入的步骤，`isprime`函数主要实现了以下的工作：

- `isprime`函数接受标量，向量和矩阵输入。因此，第一步是将输入展开成一个列向量（`X = X(:);`），之后寻找到列向量中的最大值（`n = max(X);`）；
- 之后对最大值开根号，并使用`primes`函数得到包含所有不超过该值的素数列表`p`（关于`primes`函数，可参考博客 [4]）；
  - 对于整型输入：`p = primes(2.^(nextpow2(n)/2));`，这是为了防止在计算的过程中将整型变量转换为浮点数；
  - 对于浮点类型的输入：`p = primes(cast(sqrt(double(n)),class(X)));`；
- 之后，对输入中的所有元素进行（向量化的）试除法：`isp(k) = (Xk>1) && all(rem(Xk, p(p<Xk)));`，并将判断的结果保存在`isp`变量中；

例如对于：

```matlab
primes([133,457,9,13,103])
```

我们可以简单地可视化上述的过程：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230426201640597.png?raw=true" alt="image-20230426201640597" style="zoom:50%;" />

但是，`isprime`函数中语句`isp(k) = (Xk>1) && all(rem(Xk, p(p<Xk)))`表示在对元素进行试除法时，尝试的是素数列表`p`中**小于**该元素的所有素数。例如，对于元素`9`，需要对2，3，5，7四个素数进行试除。而根据试除法的原理，我们只需要对素数列表`p`中**小于等于**$\sqrt{\text{9}}=3$的所有素数进行试除即可，因**此这一步会增加计算时间！！！**对于元素133，13和103的试除同样会面临这样的问题：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230426202608380.png?raw=true" alt="image-20230426202608380" style="zoom:50%;" />

上图中，浅紫色的元素表示没有必要进行试除的元素。

因此，我们可以把这试除的语句更改为：

```matlab
isp(k) = (Xk>1) && all(rem(Xk, p(p<=sqrt(Xk))));
```

注：一定注意是`<=`，而不是`<`，`<`是不对的。例如对于元素4，开根号为2，若写为`<`，则不存在试除的元素，最终`all(4,[])`的值为`1`，因此就会判定4是素数，这显然是不正确的。
{: .notice--warning}

为了验证这一点，我复制了一份`isprime`函数，然后**仅仅**对试除部分做出了如上所述的修改，将其定义为`helperIsprime`函数，测试了一下两个函数*“重复10次判断`1:1e7`内所有元素是否为素数”*所花费的时间：

```matlab
clc,clear,close all

tic
for i = 1:10
    result_helper = helperIsprime(1:1e7);
end
toc

tic
for i = 1:10
    result_builtin = isprime(1:1e7);
end
toc
```

做出修改的代码快了三分多钟：

```
Elapsed time is 598.448084 seconds.
Elapsed time is 805.830040 seconds.
```

并且判断的结果是一致的：

```matlab
>> sum(result_builtin~=result_helper)
ans =
     0
```

可以预期的是，随着上限的增加，相比于原来的`isprime`函数，修改过的代码会节省更多的时间。

<br>

**References**

[1] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[2] [Trial division - Wikipedia](https://en.wikipedia.org/wiki/Trial_division).

[3] [isprime - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/isprime.html).

[4] [Sieve of Eratosthenes and MATLAB primes Function - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Sieve-of-Eratosthenes-and-MATLAB-primes-Function/).
