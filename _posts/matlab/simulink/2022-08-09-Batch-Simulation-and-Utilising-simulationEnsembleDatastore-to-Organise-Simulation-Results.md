---
title: Realize Batch Simulation and Use `simulationEnsembleDatastore` to Organize Simulation Results in MATLAB Simulink
categories:
 - MATLAB
tags:
 - MATLAB Predictive Maintenance Toolbox
date: 2022-08-09 21:31:07 +0800
last_modified_at: 2024-10-23 19:22:30 +0800
---

# 建立模型

创建模型 model.slx，该模型含有两个信号源，分别是 Sine Wave 和 Cosine Wave

![image-20220809161111679](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809161111679.png?raw=true)

它们的幅值和角频率分别由变量 `A1` 、`f1` 和 `A2` 、`f2` 控制，默认值在 `PreLoadFcn` 中进行设置。它们的波形经过 Plus 模块相加后，输出到 Sum 示波器中进行显示。

<br>

# 设置 Signal Logging

设置 Signal Logging ，设置方式见博客：[【MATLAB Simulink】设置 Signal Logging](http://whatastarrynight.com/programming/MATLAB-Simulink-Data-Logging/)

将正弦信号、余弦信号以及两者的合成信号都记录下来，并且分别命名为 `SineWave` ，`CosineWave` 和 `CompositeWave` 。

![image-20220809161707687](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809161707687.png?raw=true)

![image-20220809161907262](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809161907262.png?raw=true)

<br>

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

![image-20220809163751150](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809163751150.png?raw=true)

<br>

# .mat 仿真信息文件概览

运行完毕后，可以在当前文件夹中看到 Data 子文件夹，其中的 .mat 文件保存了每次仿真的运行信息

![image-20220809164336350](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809164336350.png?raw=true)

每个 .mat 文件都包含了4个变量，分别是 `logsout` ， `PMSignalLogName`  ，`SimulationInput` ， `SimulationMetadata`：

![image-20220809164443223](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809164443223.png?raw=true)

## `PMSignalLogName` 变量和 `logsout` 变量

变量 `logsout` ，保存了所记录信号的信息，并且该变量的名称保存在 `PMSignalLogName` 中

![image-20220809164558917](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809164558917.png?raw=true)



## `SimulationInput` 变量

变量 `SimulationInput` 保存了仿真输入的信息

![image-20220809164743151](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809164743151.png?raw=true)

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

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809165209339.png?raw=true"/>

<br>

# 创建并读取 Simulation ensemble datastore

## 创建 ：`simulationEnsembleDatastore()` 函数

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

![image-20220809172046736](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809172046736.png?raw=true)

其中，`ens.Files` 保存了 .mat 文件的文件名（BTW，文件并不是按照1~500的顺序排列，而是按照拼写排序，但这在大多数情况下并不影响操作）

![image-20220809172304850](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809172304850.png?raw=true)

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

<br>

# 借助 ens 向 .mat 文件写入数据：`writeToLastMemberRead` 函数

## 写入单个文件

现在，我们的 .mat 文件的内容是这样的：

![image-20220809173859355](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809173859355.png?raw=true)

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

![image-20220809184516061](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809184516061.png?raw=true)



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

![image-20220809185353073](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809185353073.png?raw=true)

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

![image-20220809200524997](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809200524997.png?raw=true)



## 批量写入

上述过程只是对第1个 .mat 文件进行操作：

![image-20220809200658430](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809200658430.png?raw=true)

不涉及其他文件：

![image-20220809200819844](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809200819844.png?raw=true)

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

# 删除变量

## 问题

现在，.mat 文件中保存的变量：

```matlab
>> whos('-file', 'model_log_1.mat')

  Name                    Size             Bytes  Class                        

  A1                      1x1                  8  double                                       
  A2                      1x1                  8  double                                       
  CompositeWave            -               81303  timetable                                    
  CosineWave               -               81303  timetable                                    
  Maximum                 1x1                  8  double                                       
  PMSignalLogName         1x7                 14  char                                         
  SimulationInput         1x1               1061  Simulink.SimulationInput                     
  SimulationMetadata      1x1               6632  Simulink.SimulationMetadata                  
  SineWave                 -               81303  timetable                                    
  f1                      1x1                  8  double                                       
  f2                      1x1                  8  double                                       
  logsout                 1x1             244801  Simulink.SimulationData.Dataset    
```

假如我们想要删除每一个 .mat 文件中的 `A1` 、`f1` 、`A2` 、`f2` 应该怎么做呢？

目前，我还没有找到很好的官方办法，但是大概知道问题出现在哪里。

## 基于数据文件创建 ensemble 的一般化方法：`ens = fileEnsembleDatastore`

上述过程中创建 ensemble 时都使用的是 `ens = simulationEnsembleDatastore()` ，这个函数是处理Simulink 仿真中产生的数据构成的 .mat 文件。由于处理的是固定类型的数据，它的灵活性就较低，不支持用户自定义读取函数和写入函数。

如果我们想使用类似的工作流管理其他类型的 .mat 文件，则需要使用 `fensemble = fileEnsembleDatastore()` 创建 ensemble，此时我们可以也必须自定义 `fensemble.ReadFcn` 函数和 `fensemble.WriteToMemberFcn` 函数，例如：

```matlab
% set custom ReadFcn & WriteToMemberFcn function
fensemble.ReadFcn = @readData;
fensemble.WriteToMemberFcn = @writeNewData;
```

而官方提供的一个 `writeNewData` 函数为：

```matlab
function writeNewData(filename,data)
save(filename, '-append', '-struct', 'data');
end
```

这里定义写入行为和上面的 `simulationEnsembleDatastore` 所对应的写入行为是一致的，flag 都是`-append`，但是 `fileEnsembleDatastore` 允许我们对此进行修改。

## save 函数的 `-append` flag 

我们可以对比一下在 save 函数中是否使用 `-append` flag 之间的区别：

**（1）使用  `-append` flag** 

```matlab
% create 'test.mat'
p = rand(1,10);
q = ones(10);
save('test.mat','p','q')

% List variables in 'test.mat'
whos('-file','test.mat')

% append 'a' in 'test.mat'
a = 50;
save('test.mat','a','-append')

% List varibles in new 'test.mat'
whos('-file','test.mat')
```

结果

```matlab
>> script5
  Name       Size            Bytes  Class     Attributes

  p          1x10               80  double              
  q         10x10              800  double              

  Name       Size            Bytes  Class     Attributes

  a          1x1                 8  double              
  p          1x10               80  double              
  q         10x10              800  double  
```

**（2）不使用  `-append` flag** 

```matlab
% create 'test.mat'
p = rand(1,10);
q = ones(10);
save('test.mat','p','q')

% List variables in 'test.mat'
whos('-file','test.mat')

% append 'a' in 'test.mat'
a = 50;
save('test.mat','a')

% List varibles in new 'test.mat'
whos('-file','test.mat')
```

结果：

```matlab
>> script6
  Name       Size            Bytes  Class     Attributes

  p          1x10               80  double              
  q         10x10              800  double              

  Name      Size            Bytes  Class     Attributes

  a         1x1                 8  double       
```

## 一种实现“删除变量”操作的方式

根据上述的分析，可以得到一种比较麻烦的实现删除变量操作的方式，即使用 `fileEnsembleDatastore` 为现有的 .mat 文件创建 ensemble，并自定义 `fensemble.WriteToMemberFcn` 函数，使 `save` 的行为只是简单的保存，而不是 append。之后，读取每一个 .mat 文件的所有变量构成一个 table，然后使用 `removevars`函数删除不必要的列，之后将删除后的 table 写入到原来的 .mat 文件中，实现删除操作。

注意，我们的重点是自定义`fensemble.WriteToMemberFcn` 函数，但是函数 `fensemble.ReadFcn` 也需要预先定义，才能实现 `read` 操作。

假如，如果我们想要实现删除掉每一个 .mat 文件中的变量  `A1` 、`f1` 、`A2` 、`f2` ：

```matlab
fens = fileEnsembleDatastore(fullfile(pwd,'Data'),'.mat');
fens.ReadFcn = @readVars;
fens.WriteToMemberFcn = @writeNewData;

fens.DataVariables = ["SineWave"; "CosineWave"; "CompositeWave"; "PMSignalLogName";
    "logsout";"SimulationInput"; "SimulationMetadata"; "A1"; "f1"; "A2"; "f2"; "Maximum"];
fens.SelectedVariables = fens.DataVariables;

data = read(fens);
data = removevars(data, {'A1', 'f1', 'A2', 'f2'});

writeToLastMemberRead(fens, data)

function data = readVars(filename,variables)
data = table();
mfile = matfile(filename); % Allows partial loading
for ct=1:numel(variables)
    val = mfile.(variables{ct});
    if numel(val) > 1
        val = {val};
    end
    data.(variables{ct}) = val;
end
end

function writeNewData(filename,data)
save(filename, '-struct', 'data');
end
```

此时：

```matlab
>> whos('-file', 'model_log_1.mat')
  Name                    Size             Bytes  Class                             

  CompositeWave            -               81303  timetable                                    
  CosineWave               -               81303  timetable                                    
  Maximum                 1x1                  8  double                                       
  PMSignalLogName         1x7                 14  char                                         
  SimulationInput         1x1               1061  Simulink.SimulationInput                     
  SimulationMetadata      1x1               6632  Simulink.SimulationMetadata                  
  SineWave                 -               81303  timetable                                    
  logsout                 1x1             244801  Simulink.SimulationData.Dataset    
```

虽然有些僵硬，但是 bingo~ 

之后，对所有 .mat 进行批量删除操作，但是和批量写入不同的是，重复的写入并不会报错，但是重复的删除会出现报错，比如刚才我们对第一个 .mat 文件进行了删除操作，这些变量已经没有了，再次删除（甚至是再次读取都会报错，因为我们设置的 `fens.DataVariables` 中包含 `A1` 那几个变量）就会报错，因此在整个流程之前先简单设置一个 `fens.SelectedVariables` ，先 `read` 一下，跳过第一个文件：

```matlab
fens = fileEnsembleDatastore(fullfile(pwd,'Data'),'.mat');
fens.ReadFcn = @readVars;
fens.WriteToMemberFcn = @writeNewData;

fens.DataVariables = ["SineWave"; "CosineWave"; "CompositeWave"; "PMSignalLogName";
    "logsout";"SimulationInput"; "SimulationMetadata"; "A1"; "f1"; "A2"; "f2"; "Maximum"];

% Skip the first .mat file
reset(fens);
fens.SelectedVariables = "SineWave";
data = read(fens);

% Operate on the remaining files
fens.SelectedVariables = fens.DataVariables;
while hasdata(fens)
    data = read(fens);
    data = removevars(data, {'A1', 'f1', 'A2', 'f2'});
    writeToLastMemberRead(fens, data)
end

function data = readVars(filename,variables)
data = table();
mfile = matfile(filename); % Allows partial loading
for ct=1:numel(variables)
    val = mfile.(variables{ct});
    if numel(val) > 1
        val = {val};
    end
    data.(variables{ct}) = val;
end
end

function writeNewData(filename,data)
save(filename, '-struct', 'data');
end
```

或者比较简单的方式，使用 `subset()` 函数将剩余的 .mat 文件作为 fens 的子集，之后进行删除操作。

Bingo~

总的来说，“删除”操作比“写入”操作更加麻烦，因为就像上面所遇到的情况，重复删除是会报错的，必须重新定义`fens.SelectedVariables`。所以，如果不是 .mat 文件中的变量特别多或者特别复杂，不用删除掉那些变量，只需要设置好 `ens.SelectedVariables` ，用什么取什么即可。

<br>

**参考**

[1]  [simulationEnsembleDatastore - MathWorks](https://ww2.mathworks.cn/help/predmaint/ref/simulationensembledatastore.html).

[2] [Using Simulink to Generate Fault Data - MathWorks](https://ww2.mathworks.cn/help/predmaint/ug/Use-Simulink-to-Generate-Fault-Data.html).

[3] [fileEnsembleDatastore - MathWorks](https://ww2.mathworks.cn/help/predmaint/ref/fileensembledatastore.html).
