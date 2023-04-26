要判定某个数$N$是不是素数，我们只需要使用素数$2,3,5,\cdots$一个一个地去除$N$，直到其中有一个素数正好可以整除$N$，那么我们就可以说明$N$不是素数。这种尝试直到我们**将要**用来除的素数大于$\sqrt N$时就停下来。









```matlab
tic
a = 1:1e7;
result = selfIsprime(a);
toc
```

```
Elapsed time is 49.381861 seconds.
```



自建函数：

```matlab
tic
for i = 1:10
    a = 1:1e7;
    result = selfIsprime(a);
end
toc
```

```
Elapsed time is 353.385287 seconds. % 5e6
```

```
Elapsed time is 867.254197 seconds. % 1e7
```



修改后的函数：

```matlab
tic
for i = 1:10
    a = 1:1e7;
    result = selfIsprime(a);
end
toc
```

```
Elapsed time is 323.632929 seconds. % 5e6
```

```
Elapsed time is 728.005377 seconds. % 1e7
```







<br>

**References**

[1] 

