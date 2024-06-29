---
layout: single
title: Automatically Generate C Language Code and Executable Programs for Simulink Models in MATLAB
date: 2022-08-05 16:22:29 +0800
categories: 
 - MATLAB 
tags:
 - MATLAB Simulink Coder
 - MATLAB Warnings and Errors
toc: true
---

# 自动生成 Simulink 模型的 C 语言代码

[Generate C Code for a Model](https://ww2.mathworks.cn/help/rtw/gs/model-and-simulation.html)

<br>

在命令行中输入

```matlab
open_system('rtwdemo_secondOrderSystem');
```

打开模型文件，之后将文件 rtwdemo_secondOrderSystem.slx 复制到新的工作文件夹中，使其成为可编辑状态。

打开复制后的模型文件：



<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220804223239437.png?raw=true"/>

这个 Simulink 模型模拟了一个理想的二阶质量-弹簧-阻尼(Mass-spring-damper)系统，系统方程为：
$$
m\ddot{x}+c\dot{x}+kx=f(t)\notag
$$
其中，$m$ 表示系统总质量，值为 $1.0\mathrm{e}-6\ (\mathrm{kg})$ ；$c$ 为阻尼系数，值为 $4.0\mathrm{e}-4\ (\mathrm{N\cdot s/m})$；$k$ 为弹簧系数，值为 $1.0\ (\mathrm{N/m})$；$f(t)$ 为 $x$ 方向上的外力方程，单位为 $\mathrm{N}$ 。

外力由 Signal Generator 模块施加，是一个幅值为 4 ，频率为 20 Hz 的方波：

![image-20220804225204370](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220804225204370.png?raw=true)



该模块使用 Simulation time 作为波形的时间变量。

⚠ 由于使用 code generation 需要模型的求解器是 **固定步长(fixed-step)** 求解器，因此模型在整个仿真过程中使用的都是固定的步长，为 0.001。

![image-20220804230516862](C:\Users\m\AppData\Roaming\Typora\typora-user-images\image-20220804230516862.png)

下面将通过四个步骤来简单地学习 C 语言代码和可执行程序的自动生成。

<br>

# Step1: 使用 Simulink Coder Quick Start Tool 生成 C 语言代码

[Generate C Code by Using Simulink Coder Quick Start Tool](https://ww2.mathworks.cn/help/rtw/gs/generate-code-by-using-simulink-coder-quick-start.html)

<br>

## 代码生成步骤

在 APPS 中点击 Simulink Coder

![image-20220804231351163](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220804231351163.png?raw=true)

打开 C Code tab

![image-20220804231504329](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220804231504329.png?raw=true)

之后点击 Quick Start 按钮，弹出配置对话框

![image-20220804232509632](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220804232509632.png?raw=true)

这里都使用默认配置，一直点击 Next 按钮即可，最后点击 Finish 按钮。

> ✏ 注 
>
> 一开始生成代码失败：
> ![image-20220804232935018](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220804232935018.png?raw=true)
>
> 报错信息：
>
> The default compiler, LCC, is not supported for XCP communication. 
>
> For information about compiler support, see https://www.mathworks.com/support/compilers/current_release
>
> <br>
>
> 一开始点开这个网址，我以为是因为电脑缺少 C 语言的编译器，但是下载了 MinGW 后仍然抛出相同的报错信息。之后仔细看了这个报错信息，其实是由于默认的编译器不支持 XCP 通信，只需要更改一下编译器即可。
>
> 打开模型的参数配置界面，可以看到默认的编译器：
>
> ![image-20220804233742348](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220804233742348.png?raw=true)将编译器改为
>
> ![image-20220804233825190](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220804233825190.png?raw=true)
>
> Apply 后 OK，之后便可成功生成代码。



自动生成代码后，模型的所在文件夹中会出现两个文件夹，分别是 `rtwdemo_secondOrderSystem_grt_rtw` 和 `slprj`：

![image-20220805105404265](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805105404265.png?raw=true)

## 自动生成文件夹的结构

### rtwdemo_secondOrderSystem_grt_rtw 文件夹

`rtwdemo_secondOrderSystem_grt_rtw` 文件夹中存放着模型的源代码，其中有两个主要的文件：`rtwdemo_secondOrderSystem.c` 和 `rtwdemo_secondOrderSystem.h`。

![image-20220805105346326](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805105346326.png?raw=true)

（1）**rtwdemo_secondOrderSystem.c**

`rtwdemo_secondOrderSystem.c` 文件中包含了算法代码，包括 ODE 求解器代码。



（2）**rtwdemo_secondOrderSystem.h**

调用方可通过 inclue 头文件  `rtwdemo_secondOrderSystem.h` 获得模型数据和入口函数(entry-point functions)。

`rtwdemo_secondOrderSystem.h` 文件中包含了模块输出(block outputs)、连续状态(continuous states)，模型输出(model output)，入口(entry points) 和时间数据(timing data)。

### slprj 文件夹

在 `./slprj/grt/_sharedutils`  文件夹中

![image-20220805110656835](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805110656835.png?raw=true)

头文件`rtwtypes.h` 定义了生成代码默认使用的标准数据类型(standard data types) 。

 `./slprj/grt/_sharedutils`  文件夹所包含的这些文件都是可以或者必须在多个模型之间分享的。



### 入口函数与模型接口

Simulink 模型所自动生成的代码包含了一系列的入口函数(entry-point functions)，这使得我们可以从外部应用调用模型源代码。比如，对于一个基于速率的模型(rate-baed model)，入口函数包含了初始化函数(initialization function)，执行函数(execution function)，终止和重置函数(terminate and reset functions)。这些函数提供了外部程序与模型之间的接口，用于交换数据。

在 `C Code tab` 中点击 `Open Report` 按钮， 在 `Code Interface Report` 中可以看到自动生成的入口函数

![image-20220805112814497](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805112814497.png?raw=true)

这里的三个入口函数都是 void-void 接口，即它们不传递参数。这些函数通过 shared data structures 来获得数据。

点击 Code Generation Report 左端菜单中 Code 下的 `rtwdemo_secondOrderSystem.c` 

![image-20220805113429772](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805113429772.png?raw=true)

查找入口函数 `secondOrderSystem_step` ，便可以看到该入口函数的定义

![image-20220805113711790](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805113711790.png?raw=true)

以及使用

![image-20220805114020492](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805114020492.png?raw=true)

之后，同样可以在 `rtwdemo_secondOrderSystem.h` 文件中进行查找

![image-20220805114200267](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805114200267.png?raw=true)

<br>

# Step2: 验证生成的可执行程序的结果

[Verify Generated Executable Program Results](https://ww2.mathworks.cn/help/rtw/gs/verify-whether-simulation-results-match-generated-executable-program-results.html?lang=en)

<br>

## 配置模型

### Dashboard Scope 模块

![image-20220805115954649](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805115954649.png?raw=true)

模型中的 Dashboard Scope 模块可以监视力 $f(t)$ 和位移 $X(t)$ 的变化曲线。

为了更好地显示曲线，我们需要对该模块进行配置。双击 Dashboard Scope 模块点开配置对话框

![image-20220805122400189](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805122400189.png?raw=true)

此时点击 Simulink 中的其他模块，配置选项卡中就会出现这信号，如果勾选，则该信号也会在 Dashboard Scope 显示出来。

![image-20220805122444805](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805122444805.png?raw=true)

之后设置纵坐标最大最小值

![image-20220805122840922](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805122840922.png?raw=true)

Apply 后 OK。

 ### Knob 模块

Knob 模块用于调节系统的阻尼系数

![image-20220805123057206](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805123057206.png?raw=true)

该模块的配置逻辑与 Dashboard Scope 模块类似。



### 配置 Code Generation

在 C Code tab 中依次点击

![image-20220805123412519](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805123412519.png?raw=true)

（1）为了使模型或者可执行程序能够将 workspace data 记录在 Simulation Data Inspector 中，需要进行以下配置：

![image-20220805124029043](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805124029043.png?raw=true)

（2）我们的目标是生成一个 executable program（不只是生成代码），因此需要保证 Code Generation 中的 Generate code only 选项没有被勾选

![image-20220805124404590](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805124404590.png?raw=true)

（3）为可执行程序配置 toolchain

![image-20220805124643494](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805124643494.png?raw=true)

之后，可以点击 Validate Toolchain 按钮，检查是否可用

![image-20220805124830075](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805124830075.png?raw=true)

（4）为了将数据保存在内存中，并且当可执行程序运行时能够获取到这些数据，我们需要配置一些参数。

为了高效执行模型的 C 代码，我们不需要为 **每一个** 参数，信号和状态都分配内存。如果模型算法在计算输出时不需要某个数据，为了优化运行， code generation 生成代码时就不会为该数据分配空间。但是在硬件原型设计时，我们有时候需要为这些数据分配存储空间，因此我们需要禁用一些 code generation optimization。

![image-20220805130014780](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805130014780.png?raw=true)

- 将 `Default paramater behavior` 设置为 `Tunable`。这样设置后，一些模块的参数，比如 Gain 模块的 Gain 参数在生成代码中就是 **可调的**。
- 不勾选 `Signal storage reuse`。如果不勾选，那么 code generator 就会为每一个信号都分配存储空间，当运行可执行程序时，我们可以监视这些信号的值。

（5） 配置 code generator，使其可以生成 nonfinite data，比如 NaN 和 Inf，和其他相关运算(related operations)。

![image-20220805141628359](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805141628359.png?raw=true)

确认 `Support non-finite numbers` 已被勾选。

（6）配置通信通道(communication channel)

为了使 Simulink 可以和由模型生成的可执行程序进行通信，模型必须包括对于通信通道的支持。本例子就使用基于 TCP/IP 协议的 XCP 协议作为传输层(transport layer)充当通信通道，需要进行以下配置：

![image-20220805142523356](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805142523356.png?raw=true)

（7）禁用 `MAT-file logging`

将数据从 MATLAB base workspace 加载到 Simulation Data Inspector 中。

![image-20220805142757665](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805142757665.png?raw=true)



## 运行仿真，查看结果

在 Simulation tab 中点击 Run 按钮进行仿真：

![image-20220805143208501](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805143208501.png?raw=true)

Run 按钮的右下角有一个小时钟，表明开启了 **simulation pacing**。simulation pacing 可以放慢仿真过程，使得我们可以观察到系统的行为，理解系统设计和识别设计问题，同时演示近实时行为(near real-time behavior)。

![image-20220805144135993](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805144135993.png?raw=true)

![image-20220805144124322](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805144124322.png?raw=true)

<br>

运行完毕之后，在 Simulation tab 中点击 Data Inspector：![image-20220805144529907](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805144529907.png?raw=true)

选中需要展示的信号：

![image-20220805144642981](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805144642981.png?raw=true)

将上述结果留在 Simulation Data Inspector 中，后面我们将会比较这些信号与可执行程序所生成的信号

## 构建并运行可执行程序，查看结果

创建并且运行可执行程序。

在 Hardware tab 中点击 Monitor & Tune：

![image-20220805145753638](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805145753638.png?raw=true)

之后，Simulink 就开始构建可执行程序，当出现 Code Generation Report 时，构建过程就完成了。

![image-20220805150006527](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805150006527.png?raw=true)

此时在当前文件夹就出现了可执行程序 `rtwdemo_secondOrderSystem.exe`。

![image-20220805150616869](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805150616869.png?raw=true)

> 生成 .exe 文件之后，官网提供了三种使用和部署的方式：
>
> - Deploys the executable program as a separate process on your development computer.
> - Connects the Simulink model to the executable program.
> - Runs the model executable program code.
>
> 但是并没有给出具体的使用方法





##  比较仿真和可执行程序的结果

>  使用 Simulation Data Inspector 比较仿真和可执行程序的结果。但是在这里我比较的是两次仿真的结果，因为我并没有找到使用 .exe 文件的方法。

在 Simulation Data Inspector 点击 Cmpare ，选择想要比较的数据。比如，选取两次仿真数据——在 Baseline 和 Compare to 中分别选取 `Run 5: rtwdemo_secondOrderSystem` 和 `Run 6: rtwdemo_secondOrderSystem`

![image-20220805152059813](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805152059813.png?raw=true)

两次仿真的参数并没有改变，输出的信号是一样的，但是 Simulation Data Inspector 判断的结果是 **mismatch**：

![image-20220805152449551](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805152449551.png?raw=true)

这是 Global Tolerance 设置得太小了，系统默认设置为0，这个限制太严格。我们可以点击右上角的 [+]More 按钮可以进行修改：

![image-20220805152648745](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805152648745.png?raw=true)

再次点击 Compare 

![image-20220805152707659](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805152707659.png?raw=true)



#  Step3: 在程序执行期间调整模型参数

> [Tune Parameter During Program Execution]([Tune Parameter During Program Execution - MATLAB & Simulink - MathWorks China](https://ww2.mathworks.cn/help/rtw/gs/run-time-execution-or-external-mode-simulation.html))
>
> - 本部分的模型配置与上一节模型的配置是一致的
>- 本部分的示例展示的是可执行程序在运行期间的参数调整，但是在前一步中，我没有找到使用 .exe 的程序的方法，因此这一部分还是针对仿真过程中的参数调整，也因此跳过了一些配置过程

在仿真运行期间，我们可以通过调整 Knob block 以调整阻尼系数的值，并通过 Dashboard scope 模块实时展示出来。

![image-20220805160301829](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805160301829.png?raw=true)



# Step4: 部署原型代码

[Deploy Prototype Code and Artifacts](https://ww2.mathworks.cn/help/rtw/gs/deploy-prototype-code-and-artifacts.html)

<br>

本部分是关于 Simulink 模型 C 语言代码的打包和发布

![image-20220805161950425](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220805161950425.png?raw=true)
