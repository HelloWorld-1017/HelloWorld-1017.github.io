---
layout: single
title: Char type and Char string type of C Language
date: 2022-09-11 14:36:37 +0800
categories: 
 - C
---

# Char type

char类型用于存储字符（eg 字母或标点符号），但从技术层面上看，char是整数类型。因为char类型实际上存储的是整数而不是字符，计算机使用数字编码来处理字符，即用特定的整数表示特定的字符，例如美国最常用的编码方式ASCII码。标准ASCII码的范围是0~127，只需要7位二进制数表示即可，但是**char类型被定义为8位的存储单元**。C语言把1字节(byte)定义为char类型占用的位(bit)数，即8位。

char类型变量的声明和初始化的基本语法为：`char grade = 'A';`。另外需要注意的是，`char grade = "A";`是错误的，因为char类型不能使用双引号，只能用单引号，`“A”`是一个字符串。

<br>

# Char string type

字符串(character string)是一个或多个字符的序列，如：`“Hello, world!”`。双引号不是字符串的一部分，双引号仅告知编译器它括起来的是字符串，正如单引号用于标识单个字符一样。C语言没有专门用于存储字符串的变量类型，字符串都被存储在char类型的数组中，数组由连续的存储单元组成，字符串中的字符被存储在相邻的存储单元，每个单元存储一个字符。

![image-20220911135023492](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220911135023492.png?raw=true)

数组(array)是同类型数据元素的有序序列，是一行连续的多个存储单元。
{: .notice--primary}

其中，`\0`是空字符(null character)，用于标记字符串的结束。

字符串的声明也是借助于char数组，如`char name[5]；`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220911135521348.png?raw=true" alt="image-20220911135521348" style="zoom: 80%;" />

但是在声明的时候，一定要留出1个byte的位置用于让计算机添加空字符，否则在打印的时候会出现乱码。如果初始化时，传入的字符串本身的长度（不包含双引号）就小于数组的长度，同样会出现乱码。出现这两种乱码的本质原因是一样的，都是char数组中没有预留出位置让计算机在使用`scanf()`函数读取输入时添加空字符，而空字符是C语言用于标记字符串结束的标志。计算机无法识别字符串是否结束，就会将该字符串地址后面的存储单元中的值也转换为字符打印出来，也就是乱码的部分。

测试代码：


```c
#include<stdio.h>

int main(void)
{	
	char name1[5] = "Tommy";
	char name2[4] = "Tommy";

	char name3[6] = "Tommy";
	char name4[] = "Tommy";

	printf("%s.\n%s.\n%s.\n%s.\n", name1, name2, name3, name4);
	return 0;
};
```


该代码不会报错，但是会出现乱码现象：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220911143930143.png?raw=true" alt="image-20220911143930143" style="zoom: 50%;" />

<br>

# The difference between `'x'` and `“x”`

字符串常量`“x”`和字符常量`‘x’`是不同的，区别之一就在于`‘x’`是基本类型(ie char)，而`“x”`是派生类型(ie char数组)；区别之二就是`“x”`实际上是由两个字符组成：`‘x’`和空字符`\0`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220911150728562.png?raw=true" alt="image-20220911150728562" style="zoom:50%;" />

<br>

**参考**

[1] Prata S. C Primer Plus(6th Edition)[M]. 姜佑, 译. 北京: 人民邮电出版社, 2018.
