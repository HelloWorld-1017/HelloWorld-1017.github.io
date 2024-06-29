---
layout: single
title: Machine Representation of Decimal Integers
date: 2023-04-24 17:08:03 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Numerical Analysis
 - MATLAB Language Fundamentals
---

# Introduction

博客 [1] 记录了关于十进制数（包括整数、小数）的**浮点数表示方法**以及**浮点数的机器表示方法**，小数的存在加大了保存和处理的难度，使得必须人为规定一些公认的规则，IEEE 754标准就是做了这样一件事情。如果只是想存储**整数**，那么就简单很多。相比于浮点数的保存，整数的保存：

- 不需要考虑精度，两个相邻整数之间的距离始终是1；
- 不涉及尾数位；
- 没有标准化（即主导数位必须是1）的浮点数表示格式；
- 没有截断和舍入的规则；
- 没有用于保存指数位的指数偏差规则；同时不用考虑异常浮点数字（非标准浮点数字，即$\mathrm{-Inf}$，$\mathrm{+Inf}$，$\mathrm{nan}$）的处理；

大多数编程语言都会提供相应的整数类型变量，例如MATLAB提供的integer数据类型有 [2]：

![image-20230422145327359](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230422145327359.png?raw=true)

在MATLAB中，使用`num2hex`函数可以查看浮点数的十六进制机器表示法，例如：

```matlab
>> num2hex(single(10))
ans =
    '41200000'
```

```matlab
>> num2hex(double(10))
ans =
    '4024000000000000'
```

但是`num2hex`函数是不接受整型输入的，只能接受浮点数输入：

```matlab
>> num2hex(int8(10))
Error using num2hex
Inputs must be floating point, and may not be of class int8.
```

我们可以查看`dec2bin`函数 [3] 查看整型的二进制表示法。例如：

```matlab
>> dec2bin(int8(10),8)
ans =
    '00001010'
```

```matlab
>> dec2bin(int8(-10),8)
ans =
    '11110110'
```

可以看到，在MATLAB中采用了**补码**的方式来编码负数 [4-7]。

<br>

# True Form, 1’s Complement Code and 2’s Complement Code

如果在编码负数时，将第一位作为符号位，其余位为表示位，则这种方式得到的二进制码称为**原码（true form）**。仍以8位整型$+10$和$-10$为例：

$$
\begin{split}
+10=[0000\ 1010]_{\text{原}}\\
-10=[1000\ 1010]_{\text{原}}\\
\end{split}\notag
$$

**反码（1’s Complement Code）**：正数的反码和其原码一致；负数的反码是在原码的基础上**符号位不变，其余的位数取反**：

$$
\begin{split}
&+10=[0000\ 1010]_{\text{反}}\\
&-10=[1111\ 0101]_{\text{反}}\\
\end{split}\notag
$$

**补码（2’s Complement Code）**：正数的补码和其原码一致；负数的补码为其反码+1：

$$
\begin{split}
&+10=[0000\ 1010]_{\text{补}}\\
&-10=[1111\ 0110]_{\text{补}}\\
\end{split}\notag
$$

最终，我们可以得到正整数和负整数的三种表示形式：

$$
\begin{split}
&+10=[0000\ 1010]_{\text{原}}=[0000\ 1010]_{\text{反}}=[0000\ 1010]_{\text{补}}\\
&-10=[1000\ 1010]_{\text{原}}=[1111\ 0101]_{\text{反}}=[1111\ 0110]_{\text{补}}\\
\end{split}\notag
$$


在计算机中，是使用补码进行编码。不使用原码进行编码是因为对于计算机而言，“辨别符号位”这一过程非常复杂，人们想要让符号位也参与计算。但是如果使用原码进行计算，则：

$$
\begin{split}
10+(-10)&=[0000\ 1010]_{\text{原}}+[1000\ 1010]_{\text{原}}\\
&=[1001\ 0100]=-20
\end{split}\notag
$$

这显然是不对的。

如果使用反码进行计算：

$$
\begin{split}
10+(-10)&=[0000\ 1010]_{\text{反}}+[1111\ 0101]_{\text{反}}\\
&=[1111\ 1111]_{反}\\
&=[1000\ 0000]_{\text{原}}=-0
\end{split}\notag
$$

会出现$-0$的编码。另一方面：

$$
[0000\ 0000]_{\text{反}}=+0\notag
$$

此时，有两个$0$（即$+0$和$-0$）存在。

如果使用补码进行计算：

$$
\begin{split}
10+(-10)&=[0000\ 1010]_{\text{补}}+[1111\ 0110]_{\text{补}}\\
&=[1\ 0000\ 0000]_{\text{补}}
\end{split}\notag
$$

**丢掉溢出的最高位后**：

$$
[0000\ 0000]_{\text{补}}=[0000\ 0000]_{\text{原}}=0\notag
$$

注：因为以$0$开头编码是正数，正数的补码就是其本身。
{: .notice--primary}

此时就只有一个$0$，不会出现$-0$的情况。

另一方面，**在使用补码的情况下**，就可以**规定**$[1000\ 0000]_{\text{补}}$为$-128$：

$$
\begin{split}
&(-127)+(-1)=[1000\ 0001]_{补}+[1111\ 1111]_{补}=[1\ 1000\ 0000]\equiv-128
\end{split}\notag
$$

```matlab
>> dec2bin(int8(-128),8)
ans =
    '10000000'
```

因此，补码的使用在避免出现了$-0$的情况下，还扩展了负数的范围。

<br>

**References**

[1] [Floating Point Representation and Machine Representation of Decimal Digits (IEEE 754 Standards) - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Floating-Point-Arithmetic/).

[2] [Integers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/integers.html).

[3] [dec2bin - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/dec2bin.html).

[4] [计算机中正数与负数的存储方式 - 爱吃鱼的Mia喵的博客 - CSDN博客](https://blog.csdn.net/qq_42001403/article/details/100142480).

[5] [原码、反码、补码的产生、应用以及优缺点有哪些？ - 李俊达的回答 - 知乎](https://www.zhihu.com/question/20159860/answer/71256667).

[6] [什么是原码，1’s Complement Code反码和2’s Complement Code补码 - Punch Man的博客 - CSDN博客](https://blog.csdn.net/qq_41523462/article/details/120585204).

[7] [1's and 2's complement of a Binary Number - GeeksforGeeks](https://www.geeksforgeeks.org/1s-2s-complement-binary-number/).
