在博客













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

我们用计算`1e9`以下素数个数的案例为例进行测试。首先写一个脚本文件`test.m`：

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

借助MATLAB的工具Profiler [XX] 分析代码的运行。打开`helperSegmentedSieve2Num`的分析：

![image-20230502185719138](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230502185719138.png)

可以看到，在我们这个应用场景下，`helperSegmentedSieve2Num`中判断区间左端值奇偶性的代码是不必要的（因为一定时偶数），因此，为了简化代码，我们可以将左端值为奇数的分支删除掉，得到：

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

之后，使用以下代码生成MEX文件：

```matlab
clc,clear,close all

L = coder.typeof(double(1),[1,1],1);
R = coder.typeof(double(1),[1,1],1);
plist = primes(1e9)';
plist = coder.typeof(plist,[inf,1],1);

codegen -report helperSegmentedSieve2Num -args {L, R, plist}
```

结果出现了以下的错误：

![image-20230502191315858](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230502191315858.png)

点击`View Error Report`：

![image-20230502191356874](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230502191356874.png)

报错的原因是生成MEX文件时不支持`pj=pList`语句，我们需要将其修改为`j = 1:numel(pList)`，并添加`pj=pList(j)`语句，即：

```matlab
function numLRprimes = helperSegmentedSieve2Num(L,R,pList)%#codegen
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

<br>

在生成了MEX文件后，测试了`helperSegmentedSieve2Num`函数文件和`helperSegmentedSieve2Num_mex`函数文件的运行速度：

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

注：测试`helperSegmentedSieve2Num`函数文件的运行速度只需要将上述代码中的`helperSegmentedSieve2Num_mex`更改为`helperSegmentedSieve2Num`即可。
{: .notice--primary}

最终，使用`helperSegmentedSieve2Num_mex`函数文件的运行时间为：

```
Elapsed time is 8618.152032 seconds.
```

以及使用`helperSegmentedSieve2Num`函数文件的运行时间为：

```
Elapsed time is 9928.653218 seconds.
```

使用MEX函数计算速度快了大概1310.5 s（21.84 min）。









<br>

当间隔为`4e9`，耗费时间：

```
Elapsed time is 8480.572193 seconds.
```



当间隔为`2e9`，耗费时间：

```
Elapsed time is 8496.375233 seconds.
```

<br>

**References**

[1]

[2]

[3] [Run code and measure execution time to improve performance - MATLAB - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/profiler-app.html).
