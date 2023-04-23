# Introduction

博客 [1] 记录了关于十进制数（包括整数、小数）的**浮点数表示方法**以及**浮点数的机器表示方法**，小数的存在加大了保存和处理的难度，使得必须人为规定一些公认的规则，IEEE 754标准就是做了这样一件事情。如果只是想存储**整数**，那么就简单很多。相比于浮点数的保存，整数的保存：

- 不需要考虑精度，两个相邻整数之间的距离始终是1；
- 不涉及尾数位；
- 没有标准化（即主导数位必须是1）的浮点数表示格式；
- 没有截断和舍入的规则；
- 没有用于保存指数位的指数偏差规则；
- 不用考虑异常浮点数字（非标准浮点数字，即$\mathrm{-Inf}$，$\mathrm{+Inf}$，$\mathrm{nan}$）的处理；

大多数编程语言都会提供相应的整数类型变量，例如MATLAB提供的integer数据类型有 [1]：

![image-20230422145327359](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230422145327359.png)

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

但是`num2hex`函数 [3] 是不接受整型输入的，只能接受浮点数输入：

```matlab
>> num2hex(int8(10))
Error using num2hex
Inputs must be floating point, and may not be of class int8.
```

但是可以查看`dec2bin`函数查看整型的二进制表示法。例如：

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

可以看到，在MATLAB中采用了**补码**的方式来编码负数 [4, 5]. 

<br>

# True Form, 1’s Complement Code and 2’s Complement Code

如果在编码负数时，将第一位作为符号位，其余位为表示位，则这种方式得到的二进制码称为**原码（true form）**。仍以8位整型$+10$和$-10$为例：
$$
\begin{split}
+10=[00001010]_{\text{原}}\\
-10=[10001010]_{\text{原}}\\
\end{split}
$$
**反码（1’s Complement Code）**：反码是用来处理负数的，是在原码的基础上**符号位不变，其余的位数取反**：
$$
\begin{split}
-10=[11110101]_{\text{反}}\\
\end{split}
$$
**补码（2’s Complement Code）**：正数的补码为它本身，而负数的补码为其反码+1：
$$
\begin{split}
-10=[11110110]_{\text{补}}\\
\end{split}
$$
最终，我们可以得到正整数和负整数的三种表示形式：
$$
\begin{split}
&+10=[00001010]_{\text{原}}\\
&-10=[10001010]_{\text{原}}=[11110101]_{\text{反}}=[11110110]_{\text{补}}\\
\end{split}
$$






在计算机中，正整数使用原码编码，而负数使用补码编码。

负数不适用原码是因为对于计算机而言，“辨别符号位”这一过程非常复杂，人们想要让符号位也参与计算。但是如果使用原码进行计算，则：
$$
\begin{split}
10+(-10)&=[00001010]_{\text{原}}+[10001010]_{\text{原}}\\
&=[10010100]=-20
\end{split}
$$
这显然是不对的。

如果使用负数的反码进行计算：
$$
\begin{split}
10+(-10)&=[00001010]_{\text{原}}+[11110101]_{\text{反}}\\
&=[11111111]_{反}\\
&=[10000000]_{\text{原}}=-0
\end{split}
$$
另一方面：
$$
[00000000]_{\text{原}}=+0
$$
此时，有两个$0$（即$+0$和$-0$）存在。

如果使用负数的补码计算：
$$
\begin{split}
10+(-10)&=[00001010]_{\text{原}}+[11110110]_{\text{补}}\\
&=[1\ 00000000]
\end{split}
$$
**丢掉超出的最高位后**，刚好是$00000000$，此时就只有一个$0$。

并且，此时我们可以定义$[10000000]$为$-128$：
$$
\begin{split}

&(-127)+(-1)=[10000001]_{补}+[11111111]_{补}=[1\ 10000000]\equiv-128
\end{split}
$$
因此，补码的使用在避免出现了$-0$的情况下，还扩展了负数的范围。

> 在使用原码表示时，最小能够表示的负数是$-127$：
> $$
> [11111111]_{原}=-127
> $$
> 
> $$
> &(-127)+(-1)=[11111111]_{原}+[10000001]_{原}=[1\ 10000000]_{原}=-0\\
> $$

<br>

**References**

[1] [Floating Point Representation and Machine Representation of Decimal Digits (IEEE 754 Standards) - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Floating-Point-Arithmetic/).

[2] [Integers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/integers.html).

[3] [dec2bin - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/dec2bin.html).

[4] [计算机中正数与负数的存储方式 - 爱吃鱼的Mia喵的博客 - CSDN博客](https://blog.csdn.net/qq_42001403/article/details/100142480).

[5] [原码、反码、补码的产生、应用以及优缺点有哪些？ - 李俊达的回答 - 知乎](https://www.zhihu.com/question/20159860/answer/71256667).

[6] [什么是原码，1’s Complement Code反码和2’s Complement Code补码 - Punch Man的博客 - CSDN博客](https://blog.csdn.net/qq_41523462/article/details/120585204).

[7] [1's and 2's complement of a Binary Number - GeeksforGeeks](https://www.geeksforgeeks.org/1s-2s-complement-binary-number/).
