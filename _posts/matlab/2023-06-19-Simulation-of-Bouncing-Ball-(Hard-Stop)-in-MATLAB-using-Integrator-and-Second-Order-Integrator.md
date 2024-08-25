---
layout: single
title: Simulation of Bouncing Ball (Hard Stop) in MATLAB using Integrator and Second-Order Integrator
date: 2023-06-19 13:15:53 +0800
categories: 
 - MATLAB
tags: 
 - MATLAB Simulink
 - Numerical Analysis
---

# Introduction

高空落下撞击地面的物理过程称为是一个具有**奇诺行为（Zeno behavior）**的**混杂动态系统（hybrid dynamic systems）** [1]：

注：奇诺行为的非正式特征为：在有限的时间间隔内会发生无限多个事件。
{: .notice--primary}

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617234153030.png?raw=true" alt="image-20230617234153030" style="zoom: 50%;" />

在MATLAB示例 [1] 中，作者使用了两种方式：（1）使用两个积分器；（2）使用一个二阶积分器对这一系统进行建模，并从数值计算的角度对两者的结果进行了分析。本博客就记录一下对该示例的学习。

<br>

# Introduction to Hybrid Dynamic Systems of Bouncing Ball

当小球落在地面上时，小球会以较小的时间间隔与地面发生碰撞，并失去能量。小球撞击地面的模型就是混杂动态系统的一个典型示例。混杂动态系统是一个同时涉及连续动力（continuous dynamics）和离散过渡（discrete transitions）的系统，其中系统动力可以改变，状态值可以跳跃（the system dynamics can change and the state values can jump）。

对于该系统，在小球撞击地面之前，其连续动力学的表达形式为：

$$
\begin{split}
&v(t)=v_0-g\cdot t\\
&x(t)=x_0+v(t)\cdot t\\
\end{split}
$$

其中，$g$为重力加速度，$x(t)$是小球的位置，$v(t)$为小球的速度，系统的正方向指向上。该系统具有两个连续的状态：位置$x(t)$和速度$v(t)$。

假设小球与地面发生了弹性碰撞（elastic collision），则小球在撞击前的速度$v^{-}$和撞击后的速度$v^+$可以记作：

$$
v^{+}=-kv^-,\quad x=0
$$

其中，$k$为小球的**恢复系数（coefficient of restitution）**。

<br>

# Using Two Integrator Blocks to Model Bouncing Ball

示例的第一个模型`sldemo_bounce_two_integrators`使用了两个积分模块（`Velocity`和`Position`）模拟小球的碰撞：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230616230803223.png?raw=true" alt="image-20230616230803223" style="zoom:50%;" />

## Integrator block [2]

两个积分模块`Velocity`和`Position`相比默认创建的积分模块（包含两个端口，`input`端口和`output`端口）多了三个端口，分别是`initialize`端口，`reset`端口和`state`端口：

### `initialize` port

模块左边与`x0`端口相连的`initialize`端口，该端口通过设置`Initial condition source`参数为`external`显示：

![image-20230617231751756](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617231751756.png?raw=true)

### `reset` port

模块左边与上升沿触发信号标志所相连的**`reset`端口**，该（触发）端口通过`External reset`参数进行显示和设置：

![image-20230617231807602](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617231807602.png?raw=true)

该设置表明积分模块可以基于外部上升沿信号（信号从非正值，即负值或零值，转换到正值）将积分模块重置到指定的初始状态。`reset`端口具有**直接馈通（direct feedthrough）**的特性，如果将`output`端口（直接或间接地）与`reset`端口连接，则会在模型中产生代数环（Algebraic loop）。**使用积分模块的`state`端口（下文将会提到）来反馈模块的输出则不会产生代数环**。

注：下文在介绍`state`端口时会对这一场景进行进一步分析。
{: .notice--primary}

### `state` port

模块下方的**`state`端口**。该端口通过选中`Show state port`选项进行显示：

![image-20230617231835572](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617231835572.png?raw=true)

`state`端口的输出与积分模块标准输出端口的输出是一致的，但是在时间步中，`state`端口的输出比`output`端口的输出更早地出现。因此，**如果积分模块在当前的时间步被重置，则此时`state`端口的输出值仍然是模块没有被重置时`output`端口应该输出的值**。使用这一特性，我们可以避免在下述的建模场景中避免产生代数环：

（1）使用自复位积分器的系统（Systems that use self-resetting integrators），即本示例所面临的场景；

> 例如，如果我们将积分模块的`Output`端口（间接）连接到`reset`端口，则会警告：
>
> ```
> Block diagram 'sldemo_bounce_two_integrators' contains 1 algebraic loop(s).
> ```
>
> ![image-20230617232942147](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617232942147.png?raw=true)

