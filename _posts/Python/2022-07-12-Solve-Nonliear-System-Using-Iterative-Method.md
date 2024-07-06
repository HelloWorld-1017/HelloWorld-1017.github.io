---
layout: single
title: Solve Nonlinear Equation (System) using Iterative Method
date: 2022-07-12 13:45:17 +0800
categories: 
 - Mathematics
 - Python
tags: 
 - Numerical Analysis
 - Matrix
---

# 迭代法原理
## 迭代法求解非线性方程

###  二分法

求解方程的第一步是确定根是否存在。

> **介值定理(Intermediate value theorem)**
> 令$f$是区间$[a,b]$上的连续函数，若满足$f(a)f(b)<0$，则 $a$ 和 $b$ 之间存在一个根 $r$, 即存在 $a<r<b$ 满足 $f(r) = 0$。

根据介值定理，可以得到求解方程数值根最简单的方法——**二分法(Bisection method)**：通过不断把函数$f(x)$的零点所在的区间一分为二，使区间的两个端点逐步逼近零点，每进行一次二分法都把区间中点作为根的估计值。

假设 $[a,b]$ 为初始区间，在 $n$ 次二分后，得到的最终区间 $[a_n,b_n]$ 的长度为$(b-a)/2^n$，选择中点 $x_r = (a_n + b_n)/2$ 作为解的最有估计，与真实值之间的误差不会超过区间长度的一半，即：

$$
\vert x_r-r\vert <\dfrac{b-a}{2^{n+1}}\label{errorthreshold}
$$

式 $\eqref{errorthreshold}$ 表明二分法迭代次数和精度之间的关系，并且表明二分法可以保证线性收敛。但是由于收敛速度较慢，运算量较大。因此，二分法常用于求根的大体范围，即进行根的隔离。


### 不动点迭代

方程 $f(r)=0$ 根的求解问题，都可以转换为求解不动点方程的问题

$$
g(r)=f(r)+r=r
$$

> **不动点(fixed point)**
>
> 当$f(r)=r$时，称实数$r$为函数$f$的不动点。

$g(r)=r$ 就是不动点方程。对于这样的方程，我们可以从一个初始值 $x_0$ 开始进行迭代，这就是不动点迭代法(Fixed point iteration):

$$
\begin{align*}
x_0 &= k\\
x_{i+1} &= g(x_i),\ i=0,1,2,\dots
\end{align*}
$$

**所有**的方程 $f(x)=0$ 都可以转换为形如 $g(x)=x$，并且可以以不同的形式转化，且不同的转化方式对应着不同的收敛效果。因此，不动点迭代不能保证算法收敛（若收敛，则一定是线性收敛），也无法确定收敛速度，这取决于不动点处的函数导数值。



