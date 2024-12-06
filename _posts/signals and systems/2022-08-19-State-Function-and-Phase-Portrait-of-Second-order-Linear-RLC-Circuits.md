---
title: State Function and Phase Portrait of Second-order Linear RLC Circuits
categories: 
 - Signals and Systems
 - Uncertainty
date: 2022-08-19 09:17:37 +0800
last_modified_at: 2024-11-28 17:36:07 +0800
---

# State function, state plane, phase trajectory

二阶非线性电路方程的一般形式可以写作

$$
\left\{
\begin{split}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\\
\end{split}\right.\label{eqs1}
$$

其中，$x_1(t)$ 和 $x_2(t)$ 为状态变量，我们称式 $\eqref{eqs1}$ 为**状态方程**。 

如果式 $\eqref{eqs1}$ 中自变量 $t$ 除了在 $\dfrac{\mathrm{d}x}{\mathrm{d}t}$ 中以隐含形式存在之外，不以任何显式形式存在，即：

$$
\left\{
\begin{split}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2)\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2)\\
\end{split}\right.\label{eqs2}
$$

类似公式 $\eqref{eqs2}$ 这种自变量 $t$ 不以任何显式形式存在的方程称为**自治方程**，与之相对的公式 $\eqref{eqs1}$ 称为**非自治方程**。

注：非自治方程中，变量 $t$ 仅仅是不以任何显式形式存在，$x_1(t)$ 和 $x_2(t)$ 仍然是随着自变量 $t$ 的变化而变化的。
{: .notice}

时变电路或者电路中包含随时间变化的外施激励，那么就会得到非自治方程；而在<u>零输入或者在直流激励下的非线性二阶电路</u>的方程是自治方程，对应的电路就是自治电路。

一般来说，求解非线性方程式 $\eqref{eqs1}$ 和式 $\eqref{eqs2}$ 是比较困难的，它们通常没有闭式解。

注：闭式解（closed form solution），即解析解（analytical solution）。
{: .notice}

把自治方程 $\eqref{eqs2}$ 中的状态变量 $x_1$、$x_2$ 看作平面上的坐标点，这种平面就称为**状态平面**。状态平面上每一点的坐标 $(x_1,x_2)$ 随时间 $t$ 变化将在平面上绘制出相应的曲线。假设给定的初始状态（初始条件）为 $x_1(0)$ 和 $x_2(0)$ ，对所有的 $t\ge0$ ，方程 $\eqref{eqs2}$ 的解 $[x_1(t),x_2(t)]$ 在平面上绘制出的以 $[x_1(0),x_2(0)]$ 为起点的轨迹被称为该状态方程的一条轨道或者**相轨道**（又称为**相轨迹**）。**对于不同的初始条件，可以在状态平面上绘制出一族相轨道**，这族相轨道称为该自治方程的**相图**，而坐标点 $(x_1,x_2)$ 也被称为**相点**。

通常从相图就可以定性地了解状态方程所描述的电路工作状态的整个变化情况，而不必直接求解非线性方程，因此我们可以利用数值算法通过计算机把相轨道绘制出来。
{: .notice--danger}

相轨道还可以通过实验的方法观察，例如只要把 $x_1(t)$ 和 $x_2(t)$ 作为信号电压，把它们加到示波器的水平输入和垂直输入，就可以显示出相应的相轨道。
{: .notice--danger}

<br>

# Dynamic process of discharge in second-order RLC series circuit (with linear elements)

下面用状态平面讨论二阶 RLC 串联电路放电的动态过程，其电路图如下图所示。为了简化假设，假设电阻 R、电感 L 和电容 C 都是线性元件。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220818193442974.png?raw=true" alt="image-20220818193442974" style="zoom: 33%;" />

假设电容电压的初始值为 $u_C(0_-)=U_0$，电感的初始值为 $i_L(0_-)=0$，在 0 时刻开关闭合。电路的方程为：

$$
LC\dfrac{\mathrm{d}^2i}{\mathrm{d}t^2}+RC\dfrac{\mathrm{d}i}{\mathrm{d}t}+i=0\notag
$$

令 $x_1=i$，$x_2=\dfrac{\mathrm{d}i}{\mathrm{d}t}=\dfrac{\mathrm{d}x_1}{\mathrm{d}t}$，则上式可以改写为状态方程的形式：

