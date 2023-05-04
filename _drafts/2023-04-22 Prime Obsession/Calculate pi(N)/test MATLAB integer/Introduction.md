Automatic Data Type Conversion and in MATLAB

# Introduction

在MATLAB中，浮点数有两种类型：默认的64位双精度浮点数（Double-Precision Floating Point）`double`，32位单精度浮点数（Single-Precision Floating Point）[1]；整数有8种类型，包含4种有符号整型以及4种无符号整型 [2]：

![image-20230504182703473](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230504182703473.png)

不同数字类型的变量在进行相互运算时，有时会存在自动类型转换，有时会报错；并且，相同的数字采用不同类型的变量来承载，计算速度也有所差距，本博客就简单地梳理一下这些内容。

<br>

# Automatic Data Type Conversion

双精度浮点数与单精度浮点数之间可以进行计算，并将结果自动转换为`single`类型：

```matlab
>> double(3.2)+single(3.2)
ans =
  single
    6.4000
```

```matlab
>> double(pi)+single(pi)
ans =
  single
    6.2832
```

另外，双精度的浮点数可以与任意的整数类型变量进行计算：

```matlab
>> double(7)+uint32(9)
ans =
  uint32
   16
```

结果转换为与整数相同的数据类型，并且遵从四舍五入的规则：

```matlab
>> double(7.2)+uint32(9)
ans =
  uint32
   16
```

```matlab
>> double(7.7)+uint32(9)
ans =
  uint32
   17
```

但是，单精度浮点数不能与任何类型的整数进行计算：

```matlab
>> single(7)+uint32(9)
Error using  + 
Integers can only be combined with integers of the same class, or scalar
doubles.
```

并且从这个报错信息中可以得知，不同类型的整数之间是不能进行运算的。例如：

```matlab
>> int8(3)+int16(3)
Error using  + 
Integers can only be combined with integers of the same class, or scalar
doubles.
```

总之，不同数字类型的变量的运算规则可以总结为：

![image-20230504215645036](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230504215645036.png)

<br>







<br>

**References**

[1] [Floating-Point Numbers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/floating-point-numbers.html).

[2] [Integers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/integers.html).