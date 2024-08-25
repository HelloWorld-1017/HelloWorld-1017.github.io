---
layout: single
title: Basic and Improved Segmented Sieve of Eratosthenes
date: 2023-04-30 16:46:35 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Prime Obsession
 - Number Theory
 - MATLAB Mathematics
---

# Why We Need Segmented Sieve of Eratosthenes？

在博客 [1] 中，我们讨论了用于给出小于某一给定值所有素数$\pi(N)$的Sieve of Eratosthenes，并且介绍了MATLAB的相关函数`primes`。但是，对于一个非常大的$N$值，使用`primes`函数得到$\pi(N)$是非常不现实的，因为单单“创建一个对应奇数的布尔向量”这一步骤就需要巨大的内存空间。例如，Derbyshire在*Prime Obsession* [2,3] 中给出了这样一张关于$\pi(N)$的表：

| $N$                                   | $\pi(N)$               |
| ------------------------------------- | ---------------------- |
| 1,000 （一千）                        | 168                    |
| 1,000,000 （一百万）                  | 78,498                 |
| 1,000,000,000（十亿）                 | 50,847,534             |
| 1,000,000,000,000（一万亿）           | 37,607,912,018         |
| 1,000,000,000,000,000（一千万亿）     | 29,844,570,422,669     |
| 1,000,000,000,000,000,000（一百亿亿） | 24,739,954,287,740,860 |

假如我们想要使用Sieve of Eratosthenes计算$\pi(10^{18})$，则需要创建一个长度为$5\times10^{17}$的布尔向量以对应奇数；而一个布尔值会占用一个字节，长度为$5\times10^{17}$的布尔向量就会占用大于$4.66\times10^8$ GB的内存。如果使用128 GB的内存条，则大概需要364万根，这显然是极其不现实的！！！

Segmented Sieve of Eratosthenes（分段埃拉托斯特尼筛法）是一种给出在给定区间内所有素数的筛法 [4,5,6]，它能够解决内存空间不足的问题。但是需要注意的一点是，尽管Segmented Sieve of Eratosthenes的确能够给出指定区间的所有素数，但是我们也不能期望在计算出$\pi(N)$的同时（$N$特别大时），将小于$N$的所有素数保存下来，这仍然涉及到存储空间的问题。同样拿保存$10^{18}$以下的所有素数为例，这个量级的整数需要使用64位（8个字节）的无符号整型来保存，因此24,739,954,287,740,860个素数需要$1.84\times10^{8}$ GB的存储空间，大概需要9万个2 TB的硬盘，这仍然是不现实的。

注：保存$10^{12}$（一万亿）以下的所有素数需要280 GB的存储空间。
{: .notice--primary}

<br>

# Segmented Sieve of Eratosthenes

## Basic segmented sieve of Eratosthenes

基础的segmented sieve of Eratosthenes算法如下 [4]。

给定一个区间$[L,R]$：

（1）首先使用普通的Sieve of Eratosthenes构建小于等于`sqrt(R)`的素数表`pList`；

（2）构建一个长度为`(R-L+1)`的布尔向量`isp`，对应区间$[L,R]$内的所有正整数，并将`isp`中的所有元素初始化为`true`。布尔向量`isp`的索引`i`对应于$[L,R]$内的正整数$\text{Integer}$的对应关系为：

$$
\begin{split}
\mathrm{i}=\text{Integer}-L+1,\quad i=1,2,...(R-L+1)
\end{split}\label{eq1}
$$

或者：

$$
\begin{split}
\text{Integer}=\mathrm{i}+L-1,\quad i=1,2,...(R-L+1)
\end{split}\label{eq2}
$$

（3）对于素数表`pList`中的每一个元素（记为`pj`），将其的倍数标记为`false`：第一个标记的元素为`ceil(L/pj)*pj`，最后一个标记的元素为`floor(R/pj)*pj`（注意要根据式$\eqref{eq1}$转化为布尔向量对应的索引`i`）。重复该步骤，直到遍历完素数表`pList`中的所有元素；

（4）最后，布尔向量中剩下的标记为`true`的元素就对应区间$[L,R]$中的所有素数`pLRList`。在计算这些素数的值时，需要根据式$\eqref{eq2}$进行转换。

例如，寻找区间$[51,76]$中所有素数的过程为：

![image-20230428202641050](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230428202641050.png?raw=true)

