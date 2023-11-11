# Programming Mechanics

用C语言编写程序时，编写的内容都被存储在文本文件当中，该文件被称为源代码文件（source code file），大部分的C系统中， 都要求文件名以`.c`为扩展名（extension）。

C语言编程的基本策略是，用程序将源代码转换为可执行文件（executable file），其中包含可直接运行的机器语言代码（ready-to-run machine language code）。典型的C实现都通过编译（compiling）和链接（linking）两个步骤来完成这一过程。编译器（compiler）把源代码转换成中间代码（intermediate code），链接器（linker）把中间代码和其他代码合并，生成可执行文件。

![image-20230504102116420](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230504102116420.png)

C使用这种方式对程序进行模块化处理，可以独立编译单独的模块，稍后再用链接器合并已编译的模块。通过这种方式，如果只是更改其中某个模块，就不必因此重新编译其他模块。除此之外，连接器还将我们编写的程序和预编译的库代码（precompiled library code）合并。

中间代码有很多形式，其中最普遍的一种形式是将源代码转化成机器语言代码（machine language code），并把结果放在目标(代码)文件（object code file, or object file）中（假设源代码只有一个文件）。虽然目标文件中包含机器语言代码，但是并不能直接运行该文件。因为目标文件中存储的是编译器翻译的源代码，这还不是一个完整的程序。

第一，目标代码文件中缺失启动代码（start-up code）。启动代码充当着程序和操作系统之间的接口。例如，我们都可以在MS Windows或者Linux系统下运行IBM PC兼容机，在这两种情况下，**计算机的硬件相同，所以目标代码相同**，但是**Windows和Linux系统所需的启动代码不同**，因为这些系统处理程序的方式不同。

第二，目标代码中还缺少库函数（library routines）。几乎所有的C程序都要使用C标准库（standard C library）中的函数（routines，or functions）。例如，我们常常在C程序中使用的`printf()`函数。目标文件中并不包含该函数的代码，它只包含了使用`printf()`函数的指令（instructions）。`printf()`函数真正的代码储存在一个被称为库（library）的文件中。库文件中有许多函数的**目标代码（object code）**。链接器的作用就是把我们所编写的目标代码、系统的标准启动代码和库代码这三个部分都合并为一个文件，即可执行文件。对于库代码，**链接器只会把程序中要用到的库函数代码提取出来**。

总之，目标文件和可执行文件都是由机器语言指令（machine language instructions）组成的。然而，目标文件中只包含编译器为我们所编写的代码翻译的机器语言代码；可执行文件中还包含我们所编写的程序中使用的库函数和机器代码。

在有些系统中，必须分别运行编译程序（compile programs）和链接程序（link programs），而在另外一些系统中，编译器会自动启动链接器，用户只需要给出编译指令即可。

<br>

# UNIX System

C语言因UNIX系统而生，也因此流行。

## Editing on a Unix System

UNIX C没有自己的编辑器（editor），但是我们可以使用通用的UNIX编辑器，如emacs、jove、vi或者X Window System文本编辑器。

作为程序员，第一要负责输入正确的程序，第二要为储存该程序的文件起一个合适的文件名，例如`inform.c`。

注：UNIX区分大小写，因此`inform.C`不是有效的文件名，因为该文件名使用了大写的C而不是小写的c。
{: .notice--primary}

假如我们在vi编辑器中编写了下面的程序，并将其存储在`inform.c`源文件中：

```c
#include <stdio.h>
int main (void)
{
    printf("A .c is used to end a C program filename.\n");
    return 0;
}
```

注意，源文件是整个编译过程的开始，而不是结束。

## Compiling on a Unix System

虽然在我们看来，程序完美无缺，但是对计算机而言，这就是一堆乱码。计算机是不明白其中的`#include`和`printf`是什么意思。如前文所述，我们需要编译器将我们所编写的代码（源代码）翻译成机器可以理解的代码（机器代码）。**最后生成的可执行文件中包含计算机要完成任务所需的所有机器代码。**

在以前，我们可以使用`cc`命令来调用UNIX C编译器。但是，UNIX C编译器没有跟上C语言标准发展的脚步，已经退出了历史舞台。但是，UNIX系统提供的C编译器通常来自于一些其他的源，仍然以`cc`命令作为编译器的别名。因此，虽然在不同的系统中会调用不同的编译器，但是用户仍然可以使用相同的命令。

要编译`inform.c`，要输入以下命令：

```bash
cc inform.c
```

几秒种后，会返回UNIX的提示，告诉用户任务已完成。如果使用`ls`命令列出文件，我们会发现一个`a.out`的文件，该文件是包含已编译程序的可执行文件。

![image-20230504112620682](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230504112620682.png)

要运行该文件，只需要输入：

```bash
a.out
```

即可。之后，我们可以得到以下的输出内容：

```
A .c is used to end a C program filename.
```

如果要存储可执行文件`a.out`，我们应该把它重命名。否则，该文件会被下一次编译程序时所生成的`a.out`文件替换。

在上面的过程中，我们可以意识到“编译”的步骤自动启动了链接的步骤。那么，在“链接”步骤前的目标代码在哪里呢？实际上在整个过程中，C编译器会创建一个与源代码基本名（basename）相同的目标代码文件，但是它的扩展名为`.o`。在上面这个例子中，目标代码文件是`inform.o`，然而我们找不到这个文件。这是因为一旦链接器生成了完整的可执行程序，就会将其删除；而如果原始程序有多个源代码文件，则会保留目标代码文件（这么做是有其意义的）。

<br>

GNU项目（GNU's Not UNIX）始于1987年，是一个开发大量免费UNIX软件的集合。GNU编译器集合（也被称为GCC，即GNU Compiler Collection）是该项目的产品之一，其中包含GCC C编译器。GCC在一个指导委员会的带领下持续不断地发展，它的C编译器紧跟C标准的改动。GCC有各种版本以适应不同的硬件平台和操作系统，包括UNIX、Linux和Windows。使用`gcc`命令就可以调用GCC C编译器。许多使用`gcc`的系统都用`cc`作为`gcc`的别名。

LLVM项目（Low Level Virtual Machine）是`cc`的另一个替代品。该项目是**与编译器相关的开源软件集合**，始于伊利诺斯大学的研究项目，其中的Clang编译器用于处理C代码，可以通过`clang`命令调用，并且有多种版本供不同的平台使用。在2012年，Clang成为FreeBSD（一种类UNIX操作系统）的默认C编译器，并且Clang也对最新的C标准支持得很好。

用户均可以使用别名`cc`来代替GNU的`gcc`或者LLVM的`clang`命令。

<br>

# Linux System

