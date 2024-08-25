---
layout: single
title: Sieve of Eratosthenes and MATLAB `primes` Function
date: 2023-04-26 13:24:31 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Prime Obsession
 - Number Theory
 - MATLAB Mathematics
last_modified_at: 2023-11-14 14:15:46 +0800
---

# Sieve of Eratosthenes

埃拉托斯特尼筛法（Sieve of Eratosthenes）用于生成不超过给定值$n$的所有素数。该算法通过迭代的方法将每个素数的倍数标记为合数并将其过滤掉，最终留下来的数字就是素数。具体过程为：

- 埃拉托斯特尼筛法的迭代从$p=2$开始，下一轮迭代开始的素数是$2$之后第一个没有被标记为合数（即素数）的数字，即$3$，并以此类推；
- 每一次迭代都会根据起始素数$p$，生成一个$p$的倍数的序列，该序列始于$p$，最大值不超过给定值$n$，序列中相邻两个元素之差等于$p$。每次迭代后，序列中除了第一个数字$p$以外的所有数字都会被标记为合数；
- 每次迭代开始的数字为$p=2,3,5,\cdots$，直到小于$\sqrt{n}$的最后一个素数结束。剩下的不超过$n$的、没有被标记为合数的数字都是素数；

Wikipedia词条 [1] 中的动图形象地展示了这一过程：

