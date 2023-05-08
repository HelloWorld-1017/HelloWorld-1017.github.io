# 2-D Rotation Matrix

在二维空间中，假设有一个向量的坐标为$(1,1)$，经过某种旋转$R$后，其坐标变为$(0,\sqrt2)$。那么，**我们如何知道旋转$R$所对应的矩阵是什么？**

数学上，上述问题可以表述为，已知：
$$
R\begin{bmatrix}
1\\1
\end{bmatrix}=
\begin{bmatrix}
0\\ \sqrt2
\end{bmatrix}\label{eq1}
$$
求矩阵$R$。

但是，条件$\eqref{eq1}$的显然是不够的。因为矩阵$R$中的各个元素都是为止的，因此式$\eqref{eq1}$可以写作：
$$
\begin{bmatrix}
r_{11}&r_{12}\\r_{21}&r_{22}
\end{bmatrix}\begin{bmatrix}
1\\1
\end{bmatrix}=
\begin{bmatrix}
0\\ \sqrt2
\end{bmatrix}
$$

即：
$$
\begin{bmatrix}
1&1&0&0\\
0&0&1&1\\
\end{bmatrix}
\begin{bmatrix}
r_{11}\\
r_{12}\\
r_{21}\\
r_{22}
\end{bmatrix}=
\begin{bmatrix}
0\\ \sqrt2
\end{bmatrix}\label{eq2}
$$
式$\eqref{eq2}$是一个超定方程，有无穷多组解。只要满足：
$$
R=
\begin{bmatrix}
r_{11}&-r_{11}\\
r_{21}&\sqrt2-r_{21}
\end{bmatrix}
$$
的矩阵，都可以将$(1,1)$变换为$(0,\sqrt2)$。例如矩阵：
$$
R_1=\begin{bmatrix}
\dfrac{\sqrt2}{2}&-\dfrac{\sqrt2}{2}\\
\dfrac{\sqrt2}{2}&\dfrac{\sqrt2}{2}\\
\end{bmatrix},\quad
R_2=\begin{bmatrix}
1&-1\\
0&\sqrt2\\
\end{bmatrix}
$$
都可以做到这一点：

![image-20230506194507341](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230506194507341.png)

注：绘图代码见附录A。
{: .notice--primary}

但是如果对于两个向量构成的线段，例如对于$(1,1)$和$(1,2)$构成的变换，变换$R_1$和$R_2$作用的效果分别为：

![image-20230506195152843](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230506195152843.png)

注：绘图代码见附录B。
{: .notice--primary}

因此，只有变换$R_1$才是一个“旋转”矩阵，而$R_2$并不是。

要想使得我们想要找到的矩阵一定是旋转矩阵，我们至少需要找**两个向量**，使得可以构成一个恰定方程组。例如，我们选取两个向量$(1,1)$和$(1,2)$，变换后的向量分别是$(0,\sqrt2)$和$(-\sqrt2/2,3\sqrt2/2)$，从而有：
$$
\begin{bmatrix}
r_{11}&r_{12}\\r_{21}&r_{22}
\end{bmatrix}\begin{bmatrix}
1&1\\1&2
\end{bmatrix}=
\begin{bmatrix}
0&-\dfrac{\sqrt2}{2}\\ \sqrt2&\dfrac{3\sqrt2}{2}
\end{bmatrix}
$$
进而构成恰定方程组：
$$
\begin{bmatrix}
1&1&0&0\\
1&2&0&0\\
0&0&1&1\\
0&0&1&2\\
\end{bmatrix}
\begin{bmatrix}
r_{11}\\
r_{12}\\
r_{21}\\
r_{22}\\
\end{bmatrix}=
\begin{bmatrix}
0\\
-\dfrac{\sqrt2}2\\
\sqrt2\\
\dfrac{3\sqrt2}2\\
\end{bmatrix}
$$
解出：
$$
R=\begin{bmatrix}
\dfrac{\sqrt2}{2}&-\dfrac{\sqrt2}{2}\\
\dfrac{\sqrt2}{2}&\dfrac{\sqrt2}{2}\\
\end{bmatrix}\label{eq4}
$$
就是我们上面得到的旋转矩阵$R_1$。