$$
\left\{\begin{split}
&\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=x_2\\
&\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=-\dfrac1{LC}x_1-\dfrac{R}{L}x_2
\end{split}
\right.\notag
$$

令 $\omega_0^2=\dfrac1{LC}$，$\delta=\dfrac{R}{2L}$，则上式可化为：

$$
\left\{\begin{split}
&\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=x_2\\
&\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=-\omega_0^2x_1-2\delta x_2
\end{split}\label{eqs4}
\right.
$$

当电路闭合时，由于

$$
\begin{align*}
u_c(0_{+})=u_c(0_{-})=U_0\\
i_L(0_+)=i_ L(0_ {-})=0
\end{align*}
$$

又因为在 $0_{+}$ 时刻，有 

$$
u_c = L\dfrac{\mathrm{d}i_L}{\mathrm{d}t}+i_LR\notag
$$

因此 $\dfrac{\mathrm{d}i_L}{\mathrm{d}t}\Big\vert_{0_+}=\dfrac{U_0}L$，即 $x_2(0)=\dfrac{U_0}L$，于是可以得到初始条件：

$$
\left\{\begin{split}
&x_1(0) = 0\\
&x_2(0) = \dfrac{U_0}L\\
\end{split}\label{initials}
\right.
$$

对式 $\eqref{eqs4}$ 直接积分，在根据式 $\eqref{initials}$ 的初始条件，就可以求得相轨道的方程，这里主要用状态平面来讨论。

在下面的讨论中，均假设 $L=1\ \mathrm{H}$，$C=1\ \mathrm{F}$ ，使用 MATLAB 的 `ode45` 函数求状态方程的数值解，以观察不同的初始条件 $U_0$ 对于相轨迹的影响，以及通过改变电阻 $R$ 讨论不同阻尼程度对于相轨迹的影响。
{: .notice--primary}

## If $\delta^2<\omega_0^2$ (underdamped): decaying oscillation discharge 

当 $\delta^2<\omega_0^2$ 时，即当 $R<2\sqrt{\dfrac{L}{C}}=2$ 时，电路中的放电过程为衰减振荡过程。

### Different initials

```matlab
clc, clear, close
[t1, y1] = ode45(@StateFunction, [0, 100], [0; 1]);
% [0 100], time interval
% [0; 1], initial values

[t2, y2] = ode45(@StateFunction, [0, 100], [0; 5]);
[t3, y3] = ode45(@StateFunction, [0, 100], [0; 10]);

LineWidth = 1.7;

figure, axes
hold(gca, 'on');
plot(y1(:,1), y1(:,2), LineWidth=LineWidth);
scatter(y1(1,1), y1(1,2), "filled");
scatter(y1(end, 1), y1(end, 2), "filled");

plot(y2(:,1), y2(:,2), LineWidth=LineWidth);
scatter(y2(1,1), y2(1,2), "filled");
scatter(y2(end, 1), y2(end, 2), "filled");

plot(y3(:,1), y3(:,2), LineWidth=LineWidth);
scatter(y3(1,1), y3(1,2), "filled");
scatter(y3(end, 1), y3(end, 2), "filled");

legend("Phase Trajectory: U_0=1", "Initial point: U_0=1", "Terminal point: U_0=1",...
   "Phase Trajectory: U_0=5", "Initial point: U_0=5", "Terminal point: U_0=5",...
   "Phase Trajectory: U_0=10", "Initial point: U_0=10", "Terminal point: U_0=10")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2<\omega_0^2$ ($R=1$)", Interpreter="latex")


function dydt = StateFunction(t, y)
R=1;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220819085650207.png?raw=true" alt="image-20220819085650207" style="zoom:50%;" />

上图展现了在衰减振荡状态的情况下不同初值的相轨迹，这组相轨迹就是一个相图。

### Different parameters

上图中所展示的衰减振荡状态，其参数为 $R=1\ \Omega$，$L=1\ \mathrm{H}$，$C=1\ \mathrm{F}$，此时在仍满足衰减振荡的条件下，改变不同的元件参数（为了简化分析，这里只改变电阻 $R$ 的大小），观察相轨迹的差异。

```matlab
clc, clear, close
[t1, y1] = ode45(@StateFunction1, [0, 100], [0; 1]);
[t2, y2] = ode45(@StateFunction2, [0, 100], [0; 1]);
[t3, y3] = ode45(@StateFunction3, [0, 100], [0; 1]);

LineWidth = 1.7;

figure, axes
hold(gca, 'on');
plot(y1(:,1), y1(:,2), LineWidth=LineWidth);
scatter(y1(1,1), y1(1,2), "filled");
scatter(y1(end, 1), y1(end, 2), "filled");

plot(y2(:,1), y2(:,2), LineWidth=LineWidth);
scatter(y2(1,1), y2(1,2), "filled");
scatter(y2(end, 1), y2(end, 2), "filled");

plot(y3(:,1), y3(:,2), LineWidth=LineWidth);
scatter(y3(1,1), y3(1,2), "filled");
scatter(y3(end, 1), y3(end, 2), "filled");

legend("Phase Trajectory:R=0.5", "Initial point: R=0.5", "Terminal point: R=0.5",...
   "Phase Trajectory: R=1", "Initial point: R=1", "Terminal point: R=1",...
   "Phase Trajectory: R=1.5", "Initial point: R=1.5", "Terminal point: R=1.5")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2<\omega_0^2$ ($U_0=1$) ", Interpreter="latex")


function dydt = StateFunction1(t, y)
R=0.5;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end

function dydt = StateFunction2(t, y)
R=1;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end

function dydt = StateFunction3(t, y)
R=1.5;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220818223605884.png?raw=true" alt="image-20220818223605884" style="zoom:50%;" />

螺旋线的圈间距离表征了振荡的衰减率，而每一圈对应于震荡的周期。

当 $R=0.1$ 时，欠阻尼的程度更加严重，则可以看到很多圈的螺旋线。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220818230034482.png?raw=true" alt="image-20220818230034482" style="zoom:50%;" />

```matlab
clc, clear, close
[t, y] = ode45(@StateFunction, [0, 100], [0; 1]);

LineWidth = 1.7;

figure, axes
hold(gca, 'on');
plot(y(:,1), y(:,2), LineWidth=LineWidth);
scatter(y(1,1), y(1,2), "filled");
scatter(y(end, 1), y(end, 2), "filled");

legend("Phase Trajectory:R=0.1", "Initial point: R=0.1", "Terminal point: R=0.1")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2<\omega_0^2$ ($U_0=1$) ", Interpreter="latex")

function dydt = StateFunction(t, y)
R=0.1;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end
```

无论是初值不同还是元件参数不同，电路状态方程所对应的相轨迹都表现为螺旋线，并且以原点为其渐近点，该原点就是方程 $\eqref{eqs4}$ 的“平衡点”。

## If $\delta^2>\omega_0^2$ (overdamped): non-periodic decaying discharge

当 $\delta^2>\omega_0^2$ 即当 $R>2\sqrt{\dfrac{L}{C}}=2$ 时，电路中的放电过程为非周期衰减性质。

### Different initials

```matlab
clc, clear, close
[t1, y1] = ode45(@StateFunction, [0, 100], [0; 1]);
[t2, y2] = ode45(@StateFunction, [0, 100], [0; 5]);
[t3, y3] = ode45(@StateFunction, [0, 100], [0; 10]);

[t4, y4] = ode45(@StateFunction, [0, 100], [0; -1]);
[t5, y5] = ode45(@StateFunction, [0, 100], [0; -5]);
[t6, y6] = ode45(@StateFunction, [0, 100], [0; -10]);

LineWidth = 1.7;

figure, axes
hold(gca, 'on');
plot(y1(:,1), y1(:,2), LineWidth=LineWidth);
scatter(y1(1,1), y1(1,2), "filled");
scatter(y1(end, 1), y1(end, 2), "filled");

plot(y2(:,1), y2(:,2), LineWidth=LineWidth);
scatter(y2(1,1), y2(1,2), "filled");
scatter(y2(end, 1), y2(end, 2), "filled");

plot(y3(:,1), y3(:,2), LineWidth=LineWidth);
scatter(y3(1,1), y3(1,2), "filled");
scatter(y3(end, 1), y3(end, 2), "filled");

plot(y4(:,1), y4(:,2), LineWidth=LineWidth);
scatter(y4(1,1), y4(1,2), "filled");
scatter(y4(end, 1), y4(end, 2), "filled");

plot(y5(:,1), y5(:,2), LineWidth=LineWidth);
scatter(y5(1,1), y5(1,2), "filled");
scatter(y5(end, 1), y5(end, 2), "filled");

plot(y6(:,1), y6(:,2), LineWidth=LineWidth);
scatter(y6(1,1), y6(1,2), "filled");
scatter(y6(end, 1), y6(end, 2), "filled");

legend("Phase Trajectory: U_0=1", "Initial point: U_0=1", "Terminal point: U_0=1",...
   "Phase Trajectory: U_0=5", "Initial point: U_0=5", "Terminal point: U_0=5",...
   "Phase Trajectory: U_0=10", "Initial point: U_0=10", "Terminal point: U_0=10",...
   "Phase Trajectory: U_0=-1", "Initial point: U_0=-1", "Terminal point: U_0=-1",...
   "Phase Trajectory: U_0=-5", "Initial point: U_0=-5", "Terminal point: U_0=-5",...
   "Phase Trajectory: U_0=-10", "Initial point: U_0=-10", "Terminal point: U_0=-10")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2>\omega_0^2$ ($R=3$)", Interpreter="latex")


function dydt = StateFunction(t, y)
R=3;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end
```

![image-20220819085851220](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220819085851220.png?raw=true)

对应于不同的初始条件，相图是一组变形的抛物线，原点是它们的渐近点，相点的运动是趋于原点的。

### Different parameters

类比衰减振荡放电情形的分析，在非周期衰减震荡放电的情况下，令电阻 $R$ 取不同的值，而初值相同，观察相轨迹的差异。

```matlab
clc, clear, close
[t1, y1] = ode45(@StateFunction1, [0, 100], [0; 1]);
[t2, y2] = ode45(@StateFunction2, [0, 100], [0; 1]);
[t3, y3] = ode45(@StateFunction3, [0, 100], [0; 1]);
[t4, y4] = ode45(@StateFunction4, [0, 100], [0; 1]);

LineWidth = 1.7;

figure, axes
hold(gca, 'on');
plot(y1(:,1), y1(:,2), LineWidth=LineWidth);
scatter(y1(1,1), y1(1,2), "filled");
scatter(y1(end, 1), y1(end, 2), "filled");

plot(y2(:,1), y2(:,2), LineWidth=LineWidth);
scatter(y2(1,1), y2(1,2), "filled");
scatter(y2(end, 1), y2(end, 2), "filled");

plot(y3(:,1), y3(:,2), LineWidth=LineWidth);
scatter(y3(1,1), y3(1,2), "filled");
scatter(y3(end, 1), y3(end, 2), "filled");

plot(y4(:,1), y4(:,2), LineWidth=LineWidth);
scatter(y4(1,1), y4(1,2), "filled");
scatter(y4(end, 1), y4(end, 2), "filled");

legend("Phase Trajectory: R=3", "Initial point: R=3", "Terminal point: R=3",...
   "Phase Trajectory: R=4", "Initial point: R=4", "Terminal point: R=4",...
   "Phase Trajectory: R=5", "Initial point: R=5", "Terminal point: R=5",...
   "Phase Trajectory: R=100", "Initial point: R=100", "Terminal point: R=100")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2>\omega_0^2$ ($U_0=1$) ", Interpreter="latex")


function dydt = StateFunction1(t, y)
R=3;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end

function dydt = StateFunction2(t, y)
R=4;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end

function dydt = StateFunction3(t, y)
R=5;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end

function dydt = StateFunction4(t, y)
R=100;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220818232101598.png?raw=true" alt="image-20220818232101598" style="zoom:50%;" />

## If $\delta=0$ (critically damped): non-decaying sinusoidal oscillation

当 $\delta=0$ ，即 $R=0$ 时。

### Different initials

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220819090011968.png?raw=true" alt="image-20220819090011968" style="zoom:50%;" />

```matlab
clc, clear, close
[t1, y1] = ode45(@StateFunction, [0, 100], [0; 1]);
[t2, y2] = ode45(@StateFunction, [0, 100], [0; 5]);
[t3, y3] = ode45(@StateFunction, [0, 100], [0; 10]);

LineWidth = 1.7;

figure, axes
hold(gca, 'on');
plot(y1(:,1), y1(:,2), LineWidth=LineWidth);
scatter(y1(1,1), y1(1,2), "filled");
scatter(y1(end, 1), y1(end, 2), "filled");

plot(y2(:,1), y2(:,2), LineWidth=LineWidth);
scatter(y2(1,1), y2(1,2), "filled");
scatter(y2(end, 1), y2(end, 2), "filled");

plot(y3(:,1), y3(:,2), LineWidth=LineWidth);
scatter(y3(1,1), y3(1,2), "filled");
scatter(y3(end, 1), y3(end, 2), "filled");


legend("Phase Trajectory: U_0=1", "Initial point: U_0=1", "Terminal point: U_0=1",...
   "Phase Trajectory: U_0=5", "Initial point: U_0=5", "Terminal point: U_0=5",...
   "Phase Trajectory: U_0=10", "Initial point: U_0=10", "Terminal point: U_0=10")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2>\omega_0^2$ ($R=0$)", Interpreter="latex")
axis equal

function dydt = StateFunction(t, y)
R=0;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end
```

该相图是一族椭圆，它对应于不衰减的正弦振荡，震荡的幅值与初始条件有关。

<br>

**References**

- 邱关源. 电路（第5版）. 