![](https://upload.wikimedia.org/wikipedia/commons/9/94/Animation_Sieve_of_Eratosth.gif?20061230143851)

并且给出了相应的伪代码 [1]：

```
algorithm Sieve of Eratosthenes is
    input: an integer n > 1.
    output: all prime numbers from 2 through n.

    let A be an array of Boolean values, indexed by integers 2 to n,
    initially all set to true.
    
    for i = 2, 3, 4, ..., not exceeding √n do
        if A[i] is true
            for j = i^2, i^2+i, i^2+2i, i^2+3i, ..., not exceeding n do
                set A[j] := false

    return all i such that A[i] is true.
```

<br>

# MATLAB `primes` Function

MATLAB提供的函数`primes` [4] 就是基于埃拉托斯特尼筛法给出小于输入`n`的所有素数：

```matlab
function p = primes(n)
%PRIMES Generate list of prime numbers.
%   PRIMES(N) is a row vector of the prime numbers less than or 
%   equal to N.  A prime number is one that has no factors other
%   than 1 and itself.
%
%   Class support for input N:
%      float: double, single
%      integer: uint8, int8, uint16, int16, uint32, int32, uint64, int64
%
%   See also FACTOR, ISPRIME.
%   Copyright 1984-2013 The MathWorks, Inc. 

if ~isscalar(n) 
  error(message('MATLAB:primes:InputNotScalar'));
elseif ~isreal(n)
  error(message('MATLAB:primes:ComplexInput'));
end
if n < 2
  p = zeros(1,0,class(n)); 
  return
elseif isfloat(n) && n > flintmax(class(n))
  warning(message('MATLAB:primes:NGreaterThanFlintmax'));
  n = flintmax(class(n));  
end
n = floor(n);
p = true(1,double(ceil(n/2)));
q = length(p);
if (isa(n,'uint64') || isa(n,'int64')) && n > flintmax
  ub = 2.^(nextpow2(n)/2);  %avoid casting large (u)int64 to double
else
  ub = sqrt(double(n));
end
for k = 3:2:ub
  if p((k+1)/2)
     p(((k*k+1)/2):k:q) = false;
  end
end
p = cast(find(p)*2-1,class(n)); % Convert variable to the data type like `n`
p(1) = 2;
```

主要分为输入检查和埃拉托斯特尼筛法两个步骤。

## Check input `n`

```matlab
if ~isscalar(n) 
  error(message('MATLAB:primes:InputNotScalar'));
elseif ~isreal(n)
  error(message('MATLAB:primes:ComplexInput'));
end
if n < 2
  p = zeros(1,0,class(n)); 
  return
elseif isfloat(n) && n > flintmax(class(n))
  warning(message('MATLAB:primes:NGreaterThanFlintmax'));
  n = flintmax(class(n));  
end
```

- 检查`n`是否是标量（如果是向量、矩阵或者其他类型，则报错）；
  - 如果是标量，则检查`n`是否是实数（如果是复数，则报错）；
- 检查`n`是否小于2，如果小于2，则返回空向量；
  - 如果`n`大于2，则会进一步进行关于浮点类型输入的检查：如果输入是浮点类型的输入，则会使用`flintmax`函数查询输入的浮点数类型所支持的最大的可连续的整数（相邻间隔不超过1，具体可查看博客 [5] 中关于机器精度的描述），整型的输入会跳过这一步的检查。如果输入的浮点数值`n`超过了`flintmax(class(n))`，则会产生警告`warning(message('MATLAB:primes:NGreaterThanFlintmax'));`，并将`n`的值强制转换为`flintmax(class(n))`，结果可能是不正确的；

## Implementation of Sieve of Eratosthenes

`primes`函数以一种更紧凑的方式实现了埃拉托斯特尼筛法：

```matlab
n = floor(n);
p = true(1,double(ceil(n/2)));
q = length(p);
if (isa(n,'uint64') || isa(n,'int64')) && n > flintmax
  ub = 2.^(nextpow2(n)/2);  %avoid casting large (u)int64 to double
else
  ub = sqrt(double(n));
end
for k = 3:2:ub
  if p((k+1)/2)
     p(((k*k+1)/2):k:q) = false;
  end
end
p = cast(find(p)*2-1,class(n)); % Convert variable to the data type like `n`
p(1) = 2;
```

它仅仅生成了一个对应所有奇数（直接将2的倍数筛选掉）的布尔向量`p`；而另一方面，**在迭代时使用的索引`k`却是针对于完整的数列（包含2的倍数）**，因此在阅读这段代码时可能有些困难。因此，我绘制了一个`primes(51)`的示意图帮助理解：

![image-20230426130614806](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230426130614806.png?raw=true)

同样一个奇数，在完整的数列中的索引$k$（即数字的值本身）与在仅包含奇数的数列中的索引$j$存在以下的算术关系：

$$
j=\dfrac{k+1}{2}\notag
$$

把握好这个关系就能够比较清楚地读懂上面这段代码。

另外一个需要注意的地方是上面代码中内层循环中的起始索引`(k*k+1)/2)`，之所以可以从这个位置开始标记合数，是因为在前面迭代的过程中（起始素数为$k-2$，$k-4$，$\cdots$），**已经将**$(k(k-2)+1)/2$，$(k(k-4)+1)/2$，$\cdots$位置的数标记为合数，因此我们从$(kk+1)/2$开始在布尔向量`q`中每隔$k$个（对应在完整数列中相隔$2k$）标记一次即可。

注：关于这一点，上文中Wikipedia中给出的伪代码也是这样处理的：`j = i^2, i^2+i, i^2+2i, i^2+3i, ...`。
{: .notice--primary}

<br>

# By the way ...

刚开始看到`primes`函数的源代码时，的确不清楚这是使用了一个什么样的算法。在网上搜了搜，感觉有些像是埃拉托斯特尼筛法，但是网上给出的代码也都是创建一个与完整数列所对应的布尔向量，因此就觉得`primes`函数使用的是另一个算法。后来，把`primes`算法的源代码以及对应的问题问了一下ChatGPT，ChatGPT给出了回答：

```
这段MATLAB代码是使用什么算法来给出小于输入n的所有素数的：
function p = primes(n)
%PRIMES Generate list of prime numbers.
% PRIMES(N) is a row vector of the prime numbers less than or 
% equal to N. A prime number is one that has no factors other
% than 1 and itself.
%
% Class support for input N:
% float: double, single
% integer: uint8, int8, uint16, int16, uint32, int32, uint64, int64
%
% See also FACTOR, ISPRIME.
% Copyright 1984-2013 The MathWorks, Inc. 
if ~isscalar(n) 
error(message('MATLAB:primes:InputNotScalar'));
elseif ~isreal(n)
error(message('MATLAB:primes:ComplexInput'));
end
if n < 2
p = zeros(1,0,class(n)); 
return
elseif isfloat(n) && n > flintmax(class(n))
warning(message('MATLAB:primes:NGreaterThanFlintmax'));
n = flintmax(class(n)); 
end
n = floor(n);
p = true(1,double(ceil(n/2)));
q = length(p);
if (isa(n,'uint64') || isa(n,'int64')) && n > flintmax
ub = 2.^(nextpow2(n)/2); %avoid casting large (u)int64 to double
else
ub = sqrt(double(n));
end
for k = 3:2:ub
if p((k+1)/2)
p(((k*k+1)/2):k:q) = false;
end
end
p = cast(find(p)*2-1,class(n));
p(1) = 2;
```

```
这段 MATLAB 代码使用了一种基于埃拉托斯特尼筛法的算法，用于生成小于输入 n 的所有素数。该算法的主要思想是，首先生成一个包含所有奇数的布尔向量，然后从小到大遍历奇数，对于每个素数，将其所有倍数标记为合数。最终，留下的未标记数字就是素数。
具体来说，这段代码使用一个长度为 (n + 1)/2 的布尔向量 p 来表示所有奇数的素性，其中 true 表示素数，false 表示合数。在第一个循环中，代码将布尔向量 p 中的所有元素初始化为 true，然后计算 ub，它是 n 的平方根的上整数部分。在第二个循环中，代码从 3 开始遍历所有奇数，对于每个素数 k，将其所有倍数 ((kk+1)/2):k:q 标记为 false，这里的 ((kk+1)/2) 表示从 k 的平方的奇数部分开始标记，k:q 表示从 k 开始，每隔 k 个数进行标记，其中 q = length(p)。
最后，代码将所有 true 的元素的下标乘以 2，再减去 1，得到小于输入 n 的所有素数，其中第一个素数是 2。
需要注意的是，该算法的时间复杂度为 O(n log log n)，其中 log log n 表示对数的对数，因此可以高效地处理较大的输入 n。
```

回答还是相当有启发性的！

我又反过来让ChatGPT“用MATLAB编写一段基于埃拉托斯特尼筛法的程序”，得到的回答是：

````
当然，我可以帮您编写一段基于埃拉托斯特尼筛法的 MATLAB 程序。

以下是这个程序的示例代码。它使用埃拉托斯特尼筛法来找出所有小于等于指定数字 N 的素数：

```matlab
function primes = sieve_of_eratosthenes(N)
% Initialize all numbers as prime
is_prime = true(1, N);

% Set 1 as non-prime
is_prime(1) = false;

% Loop over odd numbers up to sqrt(N)
for ii = 3:2:sqrt(N)
    % If current number is prime, mark its multiples as non-prime
    if is_prime(ii)
        % Start with ii^2 to avoid redundant marking
        for jj = ii^2:ii:2*N
            is_prime(jj) = false;
        end
    end
end

% Extract prime numbers
primes = find(is_prime);
end
```

在这个程序中，`is_prime` 数组表示每个数字是否为素数。我们首先初始化所有数字为素数，然后将 1 标记为非素数，因为它不是质数。

接下来，我们按奇数循环到 `sqrt(N)`，以避免冗余标记。如果当前数字是素数，我们将其所有倍数都标记为非素数。这里我们从 $ii^2$ 开始标记，以避免重复标记。

最后，我们提取出素数并返回它们的向量。

您可以随意调用此函数，例如：

```matlab
primes = sieve_of_eratosthenes(100);
disp(primes);
```

这将找到小于等于 100 的所有素数，并将它们打印在屏幕上。
````

可以看到，它给出的答案是和Wikipedia伪代码一致的。但是已经很强了！！！

总体而言，我还是觉得MATLAB的`primes`函数的编写方式更加简洁、优美一些，尽管它的可读性可能不太好。

  <br>

**References**

[1] [Sieve of Eratosthenes - Wikipedia](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes).

[2] [Prime number: Sieve - Wikipedia](https://en.wikipedia.org/wiki/Prime_number#Sieves).

[3] [求质数（素数）算法，及算法优化 - Never Give up的博客 - CSDN博客](https://blog.csdn.net/qq_41939020/article/details/99167166).

[4] [primes - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/primes.html).

[5] [Floating Point Representation and Machine Representation of Decimal Digits (IEEE 754 Standards) - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Floating-Point-Arithmetic/#机器精度).