以上，一个非常简单且自然的Segmented sieve就完成了，但是由于区间端点`L`和`R`值是用户所设置的，因此仍需要注意一些地方：

（1）当区间的右端`R`特别大，而左端`L`比较小时，在最开始所构建的素数表`pList`（小于等于`sqrt(R)`的所有素数）会和区间$[L,R]$中所包含的素数**重合**。这会导致我们在标记`pList`中每一个元素`pj`的倍数为`false`时，会导致我们将$[L,R]$中`pj`本身（`pj`的一倍）也标记为素数，因此得到的`pLRList`是缺少素数的。例如，我们使用上述方法来寻找$[5,26]$内的所有素数：

![image-20230428202712584](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230428202712584.png?raw=true)

可以看到，$[5,26]$内的素数$5$被筛掉了，我们找到的`pLRList`是不完整的。因此，为了防止这种情况的发生，我们可以将`pList`中大于等于`L`的素数保留下来，与`pLRList`进行拼接：`pLRList = [plist(pList>=L), pLRList];`。

（2）如果我们设置的左端为`L=1`（虽然非常没有必要，因为这种情况使用Sieve of Eratosthenes 更简单，但是要考虑一下这种情况），上面的过程中会无法筛选掉`1`这个数字。因此，我们在代码的最后要删除掉`pLRList`中的`1`：`pLRList(pLRList==1) = []`。

最终，我们可以构造出这样一个函数：

```matlab
function [pLRList,numLRprimes] = helperSegmentedSieve(L,R)
pList = primes(sqrt(R));

isp = true(1,R-L+1);

for pj = pList
    minIdx = ceil(L/pj)*pj;
    maxIdx = floor(R/pj)*pj;
    idx = (minIdx:pj:maxIdx)-L+1;
    isp(idx) = false;
end

pLRList = find(isp)+L-1;
pLRList = [pList(pList>=L), pLRList];
pLRList(pLRList==1) = [];
numLRprimes = numel(pLRList);
end
```

其中，输入`L`和`R`分别为区间的左右端点，输出`PLRList`为区间$[L,R]$中的所有素数，`numLRprimes`为区间$[L,R]$中素数的个数。

## Improved segmented sieve of Eratosthenes

在博客 [1] 中，我们可以看到MATLAB的`primes`使用在实现基本的Sieve of Eratosthenes时，创建的布尔向量只对应奇数。这种方式能够减少一半的内存空间，因此我想要针对Segmented Sieve of Eratosthenes也实现这一点。

（1）对于Sieve of Eratosthenes，区间的左端点是固定的，为正整数`1`。`1`是一个奇数，因此在创建布尔向量和索引时，不用做过多的判断。布尔向量的长度为`ceil(n/2)`：

```matlab
p = true(1,double(ceil(n/2)));
```

仅对应奇数的布尔向量的索引$\mathrm{idx_{odd}}$与完整数列的索引$\mathrm{idx_{all}}$之间的关系为：

$$
\mathrm{idx_{odd}}=\dfrac{\mathrm{idx_{all}}+1}{2}
$$

但是，对于segmented Eratosthenes sieve，情况就有所不同。在下图中，我给出了几个简单的例子：

![image-20230429161846101](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230429161846101.png?raw=true)

通过这个例子，我们可以归纳出：

- 当左端`L`的值为奇数时（无论右端`R`值的奇偶性）：

  - 仅对应奇数的布尔向量的长度为：`ceil((L-R+1)/2)`；

  - 仅对应奇数的布尔向量的索引$\mathrm{idx_{odd}}$与完整数列的索引$\mathrm{idx_{all}}$之间的对应关系为：
  - 
    $$
    \mathrm{idx_{odd}}=\dfrac{\mathrm{idx_{all}}+1}{2}\notag
    $$

- 当左端`L`的值为偶数时（同样无论右端`R`值的奇偶性）：

  - 仅对应奇数的布尔向量的长度为：`floor((L-R+1)/2)`；

  - 仅对应奇数的布尔向量的索引$\mathrm{idx_{odd}}$与完整数列的索引$\mathrm{idx_{all}}$之间的对应关系为：
  - 
    $$
    \mathrm{idx_{odd}}=\dfrac{\mathrm{idx_{all}}}{2}\notag
    $$

因此，我们需要增加一个`if`结构根据`L`的奇偶性做不同的处理。

（2）在之前所定义的函数中，我们使用语句：

```matlab
minIdx = ceil(L/pj)*pj;
```