但是，这种方法需要**已知两个向量的旋转前后的坐标**，这样的条件有时候是不满足的。

<br>

从另一个角度讲，对于向量的旋转，可以看做是对坐标系的旋转，也即对基向量的旋转；**线性变换仅仅改变基向量的位置，并不改变基的线性组合** [1]。如果对基向量逆时针旋转$\theta$角度，则从几何上可以推导出旋转后的基向量坐标：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230508133745234.png" alt="image-20230508133745234" style="zoom:33%;" />

另一方面，“**矩阵对应着一种线性变换，并且矩阵的每一列都是线性变换后基向量的坐标**”，旋转矩阵亦是如此，因此逆时针旋转$\theta$角度的旋转矩阵为：
$$
R(\theta)=
\begin{bmatrix}
\cos\theta&-\sin\theta\\
\sin\theta&\cos\theta\\
\end{bmatrix}
$$
回到最开始的问题：假设有一个向量的坐标为$(1,1)$，经过某种旋转$R$后，其坐标变为$(0,\sqrt2)$。那么，**我们如何知道旋转$R$所对应的矩阵是什么？**

此时，我们就可以列写出：
$$
\begin{bmatrix}
\cos\theta&-\sin\theta\\
\sin\theta&\cos\theta\\
\end{bmatrix}
\begin{bmatrix}
1\\
1\\
\end{bmatrix}
=
\begin{bmatrix}
0\\
\sqrt2\\
\end{bmatrix}
$$

