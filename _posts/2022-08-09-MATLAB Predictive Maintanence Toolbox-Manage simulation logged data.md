---
layout: single
title: 【MATLAB Predictive Maintenance Toolbox】Simulink 批量仿真以及使用 simulationEnsembleDatastore 管理仿真中记录的数据
date: 2022-08-09 21:31:07  +0800
categories:
 - Programming
tags: 
 - MATLAB
toc: true
---

<br>

# 建立模型

创建模型 model.slx，该模型含有两个信号源，分别是 Sine Wave 和 Cosine Wave

![image-20220809161111679](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809161111679.png)

它们的幅值和角频率分别由变量 `A1` 、`f1` 和 `A2` 、`f2` 控制，默认值在 `PreLoadFcn` 中进行设置。它们的波形经过 Plus 模块相加后，输出到 Sum 示波器中进行显示。



# 设置 Signal Logging

设置 Signal Logging ，设置方式见博客：[【MATLAB Simulink】设置 Signal Logging](http://whatastarrynight.com/programming/MATLAB-Simulink-Data-Logging/)

将正弦信号、余弦信号以及两者的合成信号都记录下来，并且分别命名为 `SineWave` ，`CosineWave` 和 `CompositeWave` 。

![image-20220809161707687](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809161707687.png)

![image-20220809161907262](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809161907262.png)



# 批量运行仿真：`generateSimulationEnsemble` 函数

使用脚本给变量 `A1` 、`f1` 和 `A2` 、`f2`  循环赋值，并使用 `generateSimulationEnsemble` 批量运行仿真：

```matlab
mdl = 'model';
open_system(mdl)

A1s = 3 : 0.5 : 5;
f1s = pi/4 : pi/12 : pi/2;
A2s = 7 : 0.5 : 9;
f2s = pi/3 : pi/6 : pi;

[A1Values, f1Values, A2Values, f2Values] = ndgrid(A1s, f1s, A2s, f2s);

for ct = numel(A1Values):-1:1
    in = Simulink.SimulationInput(mdl);

    in = in.setVariable('A1', A1Values(ct));
    in = in.setVariable('f1', f1Values(ct));
    in = in.setVariable('A2', A2Values(ct));
    in = in.setVariable('f2', f2Values(ct));

    gridSimulationInput(ct) = in;
end

if ~exist(fullfile(pwd,'Data'),'dir')
    mkdir(fullfile(pwd,'Data')) % Create directory to store results
end

runAll = true;
if runAll
    [ok,e] = generateSimulationEnsemble(gridSimulationInput, fullfile(pwd,'Data'),'UseParallel', false);
else
    [ok,e] = generateSimulationEnsemble(gridSimulationInput(1:10), fullfile(pwd,'Data'));
end

```

仿真运行中

![image-20220809163751150](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809163751150.png)



# .mat 仿真信息文件概览

运行完毕后，可以在当前文件夹中看到 Data 子文件夹，其中的 .mat 文件保存了每次仿真的运行信息

![image-20220809164336350](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809164336350.png)

每个 .mat 文件都包含了4个变量，分别是 `logsout` ， `PMSignalLogName`  ，`SimulationInput` ， `SimulationMetadata`：

![image-20220809164443223](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809164443223.png)

## `PMSignalLogName` 变量和 `logsout` 变量

变量 `logsout` ，保存了所记录信号的信息，并且该变量的名称保存在 `PMSignalLogName` 中

![image-20220809164558917](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809164558917.png)



## `SimulationInput` 变量

变量 `SimulationInput` 保存了仿真输入的信息

![image-20220809164743151](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809164743151.png)

其中，`SimulationInput.Variables` 中保存着变量 `A1` 、`f1` 和 `A2` 、`f2`  的值：

```matlab
>> SimulationInput.Variables(1)

ans = 

  Variable with properties:

           Name: 'A1'
          Value: 3
      Workspace: 'global-workspace'
    Description: ""

>> SimulationInput.Variables(2)

ans = 

  Variable with properties:

           Name: 'f1'
          Value: 0.7854
      Workspace: 'global-workspace'
    Description: ""

>> SimulationInput.Variables(3)

ans = 

  Variable with properties:

           Name: 'A2'
          Value: 7
      Workspace: 'global-workspace'
    Description: ""

>> SimulationInput.Variables(4)

ans = 

  Variable with properties:

           Name: 'f2'
          Value: 1.0472
      Workspace: 'global-workspace'
    Description: ""
```

## `SimulationMetadata` 变量

变量 `SimulationMetadata` 中保存着仿真的其他信息

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809165209339.png"/>



# 创建并读取 Simulation ensemble datastore

## 创建 ：`simulationEnsembleDatasotre()` 函数

函数 `simulationEnsembleDatasotre` 提供了一种批量管理、操作上述 .mat 文件的方式。

首先，创建 Simulation ensemble datastore：

```matlab
ens = simulationEnsembleDatastore(fullfile(pwd,'Data'));
```

之后查看 `ens` 中保存的变量

```matlab
>> ens.DataVariables

ans = 

  5×1 string array
    "CompositeWave"
    "CosineWave"
    "SimulationInput"
    "SimulationMetadata"
    "SineWave"
```

可以看到，变量 `SineWave` ，`CosineWave`，和 `CompositeWave` 从变量 `logsout` 中提取出来了，这一操作可能是 MATLAB 根据变量 `PMSignalLogName` 进行操作的。



## 读取：`read()` 函数

之后查看指定变量，并读取数据：

```matlab
ens.SelectedVariables = ["SineWave", "CosineWave", "CompositeWave"];
read(ens)

%--------------------------------------
  1×3 table

         SineWave             CosineWave          CompositeWave   
    __________________    __________________    __________________

    {5001×1 timetable}    {5001×1 timetable}    {5001×1 timetable}
```

⚠⚠⚠**注意**⚠⚠⚠

代码 `ens.SelectedVariables = ["SineWave", "CosineWave", "CompositeWave"];` 中不能使用单引号，否则会报错，无法运行。



## 重置：`reset()` 函数

上述 `ens = simulationEnsembleDatastore()` 的操作并没有把所有的数据都放入到一个表中（这么做会占取大量的电脑资源），它只是创建了一个索引表：

![image-20220809172046736](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809172046736.png)

其中，`ens.Files` 保存了 .mat 文件的文件名（BTW，文件并不是按照1~500的顺序排列，而是按照拼写排序，但这在大多数情况下并不影响操作）

![image-20220809172304850](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809172304850.png)

变量 `ens.LastMemberRead` 中保存了最后一次读取的文件，相当于是一个 cursor。

当 `ens` 刚刚创建时，`ens.LastMemberRead` 是一个空字符串：

```matlab
>> ens.LastMemberRead

ans = 

  0×0 empty string array
```

之后，**每使用一次 `read(ens)` 操作**，`ens.LastMemberRead`都会变化，按照 `ens.Files` 向下读取。

这样的程序设置有一定的便利性，但是有时候会产生一些预期之外的结果。因此，在一些场景下，比如想要使用 `for` 循环对每一个文件都进行相同的操作，而为了保证遍历到每一个 .mat 文件，需要在循环前进行 `reset(ens)` 。

⚠注意： `reset()` 函数并不会重置 `ens.SelectedVariables` 。



# 借助 ens 向 .mat 文件写入数据：`writeToLastMemberRead` 函数

## 写入单个文件

现在，我们的 .mat 文件的内容是这样的：

![image-20220809173859355](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809173859355.png)

`ens.DataVariables` 有这些：

```matlab
>> ens.DataVariables

ans = 

  5×1 string array
    "CompositeWave"
    "CosineWave"
    "SimulationInput"
    "SimulationMetadata"
    "SineWave"
```

我们想要进行下面几个简单的操作

（1）在 .mat 文件中把变量 `SineWave` ，`CosineWave` 和 `CompositeWave` 从 `logsout` 提取出来；

（2）把每个仿真文件中的 `CompositeWave` 的最大值提取出来，将其保存在变量 `Maximum` 中，并将其返回到 .mat 文件中；

（3）将仿真输入参数 `A1` 、`f1` 和 `A2` 、`f2`  从变量 `SimulationInput` 中提取出来；



### 提取仿真输出信号

```matlab
%% Extract three logged signal
reset(ens)
ens.SelectedVariables = ["SineWave", "CosineWave", "CompositeWave"];
data = read(ens);
sinewave = data.SineWave{1};
cosinewave = data.CosineWave{1};
compositewave = data.CompositeWave{1};

% Add values
addData = table({sinewave}, {cosinewave}, {compositewave}, ...
    'VariableNames',{'SineWave', 'CosineWave', 'CompositeWave'});
writeToLastMemberRead(ens, addData);
```

此时，.mat 文件中保存的数据：

![image-20220809184516061](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809184516061.png)



### 提取 `CompositeWave` 最大值

```matlab
%% Extract maximum value of the composite signal
reset(ens)

% Extract the maximum value
ens.SelectedVariables = "CompositeWave";
data = read(ens);
compositewave = data.CompositeWave{1};
Maximum = max(compositewave.Data);

% Add new variable
ens.DataVariables = [ens.DataVariables; "Maximum"];

% Add correspongding value
addData = table(Maximum, 'VariableNames', "Maximum");

writeToLastMemberRead(ens, addData);
```

此时，.mat 文件中保存的数据：

![image-20220809185353073](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809185353073.png)

### 提取仿真输入参数

```matlab
%% Extract input parameters
reset(ens)

ens.SelectedVariables = "SimulationInput";
data = read(ens);

vars = data.SimulationInput{1}.Variables;
idx = strcmp({vars.Name},'A1');
A1 = vars(idx).Value;

idx = strcmp({vars.Name},'f1');
f1 = vars(idx).Value;

idx = strcmp({vars.Name},'A2');
A2 = vars(idx).Value;

idx = strcmp({vars.Name},'f2');
f2 = vars(idx).Value;

% Add new variable
ens.DataVariables = [ens.DataVariables; "A1"; "f1"; "A2"; "f2"];

% Add corresponding value
addData = table(A1, f1, A2, f2, 'VariableNames', {'A1', 'f1', 'A2', 'f2'});

writeToLastMemberRead(ens, addData);
```

此时，.mat 文件中保存的数据：

![image-20220809200524997](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809200524997.png)



## 批量写入

上述过程只是对第1个 .mat 文件进行操作：

![image-20220809200658430](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809200658430.png)

不涉及其他文件：
![image-20220809200819844](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220809200819844.png)

可以将上述过程封装成 `preparedata` 函数，并写作循环形式，对每一个 .mat 文件进行操作：

```matlab
clc, clear

% Create ensemble
ens = simulationEnsembleDatastore(fullfile(pwd,'Data'));

ens.SelectedVariables = ["SineWave", "CosineWave", "CompositeWave", "SimulationInput"];

% Add new variable
ens.DataVariables = [ens.DataVariables; "Maximum"; "A1"; "f1"; "A2"; "f2"];


reset(ens);

while hasdata(ens)
    data = read(ens);
    addData = prepareData(data);
    writeToLastMemberRead(ens, addData)
end


function addData = prepareData(data)
sinewave = data.SineWave{1};
cosinewave = data.CosineWave{1};
compositewave = data.CompositeWave{1};


Maximum = max(compositewave.Data);

vars = data.SimulationInput{1}.Variables;
idx = strcmp({vars.Name},'A1');
A1 = vars(idx).Value;

idx = strcmp({vars.Name},'f1');
f1 = vars(idx).Value;

idx = strcmp({vars.Name},'A2');
A2 = vars(idx).Value;

idx = strcmp({vars.Name},'f2');
f2 = vars(idx).Value;

% The table of additional values
addData = table({sinewave}, {cosinewave}, {compositewave}, Maximum, A1, f1, A2, f2, ...
    'VariableNames',{'SineWave', 'CosineWave', 'CompositeWave', 'Maximum', 'A1', 'f1', 'A2', 'f2' });

end
```

运行即可。

## 总结

总结上述写入操作的步骤：

1. 根据已有的多个 .mat 文件，使用 `simulationEnsembleDatastore()` 创建 `ens`；
2. 设置 `ens.SelectedVariables` ，选取后续操作需要用到的 **已有** 变量；
3. 使用 `data=read(ens)` 读取 .mat 文件的内容；
4. 对读取到的数据进行处理和操作，包括类似 <u>信号预处理</u>、<u>特征提取</u> 等操作；
5. 使用类似 `ens.DataVariables = [ens.DataVariables; "Maximum"; "A1"];` 为 `ens` 添加 **新增** 变量；
6. 创建包含新增变量及其值的 table，`addData = table({XX},{XX},XX,XX,'VariableNames', {'XX','XX','XX','XX'});`；
7. 将 `addData` 写入 .mat 文件：`writeToLastMemberRead(ens, addData)`



<br>

⚠⚠⚠ 注意 ⚠⚠⚠

上述过程中创建 ensemble 时都使用的是 `ens=simulationEnsembleDatastore()` ，这个函数是处理Simulink 仿真中产生的数据构成的 .mat 文件。其他类型的 .mat 文件也可以用类似的工作流进行管理，但是需要使用 `fensemble = fileEnsembleDatastore()` 创建 ensemble，并且需要自定义 `fensemble.ReadFcn` 函数和 `fensemble.WriteToMemberFcn` 函数，例如：

```matlab
% set custom ReadFcn & WriteToMemberFcn function
fensemble.ReadFcn = @readData;
fensemble.WriteToMemberFcn = @writeNewData;
```

详见：[fileEnsembleDatastore - MathWorks](https://ww2.mathworks.cn/help/predmaint/ref/fileensembledatastore.html).

<br>

**参考**

[1]  [simulationEnsembleDatastore - MathWorks](https://ww2.mathworks.cn/help/predmaint/ref/simulationensembledatastore.html).

[2] [Using Simulink to Generate Fault Data - MathWorks](https://ww2.mathworks.cn/help/predmaint/ug/Use-Simulink-to-Generate-Fault-Data.html).