寻找$[L,R]$区间内第一个被标记的值。但是，当我们仅仅处理奇数所对应的布尔向量时，第一个标记的值可能是**偶数**，这会导致`minIdx`对应“奇数所对应的布尔向量”的分数索引，这是不对的。因此，我们同样需要对`ceil(L/pj)`的奇偶性进行判断。例如，在当`L`为奇数时：

```matlab
if rem(L,2) % L is odd
	...
    for pj = pList
        if rem(ceil(L/pj),2) % ceil(L/pj) is odd
            minIdx = (ceil(L/pj)*pj-L+1+1)/2;
        else   % ceil(L/pj) is even
            minIdx = ((ceil(L/pj)+1)*pj-L+1+1)/2;
        end
    ...
    end
```

（3）由于我们去掉了布尔向量中对应偶数的部分，但是正整数$2$作为唯一一个偶素数，当$L=2$或者$L=1$是，它会被筛掉。因此，在最后我们需要在代码的最后进行判断和补充：

```matlab
...
if L == 2 || L == 1
    pLRList = [2, pLRList];
end
...
```

最终，我们可以得到这样一个改进版本的Segmented Sieve of Eratosthenes函数`helperSegmentedSieve2`：

```matlab
function [pLRList,numLRprimes] = helperSegmentedSieve2(L,R)
pList = primes(sqrt(R));
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
    pLRList = find(isp)*2-1+L-1;
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
    pLRList = find(isp)*2+L-1;
end
pLRList = [pList(pList>=L), pLRList];
pLRList(pLRList==1) = [];
if L == 2 || L == 1
    pLRList = [2, pLRList];
end
numLRprimes = numel(pLRList);
end
```

> 注：除了以上关于布尔向量长度的改进以外，博客 [1] 中还提到了MATLAB的`primes`函数另一个很巧妙的地方：在根据起始素数标记序列中它的倍数时，代码并不是从`(k+2)*k`开始标记的，而是从`k*k`处开始标记的：
>
> ![image-20230429164956390](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230429164956390.png?raw=true)
>
> 这能够进一步加大代码的效率。但对于segmented Eratosthenes sieve而言，这样的改进意义是很小的。因为尽管我上面编写的代码想要适用于任何的区间，但是在实际应用segmented Eratosthenes sieve时，素数表`pList`和`[L,R]`是不重合的：
>
> ![image-20230429170030439](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230429170030439.png?raw=true)
>
> 在这种情况下，如果仍想要使用这个改进效率的方式，需要做更多的判断，可能反而是不经济的。

<br>

# Test `helperSegmentedSieve` and `helperSegmentedSieve2` 

至此，我们得到了两个Segmented Sieve of Eratosthenes函数：`helperSegmentedSieve`，以及它的改进版本`helperSegmentedSieve2`。下面我们就测试一下它们的正确性。

## Calculate in random interval

第一个测试是随机的区间测试，方法是在$[1,1\times10^6]$的区间内随机选取左端点`L`的整数值，然后加上一个$[1,1\times10^5]$区间内的整数值作为右端点`R`，比较这个区间内`helperSegmentedSieve`函数以及`helperSegmentedSieve2`函数和借助MATLAB`primes`函数得到的结果是否一致。例如，对于`helperSegmentedSieve`函数：

```matlab
clc,clear,close all

results = nan(1e5,2);
for i = 1:height(results)
    [diffPrimes,diffSums] = helperTest;
    results(i,1) = diffPrimes;
    results(i,2) = diffSums;
end
disp(sum(results,"all"))

function [diffPrimes,diffSums] = helperTest
L = ceil(rand*1e6);
R = L+ceil(rand*1e5);

[pLRList_self,num_self] = helperSegmentedSieve(L,R);
pLRList_builtin = primes(R);
pLRList_builtin(pLRList_builtin<L | pLRList_builtin>R) = [];
diffPrimes = sum(pLRList_self - pLRList_builtin);
diffSums = num_self - numel(pLRList_builtin);
end
```

注：测试`helperSegmentedSieve2`函数只需要将上述代码中`helperTest`函数中使用的`helperSegmentedSieve`替换为`helperSegmentedSieve2`即可。
{: .notice--primary}

最终结果表明，两个函数与使用MATLAB`primes`函数得到的结果都是一致的。

## Calculate $\pi(1\times10^{12})$