$$
\left\{
\begin{split}
&\cos\theta-\sin\theta=0\\
&\sin\theta+\cos\theta=0
\end{split}\right.\label{eq3}
$$

对比式$\eqref{eq2}$，可以看到式$\eqref{eq3}$是一个**单变量**的求解问题。尽管式$\eqref{eq3}$是一个**非线性**方程（组），但是它是非常容易求解的，我们可以解得$\theta=\pi/4$，并且旋转矩阵为：
$$
R(\pi/4)=
\begin{bmatrix}
\dfrac{\sqrt2}{2}&-\dfrac{\sqrt2}{2}\\
\dfrac{\sqrt2}{2}&\dfrac{\sqrt2}{2}\\
\end{bmatrix}
$$
与$\eqref{eq4}$的结果是一致的。

<br>

# 3-D Rotation Matrix

## Basic rotation

三维坐标系统下，一共有3个（$C_3^2$）旋转的角度，类比于二维坐标系统下的基向量旋转，可以推导出三个基本旋转矩阵（basic rotation, AKA elemental rotation） 。

（1）绕$x$轴旋转（在$zy$平面内逆时针旋转）的旋转矩阵

$$
R_x(\theta)=
\begin{bmatrix}
1&0&0\\
0&\cos\theta&-\sin\theta\\
0&\sin\theta&\cos\theta\\
\end{bmatrix}
$$

（2）绕$y$轴旋转（在$zx$平面内逆时针旋转）的旋转矩阵：
$$
R_y(\theta)=
\begin{bmatrix}
\cos\theta&0&\sin\theta\\
0&1&0\\
-\sin\theta&0&\cos\theta\\
\end{bmatrix}
$$

（3）绕$z$轴旋转（在$xy$平面内逆时针旋转）的旋转矩阵：
$$
R_z(\theta)=
\begin{bmatrix}
\cos\theta&-\sin\theta&0\\
\sin\theta&\cos\theta&0\\
0&0&1
\end{bmatrix}
$$

## General rotations




$$
\begin{split}
R&=R_z(\alpha)R_y(\beta)R_x(\gamma)\\
&=
\begin{bmatrix}
\cos\alpha&-\sin\alpha&0\\
\sin\alpha&\cos\alpha&0\\
0&0&1
\end{bmatrix}
\begin{bmatrix}
\cos\beta&0&\sin\beta\\
0&1&0\\
-\sin\beta&0&\cos\beta\\
\end{bmatrix}
\begin{bmatrix}
1&0&0\\
0&\cos\gamma&-\sin\gamma\\
0&\sin\gamma&\cos\gamma\\
\end{bmatrix}\\
&=
\begin{bmatrix}
\cos\alpha\cos\beta&\cos\alpha\sin\beta\sin\gamma-\sin\alpha\cos\gamma&\cos\alpha\sin\beta\cos\gamma+\sin\alpha\sin\gamma\\
\sin\alpha\cos\beta&\sin\alpha\sin\beta\sin\gamma+\cos\alpha\cos\gamma&\sin\alpha\sin\beta\cos\gamma-\cos\alpha\sin\gamma\\
-\sin\beta&\cos\beta\sin\gamma&\cos\beta\cos\gamma
\end{bmatrix}
\end{split}
$$





使用这个公式的前提是事先知道我们要旋转的角度。






<br>

**References**

[1] [Matrix and its Relation to Linear Transformation - What a starry night~](http://whatastarrynight.com/mathematics/Linear-Transformation-and-Matrix/).

[2] [Rotation matrix - Wikipedia](https://en.wikipedia.org/wiki/Rotation_matrix).

[3] [旋转矩阵（Rotation Matrix）的推导及其应用 - meteoric_cry - 博客园](https://www.cnblogs.com/meteoric_cry/p/7987548.html).







[旋转(Rotation)矩阵转欧拉角(euler）_tuszhangs的博客-CSDN博客](https://blog.csdn.net/weixin_39675633/article/details/103434557#:~:text=θ1 θ2 %3D −asin (R31) %3D π− θ1,%3D ±1 的情况。 因此，通过利用 R31 元素的值，我们可以确定 θ 的两个不同的值。)



<br>

# Appendix

## Appendix A

```matlab
clc,clear,close all

vec1 = [1;1];
R1 = [sqrt(2)/2,-sqrt(2)/2;
    sqrt(2)/2,sqrt(2)/2];
R2 = [1,-1;
    0,sqrt(2)];

vecR1 = R1*vec1;
vecR2 = R2*vec1;

figure("Units","pixels","Position",[625.66,493.66,1539.33,382.66])
tiledlayout(1,3)
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vec1(1)],[0,vec1(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("Before transformation","Interpreter","latex")

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vecR1(1)],[0,vecR1(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("After transformation by $R_1$","Interpreter","latex")

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vecR2(1)],[0,vecR2(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("After transformation by $R_2$","Interpreter","latex")
```

## Appendix B

```matlab
clc,clear,close all

vec1 = [1;1];
vec2 = [1;2];
R1 = [sqrt(2)/2,-sqrt(2)/2;
    sqrt(2)/2,sqrt(2)/2];
R2 = [1,-1;
    0,sqrt(2)];

vecR1_1 = R1*vec1;
vecR1_2 = R1*vec2;
vecR2_1 = R2*vec1;
vecR2_2 = R2*vec2;

figure("Units","pixels","Position",[625.66,493.66,1539.33,382.66])
tiledlayout(1,3)
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vec1(1)],[0,vec1(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
plot([0,vec2(1)],[0,vec2(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
plot([vec1(1),vec2(1)],[vec1(2),vec2(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','r')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("Before transformation","Interpreter","latex")

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vecR1_1(1)],[0,vecR1_1(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
plot([0,vecR1_2(1)],[0,vecR1_2(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
plot([vecR1_1(1),vecR1_2(1)],[vecR1_1(2),vecR1_2(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','r')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("After transformation by $R_1$","Interpreter","latex")

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vecR2_1(1)],[0,vecR2_1(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
plot([0,vecR2_2(1)],[0,vecR2_2(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
plot([vecR2_1(1),vecR2_2(1)],[vecR2_1(2),vecR2_2(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','r')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("After transformation by $R_2$","Interpreter","latex")
```