（2）将状态从一个使能子系统传递到另一个使能子系统（Passing states from one enabled subsystem to another）；

在更新模型时，Simulink会检查在上述两个场景中是否使用了模块的`state`端口，如果没有，就会出现报错信息。

另外，我们不能记录`state`端口输出信号值，如果设置了记录`state`端口的信息，Simulink就会在执行时警告`"signal not found"`。

> 例如，如果我们想使用`Scope`模块观察`State`端口的输出，则会报错：
>
> ```
> State ports can only be used to break algebraic loops or to "hand-off" states between systems.  Use the output port rather than the state port of 'sldemo_bounce_two_integrators/Position' as the source of the signal routed (either by direct or virtual connection) to 'sldemo_bounce_two_integrators/Scope1'
> ```
>
> ![image-20230617232310862](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617232310862.png?raw=true)

## IC (Initial Condition) block [3]

IC模块用于给定积分模块以仿真开始时的初始值。IC模块一个很重要的特性是：虽然IC模块输出初始值由IC模块的输入所决定，但是如果我们设定了IC模块`Initial value`的初始值（例如下图中的15），那么在仿真开始时，无论输入值为多少，IC模块输出的初始值都为所设置的`Initial value`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617212940715.png?raw=true" alt="image-20230617212940715" style="zoom:67%;" />

在本示例中，在仿真一开始（第一个时间步）两个IC模块分别为`Velocity`和`Position`积分模块提供值为`15`和`10`的初始值，在下一个时间步及以后，都为`Velocity`和`Position`积分模块提供`-0.8*Velocity`和`0`（由`Ground`模块提供）的初始值，但是如上文所述，这样的初始值只有当触发了积分模块的重置条件（即当`Position`的模块输出值小于等于零，表明小球碰撞到了地面）才会被传递到两个积分模块中。

## Simulation results

在了解了积分模块的原理和IC模块的原理后，就不难理解该模型对于小球碰撞地面的仿真。最终运行模型，我们就可以得到小球位置及速度随时间的波形曲线：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230616231037317.png?raw=true" alt="image-20230616231037317" style="zoom:50%;" />

需要注意的是，这个模型是在20 s内的仿真结果，如果我们设置仿真的`Stop time`为`25`，则运行模型就会报错：

```
An error occurred while running the simulation and the simulation was terminated

Caused by: Simulink will stop the simulation of model 'sldemo_bounce_two_integrators' because the 2 zero crossing signal(s) identified below caused 1000 consecutive zero crossing events in time interval between 20.357636989536076 and 20.357636990631594.
 --------------------------------------------------------------------------------
Number of consecutive zero-crossings : 1000
           Zero-crossing signal name : RelopInput
                          Block type : RelationalOperator
                          Block path : 'sldemo_bounce_two_integrators/Compare To Zero/Compare'
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Number of consecutive zero-crossings : 500
           Zero-crossing signal name : IntgLoLimit
                          Block type : Integrator
                          Block path : 'sldemo_bounce_two_integrators/Position'
--------------------------------------------------------------------------------
```

![image-20230617233337919](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617233337919.png?raw=true)

在后面，我们可以看到该示例附带的一个脚本文件中，为了使得这个模型能够进一步仿真下去并观察相应的仿真结果，会禁用掉这一报错：

```matlab
warning('off', 'Simulink:Solver:ZeroCrossingNotBracketedDueToSmallSignalValues');
```

<br>

# Using Second-Order Integrator Block to Model Bouncing Ball

该示例的第二个模型`sldemo_bounce`采用的是一个二阶积分模块（Second-Order Integrator block）[4] 实现对小球碰撞地面进行建模：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230616231101153.png?raw=true" alt="image-20230616231101153" style="zoom:50%;" />

二阶积分模块的参数设置如下：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617221453585.png?raw=true" alt="image-20230617221453585" style="zoom: 50%;" />

可以看到，该二阶积分模块勾选了`limit x`并且将`Lower limit x`的值设置为`0`，表示地面。

在二阶积分模块的`Atrributes`设置中勾选了`Reintiallize dx/dt when x reach saturation`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617221720336.png?raw=true" alt="image-20230617221720336" style="zoom: 50%;" />

该设置使得二阶积分模块在`x`值（Position）到达饱和时重新初始化`dx/dt`（Velocity）的值，以实现对小球碰撞后的积分。

另外注意到，为了计算小球碰撞后反弹的初速度$v^{+}$，模型需要获得碰撞前$v^{-}$时的速度，因此在二阶积分模块`dx`输出端口连接了一个`Memory`模块：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617222247891.png?raw=true" alt="image-20230617222247891" style="zoom:50%;" />