### 牛顿法
**牛顿法**，也称为**牛顿-拉夫逊法(Newton's method, AKA Newton-Raphson method)**，它的收敛速度通常比二分法和不动点迭代收敛快很多。牛顿法所对应的几何图如下图所示。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220712125213291.png?raw=true" alt="image-20220712125213291" style="zoom: 67%;" />



首先给定初始估计 $x_0$，画出函数 $f(x)$ 在 $x_0$ 处的切线，用切线来近似函数 $f$，求出该切线与 $x$ 轴的交点作为 $x_1$。可以看到，$x_1$ 比 $x_0$ 更接近函数的精确解 $r$，因此重复上述步骤，就可以得到一个非常接近真实解的近似解。



对于初值 $x_0$，对应于函数曲线的点 $(x_0,f(x_0))$，该点处的切线方程为：

$$
f'(x_0)(x-x_0)=y-f(x_0)\label{newton}
$$

该切线与$x$轴的交点可令式 $\eqref{newton}$ 中 $y = 0$ 求得：

$$
\begin{align*}
&f'(x_0)(x-x_0)=0-f(x_0)\\
\Rightarrow&x-x_0=-\dfrac{f(x_0)}{f'(x_0)}\\
\Rightarrow&x = x_0 - \dfrac{f(x_0)}{f'(x_0)}\\
\Rightarrow&x_1 = x_0 - \dfrac{f(x_0)}{f'(x_0)}\\
\end{align*}
$$

由此，可以得到牛顿法迭代的一般形式：

$$
\begin{align}
x_0 &= k \notag \\
x_{i+1} &= x_i - \dfrac{f(x_i)}{f'(x_i)},\ i=0,1,2,\dots \label{singlevariable}
\end{align}
$$

其中 $f'(x_i)\neq 0$。

**牛顿法收敛的条件是在真实解 $r$ 处满足$f'(r)\neq 0$**（这是一个后验）。牛顿法若收敛，则在单根位置上二次收敛；在重根位置上线性收敛。因此，除了重根位置，牛顿方法比二分法和不动点迭代的收敛速度都更快，它达到了这种更快的速度的原因是因为使用了更多的信息，尤其是通过函数导数得到的函数切线方向的信息。

### 割线法

但在某些情况下，可能很难计算函数的导数。在这种情况下，割线法就是牛顿方法一个很好的替代，它使用割线来近似替代函数切线，它能够以超线性的速度收敛到一个单根，即收敛速度在线性和二次收敛方法之间。割线法的一般迭代形式为：

$$
\begin{align}
x_0,x_1&= k_1,k_2 \notag \\
x_{i+1} &= x_i - \dfrac{f(x_i)(x_i-x_{i-1})}{f(x_i)-f(x_{i-1})},\ i=1,2,3,\dots \label{SM}
\end{align}
$$

## 非线性方程组的求解
### 多元牛顿法

式 $\eqref{singlevariable}$ 是单变量的牛顿迭代法，对于具有$n$个变量$n$个方程的非线性方程组$F(\boldsymbol{x})$：

$$
\begin{equation*} 
\left\{ 
\begin{aligned}
f_1(\boldsymbol{x}) &= 0\\
f_2(\boldsymbol{x}) &= 0\\
&\vdots \\
f_n(\boldsymbol{x}) &= 0
\end{aligned}
\right.
\end{equation*}
$$

可以采用多元牛顿法进行迭代求解。单变量情况下的函数导数 $f'$ 对应多元函数的雅各比矩阵，定义为：

$$
\begin{equation*}
DF(\boldsymbol{x}) = 
	\begin{bmatrix}
		\dfrac{\partial f_1}{\partial x_1} & \dfrac{\partial f_1}{\partial x_2}  & \cdots & \dfrac{\partial f_1}{\partial x_n}\\ 
		\dfrac{\partial f_2}{\partial x_1} & \dfrac{\partial f_2}{\partial x_2}  & \cdots & \dfrac{\partial f_2}{\partial x_n}\\
		\vdots                             & \vdots                              & \vdots & \vdots                            \\
		\dfrac{\partial f_n}{\partial x_1} & \dfrac{\partial f_n}{\partial x_2}  & \cdots & \dfrac{\partial f_n}{\partial x_n}
	\end{bmatrix}
\end{equation*}
$$

在点 $\boldsymbol{x}_0$ 附近的向量值函数的泰勒展开式为：

$$
\begin{equation}\label{multivariables}
F(\boldsymbol{x})=F(\boldsymbol{x}_0)+DF(\boldsymbol{x}_0)\cdot (\boldsymbol{x} - \boldsymbol{x}_0) + O(\boldsymbol{x} - \boldsymbol{x}_0)^2
\end{equation}
$$

牛顿方法基于线性近似，因此忽略 $O(\boldsymbol{x} - \boldsymbol{x}_0)^2$，将式 $\eqref{multivariables}$ 在$\boldsymbol{r}$处展开得到：

$$
\begin{equation}
0 = F(\boldsymbol{r})\approx F(\boldsymbol{x}_0)+DF(\boldsymbol{x}_0)\cdot (\boldsymbol{r} - \boldsymbol{x}_0)
\end{equation}
$$


即：

$$
\begin{equation}\label{3.6}
-DF(\boldsymbol{x}_0)^{-1}F(\boldsymbol{x}_0)\approx \boldsymbol{r} - \boldsymbol{x}_0
\end{equation}
$$


于是可以得到多变量牛顿法的一般迭代形式：

$$
\begin{align}
\boldsymbol{x}_0 &= \boldsymbol{k} \notag \\
\boldsymbol{x}_{k+1} &=\boldsymbol{x}_{k} - DF(\boldsymbol{x}_k)^{-1}F(\boldsymbol{x}_k),\ k= 0,1,2,\cdots \label{multinewton}\\
\end{align}
$$


### 布罗伊登法

牛顿法求解单变量的方程需要知道导数，如果导数难以计算，则可以使用割线法进行替代。同样地，在使用多元牛顿法求解多元非线性方程组时也面临着无法求出雅可比矩阵 $DF$ 的情况。但在多元的情况下，无法将牛顿方法推广至割线方法，而布罗伊登法就是一个良好的近似。

根据式 $\eqref{multivariables}$ 可以得到：

$$
\begin{equation}\label{3.8}
F(\boldsymbol{x}_{i+1})-F(\boldsymbol{x}_i)=DF(\boldsymbol{x}_i)\cdot (\boldsymbol{x}_{i+1} - \boldsymbol{x}_i)
\end{equation}
$$

布罗伊登法假设 $\boldsymbol{A}_i$ 是第 $i$ 步的 雅可比矩阵的最优近似，于是式 $\eqref{multinewton}$ 可以改写为：

$$
F(\boldsymbol{x}_{i+1})-F(\boldsymbol{x}_i)=\boldsymbol{A}_i\cdot (\boldsymbol{x}_{i+1} - \boldsymbol{x}_i)\label{equa2}
$$

令 
$$
\boldsymbol{\delta}_i = \boldsymbol{x}_{i+1} - \boldsymbol{x}_i\notag
$$，
$$
\boldsymbol{\Delta}_i = F(\boldsymbol{x}_{i+1})-F(\boldsymbol{x}_i) \notag
$$，
可以得到：

$$
\boldsymbol{A}_i\cdot \boldsymbol{\delta}_i=\boldsymbol{\Delta}_i \label{equa1}
$$

另一方面，假设近似矩阵 $\boldsymbol{A}$ 具有以下的递推关系：

$$
\begin{align}\
\boldsymbol{A}_{i} &= \boldsymbol{A}_{i-1} + \Delta\boldsymbol{A}_{i-1} \notag\\
&= \boldsymbol{A}_{i-1} + \boldsymbol{\omega}(\boldsymbol{\delta}_{i})^T\label{eq3}
\end{align}
$$




式 $\eqref{equa1}$ 中 

$$
\Delta\boldsymbol{A}_{i-1}=\boldsymbol{\omega}(\boldsymbol{\delta}_{i})^T
$$

称为修正矩阵。其中，
$$
\boldsymbol{\omega}\in \mathbb{R}^n
$$，
$$
\boldsymbol{\delta}_i\in \mathbb{R}^n
$$。

于是根据式 $\eqref{equa2}$ 可以得到：

$$
\begin{align}
\boldsymbol{\Delta}_i&=\boldsymbol{A}_i\cdot \boldsymbol{\delta}_i \notag \\
&=(\boldsymbol{A}_{i-1}+\Delta\boldsymbol{A}_{i-1})\cdot \boldsymbol{\delta}_i \notag \\
&=(\boldsymbol{A}_{i-1}+\boldsymbol{\omega}(\boldsymbol{\delta}_{i})^T)\cdot \boldsymbol{\delta}_i\notag \\
&=\boldsymbol{A}_{i-1}\boldsymbol{\delta}_i + \boldsymbol{\omega}(\boldsymbol{\delta}_{i})^T \boldsymbol{\delta}_i
\end{align}
$$

于是得到向量 $\boldsymbol{\omega}$ 的值：

$$
\boldsymbol{\omega}=\dfrac{\boldsymbol{\Delta}_i - \boldsymbol{A}_{i-1}\boldsymbol{\delta}_i}{(\boldsymbol{\delta}_{i})^T \boldsymbol{\delta}_i}
$$

再根据 $\eqref{eq3}$ 得到近似矩阵$\boldsymbol{A}$的递推公式：

$$
\boldsymbol{A}_{i}-\boldsymbol{A}_{i-1}=\dfrac{(\boldsymbol{\Delta}_i - \boldsymbol{A}_{i-1}\boldsymbol{\delta}_i)(\boldsymbol{\delta}_{i})^T}{(\boldsymbol{\delta}_{i})^T \boldsymbol{\delta}_i}\label{eq4}
$$

最终，根据式 $\eqref{equa2}$ 更新当前的近似估计，使用 $\eqref{eq4}$ 更新雅可比矩阵的最优近似，就可以得到布罗伊登方法的一般迭代形式：

$$
\begin{align}
\boldsymbol{x}_{i+1} &= \boldsymbol{x}_i - \boldsymbol{A}_i^{-1}F(\boldsymbol{x}_{i})\notag \\
\boldsymbol{A}_{i}&=\boldsymbol{A}_{i-1}+\dfrac{(\boldsymbol{\Delta}_i - \boldsymbol{A}_{i-1}\boldsymbol{\delta}_i)(\boldsymbol{\delta}_{i})^T}{(\boldsymbol{\delta}_{i})^T \boldsymbol{\delta}_i},\ i = 1,2,\cdots
\end{align}
$$

其中，

$$
\begin{split}
&\boldsymbol{\delta}_i = \boldsymbol{x}_{i+1} - \boldsymbol{x}_i\\
&\boldsymbol{\Delta}_i = F(\boldsymbol{x}_{i+1})-F(\boldsymbol{x}_i)\\
\end{split}
$$

<br>

# 算例

## 非线性方程的求解

求解方程：

$$
f(x) = x^6-5x^5+ 3x^4 + x^3 -7x^2 + 7x - 20 =0 
$$

在 $[-1, 5]$ 内的全部实根（先用二分法做根的隔离）。

首先根据函数画出函数图像，如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712182156945.png?raw=true" alt="image-20220712182156945" style="zoom:67%;" />

```python
import numpy as np
import matplotlib.pyplot as plt
import matplotlib

# Specify the font properties in the figures
font = {'font.size': 13,
        'font.family': 'serif'}
matplotlib.rcParams.update(font) 

# The lower and upper limit
a, b = -1, 5

# Define the nonlinear function
fun = lambda x:x**6-5*x**5+ 3*x**4 + x**3 -7*x**2 + 7*x - 20 
x = np.arange(a,b,0.05)
y = fun(x)

# The profile of the nonlinear funciton
plt.xlim(a, b)
plt.xlabel(r'$x$')
plt.ylabel(r'$y$')
plt.title('The profile of the nonlinear function')
plt.plot(x,y)
plt.axhline(0, color = "k", ls=(0, (5, 5)), alpha=0.8, zorder=0)
fig = plt.gcf()
fig.savefig('fig1.eps')
plt.show()
```

从图中可以看出，在给定的 $[-1, 5]$ 区间内仅有一个根。

### 二分法

![image-20220712210528013](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712210528013.png?raw=true)

```python
# Specify parameters
theta = 0.00005         # the minimum interval length
maxIteration = 200      # the maximum iterative number

# Record the convergence process of x0
list_x = []
# Record the interval length of each iteration
range_list = []

# Define Bisection method function
def BisectionMethod(func, a ,b ,theta, maxIteration):
    # func: nonlinear funciton
    # a, b: upper and lower limits, respectively
    # theta: the minimum interval length
    num = 0
    try:
        # If upper and lower bounds of interval are wrong
        if a > b or func(a) * func(b) > 0 or abs(a - b) < theta:
            raise ValueError
 
        # If the solution exists at the endpoint of interval
        if func(a) * func(b) == 0:
            if func(a) == 0:
                return a, num
            else:
                return b, num

        # If the solution exits in the middle of interval
        while True:
            num += 1
            c = (a + b) / 2
        
            list_x.append(c)
            range_list.append(abs(a - b))
            
            if func(c) == 0:
                return c, num
            
            else: 
                if func(a) * func(c) < 0:
                    b = c
                else:
                    a = c
                if abs(a - b) < theta:
                    
                    return (a + b) / 2, num

            if num >= maxIteration:
                print("There maybe exists solution, but the algorithm does not converge.")
                return None

    except ValueError:
        print("Upper and lower bounds of interval may be error")
        return None

# Solve fucntion
x0, num = BisectionMethod(fun, a, b, theta, maxIteration=maxIteration)


# Plot iteration process diagram
fig, axes= plt.subplots(1, 3, figsize=(20, 5))
axes[0].plot(range(len(list_x)), list_x)
axes[0].scatter(range(len(list_x)),list_x,color='tab:brown')
axes[0].set_xlabel('Iteration')
axes[0].set_ylabel(r'$x_i$')

axes[1].plot(range(len(list_x)),[fun(x) for x in list_x])
axes[1].scatter(range(len(list_x)),[fun(x) for x in list_x], color='tab:brown')
axes[1].set_xlabel('Interation')
axes[1].set_ylabel(r'$f(x_i)$')

axes[2].plot(range(len(list_x)),np.array(range_list) / 2)
axes[2].scatter(range(len(list_x)),np.array(range_list) / 2, color='tab:brown')
axes[2].set_xlabel('Iteration')
axes[2].set_ylabel('Upper bound of error')
fig.savefig('fig2.eps')
plt.show()
```

从图中可以看出，二分法求解该方程可以收敛，近似解收敛至$4.3337$，误差上限为$4.58\times 10^{-5}$，近似解的函数值为$-1.01\times 10^{-2}$。

### 不动点迭代

使用不动点迭代法求解非线性方程的关键是找到一个合适的对应的不动点方程 $g(x)=x$，并且初值选取合适才能够保证算法收敛。比如算例1所对应的不动点方程：
$$
g_1(x) = x^6-5x^5+ 3x^4 + x^3 -7x^2 + 8x - 20
$$
就不收敛，因为在不动点处函数的导数值$g'(r)>1$。于是选取式 $\eqref{fixed2}$ 为不动点方程。
$$
g_2(x) = \dfrac{\dfrac{20}{x^4} - \dfrac{7}{x^3} + \dfrac{7}{x^2} - \dfrac{1}{x}-3 + 1005x}{x+1000}\label{fixed2}
$$

初值$x_0$设置为4，经过2000次的迭代得到的近似解为$4.3336$，误差为$-0.2580$。得到的迭代图像如下图所示。

![image-20220712211951092](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712211951092.png?raw=true)

```python
import numpy as np
import matplotlib.pyplot as plt
import matplotlib

# Specify the font properties in the figures
font = {'font.size': 13,
        'font.family': 'serif'}
matplotlib.rcParams.update(font)

# The nonlinear function
f = lambda x: x**6 - 5*x**5 + 3*x**4 + x**3 - 7*x**2 + 7*x - 20
# The Fixed-point iterative function
g = lambda x : (20/(x**5) - 7/(x**4) + 7/(x**3) - 1/(x**2) - 3/x + 1005) * x /(x + 1000)


x_list = []
maxIteration = 2000

# Define Fixed-point iterative process
def FixedPointIteration(g, x0, maxIteration):
    x_i = x0
    num = 0

    for i in range(maxIteration):
        x_list.append(x_i)
        x_i  = g(x_i)

        num += 1

    return x_i, num

x_i, num = FixedPointIteration(g, 4, maxIteration=maxIteration)

fig, axes = plt.subplots(1,2, figsize = (17, 7))
axes[0].plot(range(len(x_list)), x_list)
axes[0].set_xlabel('Iteration')
axes[0].set_ylabel(r'$x_i$')

axes[1].plot(range(len(x_list)),np.array(x_list) - g(np.array(x_list)))
axes[1].set_xlabel('Iteration')
axes[1].set_ylabel(r'$x_i$-$g(x_i)$')
fig.savefig('fig.eps')
plt.show()
```



可以看到，为了保证得到的函数在不动点处的导数为0而构造出的不动点函数 $g_2(x)$，虽然可以收敛至不动点，但是由于在不动点附近的函数的导数也比较小，因此收敛较慢，需要迭代很多次。并且由于不动点迭代的收敛为局部收敛，因此必须要找到一个距离不动点比较近的初值。

### 牛顿法

根据式 $\eqref{singlevariable}$ 编写牛顿法求解程序。初值设置为$10$，算法最终得到近似值收敛到$4.3338$，误差小于$1\times 10^{-3}$，迭代图像如下图所示。

![image-20220712212617316](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712212617316.png?raw=true)

```python
import torch
import numpy as np
import matplotlib.pyplot as plt
import matplotlib

# Specify the font properties in the figures
font = {'font.size': 13,
        'font.family': 'serif'}
matplotlib.rcParams.update(font)

# Define nonlinear function
f = lambda x: x**6-5*x**5+ 3*x**4 + x**3 -7*x**2 + 7*x - 20 

def f_Derivation(x,f):
    return torch.autograd.grad(f(x), x, create_graph= True)

x_list = []

# Specify initial value
x_i = torch.tensor([10.],requires_grad = True)
x_list.append(x_i.data.numpy())

for i in range(50):
    f_val = f(x_i)
    fp = f_Derivation(x_i, f)[0]    
    x_i = x_i - f_val/fp
    x_list.append(x_i.data.numpy())
    
    if f(x_i) < 1e-3:
        break
    
print('Approximate solution：',x_i)
print('Function value of approximate solution',f(x_i))

fig, axes = plt.subplots(1,2, figsize = (17, 7))
axes[0].plot(range(len(x_list)), x_list)
axes[0].set_xlabel('Iteration')
axes[0].set_ylabel(r'$x_i$')

axes[1].plot(range(len(x_list)),f(np.array(x_list)))
axes[1].set_xlabel('Iteration')
axes[1].set_ylabel(r'$f(x_i)$')

fig.savefig('fig.eps')
```



可以看到，使用牛顿法仅通过10次迭代，误差就能够小于$1\times 10^{-4}$，收敛效果很好。

### 割线法

根据式 $\eqref{SM}$ 编写割线法求解程序。初值$x_0$、$x_0$分别设置为3和4。经过11次迭代，得到近似值收敛到$4.3338$，误为于$6.90\times 10^{-8}$，迭代图像如下图所示，收敛效果与牛顿法近似。

![image-20220712213018948](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712213018948.png?raw=true)

```python
import matplotlib
import numpy as np
import matplotlib.pyplot as plt

# Specify the font properties in the figures
font = {'font.size': 13,
        'font.family': 'serif'}
matplotlib.rcParams.update(font)

# Define nonlinear function
def f(x): return x**6-5*x**5 + 3*x**4 + x**3 - 7*x**2 + 7*x - 20


x_list, error_list = [], []

# Specify tolerance
tolerance = 1e-4

# Specify initial values, x_0, x_1
x_0, x_1 = 3, 4
x_list.append(x_0)
x_list.append(x_1)

def SecantMethod(tolerance, x_0, x_1):
    error = tolerance + 1
    cur_root = x_1
    count = 1
    while error > tolerance:
        sect = (f(x_1) - f(x_0)) / (x_1 - x_0)
        cur_root = cur_root - f(x_1) / sect
        x_list.append(cur_root)

        error = abs(f(cur_root))
        error_list.append(error)

        x_0 = x_1
        x_1 = cur_root
        count += 1

    return x_1, count

x_1, count = SecantMethod(tolerance, x_0, x_1)
x_1, count, f(x_1)

fig, axes = plt.subplots(1,2, figsize = (17, 7))
axes[0].plot(range(len(x_list)), x_list)
axes[0].scatter(range(len(x_list)),x_list, color='tab:brown')
axes[0].set_xlabel('Iteration')
axes[0].set_ylabel(r'$x_i$')

axes[1].plot(range(len(x_list)),f(np.array(x_list)))
axes[1].scatter(range(len(x_list)),f(np.array(x_list)), color='tab:brown')
axes[1].set_xlabel('Iteration')
axes[1].set_ylabel(r'$f(x_i)$')
fig.savefig('fig.eps')
```

## 线性方程组的求解

算例

用牛顿法、弦割法、布罗伊登法求以下方程组的解：

(1)
$$
\begin{equation}
\left\{ 
\begin{aligned}
&x_1^2 + x_2^2 + x_3^2-1.0 = 0 \\
&2x_1^2+x_2^2-4x_3=0\\
&3x_1^2-4x_2^2+x_3^2 = 0\\
\end{aligned}
\right.\label{nonlinearsystem1}
\end{equation}
$$

给定初始向量 $x^{(0)}=(1.0, 1.0, 1.0)^T$ ;

(2) 
$$
\begin{equation}
\left\{ 
\begin{aligned}
&\cos(x_1^2+0.4x_2)+x_1^2+x_2^2-1.6=0\\
&1.5x_1^2-\dfrac{1}{0.36}x_2^2-1.0 = 0\\
\end{aligned}
\right.\label{nonlinearsystem2}
\end{equation}
$$

给定初始向量 $x^{(0)}=(1.04, 0.47)^T$;

### 多元牛顿法

使用多元牛顿法分别对算例2的方程组 $\eqref{nonlinearsystem1}$ 、$\eqref{nonlinearsystem2}$ 分别进行求解，得到的收敛图像如下图所示。代码中使用PyTorch框架完成了对雅可比矩阵的构建。可以看到，多元牛顿法应用于这两个方程组都有非常好的收敛效果。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712214257321.png?raw=true"/>

```python
import torch
import numpy as np
import matplotlib.pyplot as plt
import matplotlib

# Specify the font properties in the figures
font = {'font.size': 13,
        'font.family': 'serif'}
matplotlib.rcParams.update(font)

# Define vector function
f = lambda x: x[0] ** 2 + x[1] ** 2 + x[2] ** 2 - 1.0
g = lambda x: 2 * x[0] ** 2 + x[1] ** 2 - 4 * x[2]
h = lambda x: 3 * x[0] ** 2 - 4 * x[1] ** 2 + x[2] ** 2

# Record intermediate results
x_list, F_value_list = [], []


# Specify initial values
x = torch.tensor([[1.0], [1.0], [1.0]], requires_grad = True)
x_list.append(x.data.numpy())

for i in range(5):
    # Calculate fucntion value
    F_value = torch.cat((f(x), g(x), h(x)),0).reshape((3, 1))
    F_value_list.append(F_value.data.numpy())

    # Calculate Jacobian matrix
    J = torch.cat((torch.autograd.grad(f(x), x, create_graph=True)[0],
               torch.autograd.grad(g(x), x, create_graph=True)[0],
               torch.autograd.grad(h(x), x, create_graph=True)[0]), 1).transpose(0, 1)

    # Update vector x
    x = x - torch.mm(torch.linalg.inv(J), F_value)
    x_list.append(x.data.numpy())
    
x_list = np.array(x_list).reshape((-1, 3))
F_value_list = np.array(F_value_list).reshape((-1, 3))

print('Approximate value of vector x: ',x_list[-1], 'Approximate vector function value F: ', F_value_list[-1], sep = '\n')

# Profile of iterative process
markers = ['o', '^', 's']
labels0 = [r'$x_1$',r'$x_2$',r'$x_3$']
labels1 = [r'$f_1$',r'$f_2$',r'$f_3$']

fig, axes = plt.subplots(1,2, figsize = (17, 7))

for idx, x, f in zip(range(0,3), x_list.T, F_value_list.T):
    axes[0].plot(range(len(x)), x, marker = markers[idx], label = labels0[idx])
    axes[1].plot(range(len(f)), f, marker = markers[idx], label = labels1[idx])
    
axes[0].set_xlabel('Interation')
axes[0].set_ylabel(r'Value of each component of vector x')
axes[0].legend()

axes[1].set_xlabel('Iteration')
axes[1].set_ylabel('Value of each component of vector function value F')
axes[1].legend()
fig.savefig('fig1.eps')
```

![image-20220712214720615](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712214720615.png?raw=true)

```python
import torch
import numpy as np
import matplotlib.pyplot as plt
import matplotlib

# Specify the font properties in the figures
font = {'font.size': 13,
        'font.family': 'serif'}
matplotlib.rcParams.update(font)

f = lambda x: torch.cos(x[0] ** 2 + 0.4 * x[1]) + x[0] ** 2 + x[1] ** 2 - 1.6
g = lambda x: 1.5 * x[0] ** 2 - (1/0.36) * x[1] ** 2 - 1.0

# Record intermediate results
x_list, F_value_list = [], []


# Specify initial values
x = torch.tensor([[10.0], [10.0]], requires_grad = True)
x_list.append(x.data.numpy())

for i in range(10):
    # Calculate fucntion value
    F_value = torch.cat((f(x),g(x)),0).reshape((2, 1))
    F_value_list.append(F_value.data.numpy())

    # Calculate Jacobian matrix
    J = torch.cat((torch.autograd.grad(f(x), x, create_graph = True)[0],
               torch.autograd.grad(g(x), x, create_graph = True)[0]), 1).transpose(0, 1)
    
    # Update vector x
    x = x - torch.mm(torch.linalg.inv(J), F_value)
    x_list.append(x.data.numpy())
                        
x_list = np.array(x_list).reshape((-1, 2))
F_value_list = np.array(F_value_list).reshape((-1, 2))

print('Approximate value of vector x: ',x_list[-1], 'Approximate vector function value F: ', F_value_list[-1], sep = '\n')

markers = ['o', '^']
labels0 = [r'$x_1$',r'$x_2$']
labels1 = [r'$f_1$',r'$f_2$']

fig, axes = plt.subplots(1,2, figsize = (17, 7))

for idx, x, f in zip(range(0,2), x_list.T, F_value_list.T):
    axes[0].plot(range(len(x)), x, marker = markers[idx], label = labels0[idx])
    axes[1].plot(range(len(f)), f, marker = markers[idx], label = labels1[idx])
    
axes[0].set_xlabel('Interation')
axes[0].set_ylabel(r'Value of each component of vector x')
axes[0].legend()

axes[1].set_xlabel('Iteration')
axes[1].set_ylabel('Value of each component of vector function value F')
axes[1].legend()
fig.savefig('fig2.eps')
```

### 布罗伊登法

使用多元牛顿法分别对算例2的（1）、（2）方程组进行求解，得到的收敛图像如下图所示。


![image-20220712215712154](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712215712154.png?raw=true)

```python
import numpy as np
import matplotlib.pyplot as plt
import matplotlib

# Specify the font properties in the figures
font = {'font.size': 13,
        'font.family': 'serif'}
matplotlib.rcParams.update(font)

# Define vector function
f = lambda x: x[0] ** 2 + x[1] ** 2 + x[2] ** 2 - 1.0
g = lambda x: 2 * x[0] ** 2 + x[1] ** 2 - 4 * x[2]
h = lambda x: 3 * x[0] ** 2 - 4 * x[1] ** 2 + x[2] ** 2

# Record intermediate values
x_list, A_list, F_value_list = [], [], []

# Specify
x = np.array([1.0, 1.0, 1.0]).reshape((3, 1))

A = np.eye(3)
A_list.append(A)

for i in range(100):
    x_list.append(x)
    
    F_value = np.array([f(x), g(x), h(x)])
    F_value_list.append(F_value)
    
    x_current = x - np.linalg.inv(A).dot(F_value)
    F_current_value = np.array([f(x_current), g(x_current), h(x_current)])
    
    Delta = F_current_value - F_value
    delta = x_current - x
    
    A = A + ((Delta - A.dot(delta)).dot(delta.T))/np.dot(delta.T, delta)
    A_list.append(A)
    x = x_current

    if np.linalg.norm(F_value_list[-1]) < 1e-4:
        print('Iterative numbers:', i + 1)
        break
    
print('Approximate value of vector x: ',x_list[-1],'Approximate vector function value F:', F_value_list[-1], sep = '\n')
x_list = np.array(x_list).reshape((-1,3)).T
F_value_list = np.array(F_value_list).reshape((-1,3)).T


# Plot iterative process
markers = ['o', '^', 's']
labels0 = [r'$x_1$',r'$x_2$',r'$x_3$']
labels1 = [r'$f_1$',r'$f_2$',r'$f_3$']
fig, axes = plt.subplots(1,2, figsize = (17, 7))
for idx, x, f in zip(range(0,3), x_list, F_value_list):
    axes[0].plot(range(len(x)), x, marker = markers[idx], label = labels0[idx])
    axes[1].plot(range(len(f)), f, marker = markers[idx], label = labels1[idx])
    
axes[0].set_xlabel('Interation')
axes[0].set_ylabel(r'Value of each component of vector x')
axes[0].legend()

axes[1].set_xlabel('Iteration')
axes[1].set_ylabel('Value of each component of vector function value F')
axes[1].legend()
fig.savefig('fig1.eps')
```

![image-20220712215841050](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220712215841050.png?raw=true)


```python
import numpy as np
import matplotlib.pyplot as plt
import matplotlib

# Specify the font properties in the figures
font = {'font.size': 13,
        'font.family': 'serif'}
matplotlib.rcParams.update(font)

# Define vector function
f = lambda x: np.cos(x[0] ** 2 + 0.4 * x[1]) + x[0] ** 2 + x[1] ** 2 - 1.6
g = lambda x: 1.5 * x[0] ** 2 - (1/0.36) * x[1] ** 2 - 1.0

# Record intermediate values
x_list, A_list, F_value_list = [], [], []

# Specify initial value
x = np.array([1.04, 0.47]).reshape((2, 1))

A = np.eye(2)
A_list.append(A)

for i in range(100):
    x_list.append(x)
    
    F_value = np.array([f(x), g(x)])
    F_value_list.append(F_value)
    
    x_current = x - np.linalg.inv(A).dot(F_value)
    F_current_value = np.array([f(x_current), g(x_current)])
    
    Delta = F_current_value - F_value
    delta = x_current - x
    
    A = A + ((Delta - A.dot(delta)).dot(delta.T))/np.dot(delta.T, delta)
    A_list.append(A)
    
    x = x_current
    if np.linalg.norm(F_value_list[-1]) < 1e-4:
        print('Iterative numbers: ', i + 1)
        break
    
print('Approximate value of vector x: ',x_list[-1],'Approximate vector function value F:', F_value_list[-1], sep = '\n')

x_list = np.array(x_list).reshape((-1,2)).T
F_value_list = np.array(F_value_list).reshape((-1,2)).T


# Plot iterative process
markers = ['o', '^']
labels0 = [r'$x_1$',r'$x_2$']
labels1 = [r'$f_1$',r'$f_2$']
fig, axes = plt.subplots(1,2, figsize = (17, 7))
for idx, x, f in zip(range(0,2), x_list, F_value_list):
    axes[0].plot(range(len(x)), x, marker = markers[idx], label = labels0[idx])
    axes[1].plot(range(len(f)), f, marker = markers[idx], label = labels1[idx])
    
axes[0].set_xlabel('Interation')
axes[0].set_ylabel(r'Value of each component of vector x')
axes[0].legend()

axes[1].set_xlabel('Iteration')
axes[1].set_ylabel('Value of each component of vector function value F')
axes[1].legend()
fig.savefig('fig2.eps')
```

从图中可以看出，对方程组 $\eqref{nonlinearsystem1}$ 使用布罗伊算法进行求解，可以在85次迭代后误差的二范数收敛在$1\times 10^{-4}$以内；对方程组 $\eqref{nonlinearsystem2}$ 使用布罗伊算法进行求解，可以在5次迭代后误差的二范数收敛在$1\times 10^{-4}$以内，均有比较好的收敛效果。