第二个测试是计算一下$\pi(1\times10^{12})$。首先，尝试一下使用`primes`函数尝试计算一下$\pi(1\times10^{12})$。不出意外，MATLAB报错在创建布尔向量时内存不足：

```matlab
>> pp = primes(1e12);
```

```
Error using true
Requested 1x500000000000 (465.7GB) array exceeds maximum
array size preference (15.7GB). This might cause MATLAB
to become unresponsive.

Error in primes (line 28)
p = true(1,double(ceil(n/2)));

Related documentation
```

之后，我们分别使用上面创建的两个函数来计算$\pi(N)$。计算的方法：

（1）首先构建出`1e9`以下的素数表并计数；

（2）以`1e9`为间隔，使用Segmented Sieve of Eratosthenes计算出每个间隔内的素数个数并累加，这种迭代一直持续到`1e12`；

在这个过程中，需要注意两点：

（1）小于`1e9`的素数表的生成要放在函数的外面，函数中只选取小于`sqrt(R)`的素数即可，这样就不用每次都生成素数表，减少程序运行时间；

（2）由于保存`1e12`内的所有素数是非常占用空间的，因此函数就不再输出素数表，只让函数输出指定范围内的素数个数这一个值即可；

因此，上面的两个函数被相应修改为：

```matlab
function numLRprimes = helperSegmentedSieveNum(L,R,pList)
pList = pList(pList<=sqrt(R));

isp = true(1,R-L+1);

for pj = pList
    minIdx = ceil(L/pj)*pj;
    maxIdx = floor(R/pj)*pj;
    idx = (minIdx:pj:maxIdx)-L+1;
    isp(idx) = false;
end
numLRprimes = sum(isp);
end
```

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

`helperSegmentedSieveNum`的测试脚本为：

```matlab
clc,clear,close all

tic
LowerLimit = 1e9;
UpperLimit = 1e12;
interval = 1e9;

plist = primes(LowerLimit);
num = numel(plist);

for i = 1:(UpperLimit/interval)-1
    numLRprimes = helperSegmentedSieve2Num(LowerLimit+(i-1)*interval,LowerLimit+i*interval,plist);
    num = num+numLRprimes;
end
toc
```

注：测试`helperSegmentedSieve2Num`函数只需要将上述脚本中使用的`helperSegmentedSieveNum`替换为`helperSegmentedSieve2Num`即可。
{: .notice--primary}

最终，两个函数算出的`1e12`以下的素数个数均为：

```matlab
>> format long
>> num
num =
     3.760791201800000e+10
```

对比博客一开头所列出的素数表，这一值是正确的。

但是，两个函数的运行时间是相差巨大的。使用`helperSegmentedSieveNum`所花费的时间为23439.68 s（6.51 h），而使用`helperSegmentedSieve2Num`所花费的时间为9780.42 s（2.72 h）。所以，我们上面所做的改进Segmented Sieve of Eratosthenes的努力是非常值得的，这种改进不仅降低了空间的需求量（降低了一半），而且极大地降低了时间复杂度。

<br>

# Unsolved problems ...

上文使用`helperSegmentedSieve2Num`函数计算$\pi(10^{12})$的过程以`1e9`起始点和间隔长度，一共进行了999次迭代，花费了9780.42 s（2.72 h）。假如我们想要使用这种方式计算$\pi(10^{18})$，非常保守地线性估算一下，大概需要9790210200.42 s（27195028.83 h，3104.45年）。总得来说，Segmented Sieve of Eratosthenes解决了空间不足的问题，但还需要使用更多的技巧来改善计算速度慢的问题……

<br>

**References**

[1] [Sieve of Eratosthenes and MATLAB primes Function - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Sieve-of-Eratosthenes-and-MATLAB-primes-Function/).

[2] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[3] [The Prime Number Theorem (PNT) from Prime Obsession by Derbyshire - What a starry night~](http://whatastarrynight.com/mathematics/The-Prime-Number-Theorem-(PNT)-from-Prime-Obsession-by-Derbyshire/).

[4] [Sieve of Eratosthenes - Wikipedia](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes).

[5] Bays C, Hudson R H. The segmented sieve of Eratosthenes and primes in arithmetic progressions to 1012[J]. BIT Numerical Mathematics, 1977, 17(2): 121-127. Available: https://link.springer.com/article/10.1007/BF01932283.

[6] [https://www.scaler.com/topics/segmented-sieve/](https://www.scaler.com/topics/segmented-sieve/).