之后，设置模型的`Stop time`为`25`，并在求解器设置中将`Zero-crossing options`中的`Algorithm`参数设置为`Nonadaptive`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617222534358.png?raw=true" alt="image-20230617222534358" style="zoom:50%;" />

最终运行模型，可以得到第二个模型的输出结果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230616231153639.png?raw=true" alt="image-20230616231153639" style="zoom: 67%;" />

> 在上述的设置下（即将求解器设置中的`Zero-crossing options`的`Algorithm`参数设置为`Nonadaptive`），可以看到速度波形在20.36 s左右仍有有轻微的抖动：
>
> <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617223047307.png?raw=true" alt="image-20230617223047307" style="zoom:80%;" />
>
> 而若设置为`Adaptive`，速度波形在20.7 s左右就为零值了：
>
> <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617223148162.png?raw=true" alt="image-20230617223148162" style="zoom:80%;" />
>
> 因此，`Algorithm`参数设置为`Nonadaptive`会获得更加拟真的结果。

<br>

# Discussions

实际上，我们可以计算一个无穷几何级数得到小球落在地面上的精确时间$t^{*}$（即速度为零，通过加和每一次弹跳所需的时间）：

$$
t^{*}=\dfrac1g\Big(v_0+v_1\Big(\dfrac{1+k}{1-k}\Big)\Big),\quad v_1=\sqrt{v^2_0+2gx_0}
$$

当$t>t^{*}$时，小球的速度和位置均为零。

注：由于碰撞系数$k$从0到1之间取值，因此由上式可以得到，随着$k$的增大，$t^{*}$会相应增大。
{: .notice--primary}

之后，可以绘制出两个模型求解的结果与$x^{*}$对比的图像：

```matlab
open_system('sldemo_bounce_two_integrators');
set_param('sldemo_bounce_two_integrators', 'ZeroCrossAlgorithm','Adaptive');
set_param('sldemo_bounce_two_integrators', 'StopTime','25');
warning('off', 'Simulink:Solver:ZeroCrossingNotBracketedDueToSmallSignalValues');
out=sim('sldemo_bounce_two_integrators', 'SaveTime', 'on', 'SaveState', 'on');
ti=out.tout;
xi=out.xout;

open_system('sldemo_bounce');
out=sim('sldemo_bounce', 'SaveTime', 'on', 'SaveState', 'on');
ts=out.tout;
xs=out.xout;

g = 9.81;
v0 = 15;
x0 = 10;
k = 0.8;
v1=sqrt(v0*v0+2*g*x0);
kfactor = (1+k)/(1-k);
tzeno = (1/g)*(v0+v1*kfactor);
is = find(ts > 20.0, 1);
ii = find(ti > 20.0, 1);

plot (ti(ii:end),xi(ii:end,1),'b');
hold on;
plot (ts(is:end),xs(is:end,1),'m');
hold on;
X = [tzeno, tzeno];
Y = [-1E-04 7E-03];
line('XData', X, 'YData', Y, 'Color','r');
axis([20 22 -1E-04 7E-03]);
xlabel('Time');
ylabel('Position');
legend('Integrator','Second-Order Integrator', 't*');

bdclose all
warning('on', 'Simulink:Solver:ZeroCrossingNotBracketedDueToSmallSignalValues');
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230617223453785.png?raw=true" alt="image-20230617223453785" style="zoom:50%;" />

可以看到，当$t^{*}$之前相对较远的位置时，两个模型都可以给出精确且一致的结果（品红色的线盖过了蓝色的线）。但是，在$t^{*}$之后，使用两个积分器获得的结果是不准确的，始终会有比较强烈的抖动；相反，使用二阶积分器的模型可以输出比较合理的结果。

因此，在模拟Hard stop这一场景中，二阶积分器有着更优越的数值特点，这是二阶微分方程$\mathrm{d}t/\mathrm{d}t$的求解包含在二阶积分模块的内部。二阶积分模块算法可以利用Position和Velocity的关系，在Position和Velocity由于积分误差和抖动行为而不再相互一致时使用启发式方法（heuristics）来抑制解的抖动。

<br>

**References**

[1] [Simulation of Bouncing Ball - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/simulation-of-a-bouncing-ball.html).

[2] [Integrate signal - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/integrator.html).

[3] [Set initial value of signal - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/ic.html).

[4] [Second-order integration of input signal - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/secondorderintegrator.html).

[5] [How to model a hard stop in Simulink » Guy on Simulink - MATLAB & Simulink](https://blogs.mathworks.com/simulink/2014/01/22/how-to-model-a-hard-stop-in-simulink/?from=cn).

[6] [Friction Model with Hard Stops - MATLAB & Simulink - MathWorks China](https://ww2.mathworks.cn/help/simulink/slref/friction-model-with-hard-stops.html).

