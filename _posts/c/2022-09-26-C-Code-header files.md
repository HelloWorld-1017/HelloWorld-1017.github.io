---
title: C code, Header files
categories:
 - C
date: 2022-09-26 19:04:03 +0800
---

# Introduction

当预处理器发现`#include`命令时，会查看后面的文件名，并把文件的内容包含到当前文件中，替换掉源文件中的`#include`命令。这相当把被包含文件的**全部内容**输入到源文件`#include`指令所在的位置。

`#include`指令有两种形式：

```c
#include <stdio.h>     //文件包含在尖括号中
#include "mystuff.h"   //文件在双引号中
```

在UNIX系统中：

- 尖括号告诉预处理器在**标准系统目录**中查找该文件；
- 双引号告诉预处理器**首先**在**当前目录**中（或**文件名中指定的其他目录**）查找该文件，如果未找到再查找**标准系统目录**。

```c
#include <stdio.h>       //查找系统目录
#include "hot.h"         //查找当前工作目录
#include "/usr/biff/p.h" //查找/user/biff目录
```

在UNIX系统中，使用双引号表示首先查找本地目录，但是具体查找哪个目录取决于编译器的设定，有些编译器会搜索**源代码文件所在目录**，有些编译器则搜索**当前工作目录**，有些搜索**项目文件所在目录**。

集成开发环境（IDE）也有标准路径或系统头文件的路径。许多集成开发环境提供菜单选项，指定用尖括号时的查找路径。

上面的描述表明，ANSI C并不为文件提供统一的目录模型，因为不同的计算机所用的系统不同。一般而言，命名文件的方法因系统而异，但是尖括号和双引号的规则与系统无关。

<br>

# Why Use Header Files?

为什么要包含头文件？因为编译器需要这些文件中的信息。例如，`stdio.h`文件中通常包含`EOF`、`NULL`、`getchar()`和`putchar()`的定义。`getchar()`和`putchar()`被定义为宏函数。此外，该文件中还包含C的其他I/O函数。

C语言系统用.h后缀表示头文件，这些文件包含需要放在程序顶部的信息。头文件经常包含一些预处理器指令。

包含一个大型头文件不一定显著增加程序的大小。在大部分情况下，**头文件的内容是编译器生成最终代码时所需的信息**，**而不是添加到最终代码中的材料**。

<br>

# Example

比如开发一个存放人名的结构，还编写了一些使用该结构的函数，我们就可以把不同的**声明**放在头文件中。

例如，创建一个头文件`names_st.h`：

```c
//names_st.h -- names_st 结构的头文件
//常量
#include <string.h>
#define SLEN 32

//结构声明
struct names_st
{
    char first[SLEN];
    char last[SLEN];
};

//类型定义
typedef struct names_st names;

//函数原型
void get_names(names *);
void show_names(const names *);
char * s_gets(char * st, int n);
```

该头文件包含了一些头文件中常见的内容：#define指令、结构声明、`typedef`和函数原型。为了简单起见，这个特殊的头文件过于简单。通常，应当使用`#ifndef`和`#define`防止多重包含头文件。

注意：这些内容是编译器在创建可执行代码时所需的信息，而**不是可执行代码**。
{: .notice--warning}

可执行代码通常在源代码文件中，而不是头文件中。下面的`name_st.h`源代码文件中就包含了`names_st.h`头文件，因此编译器知道变量`names`的类型：

```c
// name_st.c -- 定义 names_st.h中的函数
#include <stdio.h>
#include "names_st.h"

//函数定义
void get_names(names * pn)
{
    printf("Please enter your fist name:");
    s_gets(pn->first, SLEN);

    printf("Please enter your last name:");
    s_gets(pn->last, SLEN);
}

void show_names(const names * pn)
{
    printf("%s %s", pn->first, pn->last);
}

char * s_gets(char * st, int n)
{
    char * ret_val;
    char * find;

    ret_val = fgets(st, n, stdin);
    if (ret_val)
    {
        find = strchr(st, '\n');    //查找换行符
        if (find)                          //如果地址不是NULL
            *find = '\0';                  //在此处放置一个空字符
        else
            while (getchar() != '\n')
                continue;
    }
    return ret_val;
}
```

之后，创建下面的`useheader.c`源代码文件：

```c
// useheader.c -- 使用 names_st 结构

#include <stdio.h>
#include "names_st.h"

int main(void)
{
    names candidate;

    get_names(&candidate);
    printf("Let's welcome ");
    show_names(&candidate);
    printf(" to this program!\n");
    return 0;
}
```
运行：
```
Please enter your fist name:Tommy
Please enter your last name:Shelby
Let's welcome Tommy Shelby to this program!
```

该程序需要注意以下几点：

- 两个源代码文件`name_st.h`和`useheader.c`都是用`names_st`类型结构，所以它们都必须包含`names_st.h`头文件；
- 必须编译和链接`names_st.c`和`useheader.c`源代码文件；
- 这个示例这是一个很经典的例子：声明和指令放在`nems_st.h`头文件中，函数定义放在`names_st.c`源文件中，主程序放在`useheader.c`文件中。

**参考**

[1] Prata S. C Primer Plus(6th Edition)[M]. 姜佑, 译. 北京: 人民邮电出版社, 2018.

