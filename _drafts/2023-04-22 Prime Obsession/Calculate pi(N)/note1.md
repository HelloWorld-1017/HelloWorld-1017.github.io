# Introduction

在Prime Obsession这本书中 [1]，作者给出了

| $N$                       | $\pi(N)$               |
| ------------------------- | ---------------------- |
| 1,000                     | 168                    |
| 1,000,000                 | 78,498                 |
| 1,000,000,000             | 50,847,534             |
| 1,000,000,000,000         | 37,607,912,018         |
| 1,000,000,000,000,000     | 29,844,570,422,669     |
| 1,000,000,000,000,000,000 | 24,739,954,287,740,860 |

如何使用计算机计算出这些数字呢？

<br>

# Pure Vectorization Programming

在MATLAB中，如果能使用向量化编程的模式而不是循环遍历矩阵的每个元素，则会快很多；并且MALTAB本身提供了一个`isprime`函数 [2]，能够接受一个向量，并给出一个同形的逻辑矩阵表示矩阵中的元素是否是素数。例如：

```matlab
>> isprime([3,4])
ans =
  1×2 logical array
   1   0
   
>> whos
  Name      Size            Bytes  Class      Attributes
  ans       1x2                 2  logical              
```

因此，很自然的一个想法是创建一个`1:1e18`的整数向量，直接将其输入到`isprime`函数中，给出计算结果，将逻辑矩阵相加即可。

MATLAB提供了很多类型的`integer`类型的整数变量 [3]：

![image-20230422145327359](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230422145327359.png)

在判断**正整数**是否是素数这个问题中，为了最大限度地利用内容，我们可以选择无符号的整数类型，即：`uint8`， `uint16`，`uint32`或者`uint64`。假如我们想要创建一个`1:1e18`的正整数变量，就需要选择`uint64`的数据类型，因为32位以下的数据类型是无法承载这样的数据的：

```matlab
>> (2^64-1)>1e18
ans =
  logical
   1
```

```matlab
>> (2^32-1)>1e18
ans =
  logical
   0
```

但另一方面，创建一个`unit64`类型数据需要64位（8个字节）的内存空间，开辟一个长度为`1e18`的`unit64`类型就需要`7.4506e+09`GB的内存：

```matlab
>> 8*1e18/1024/1024/1024
ans =
   7.4506e+09
```

如果使用128 GB的内存条，则大概需要安装5820万根，这显然是不现实的！！！

<br>

# Painful Loop

既然内存的问题无法解决，那么采用循环的方式遍历`1:1e18`中的每一个正整数判断它们是否是素数，用时间代价来解决空间不足的问题。因此，可以编写一个这样一个程序来解决上面的问题：

```matlab
numRange = [1e3,1e6,1e9,1e12,1e15,1e18];
nums = nan(1,numel(numRange));

for j = 1:numel(numRange)
    tic
    num = 0;
    for i = 1:numRange(j)
        PrimeIdx = isprime(i);
        num = num+PrimeIdx;
    end
    nums(j) = num;
    fprintf("%s,%s\n",num2str(numRange(j)),num2str(num))
    toc
end
```

但是，我在判断完$1,000,000,000$以内的正整数后就停止了程序。因为实在是太慢了！！！判断`1e3`、`1e6`和`1e9`个整数分别需要0.003561 s，5.471636 s，XXX s：

```matlab
```

由此可以**很保守地**做一个线性估计，判断$1\times10^{18}$个整数至少需要XX s（即XX天）；更不要说上面这段代码本身的问题——在计算下一个量级后，并没有

这样的估计是相当粗糙的，因为对数观念；



并行计算；GPU计算（绘制分形的那个博客）；

CPU占用率大约在30%，GPU的占用率大约在2%\-3%。

<br>

高斯手算的轶事

<br>

**References**

[1] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[2] [Determine which array elements are prime - MATLAB isprime - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/isprime.html).

[3] [Integers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/integers.html).

[4] https://en.wikipedia.org/wiki/Prime_number#Special-purpose_algorithms_and_the_largest_known_prime.

[5] 

