

以二维空间为例，假设有一个向量的坐标为$(1,1)$，经过某种旋转$R$后，其坐标变为$(0,\sqrt2)$。那么，**我们如何知道旋转$R$所对应的矩阵是什么？**

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
\end{bmatrix}
$$
就是我们上面得到的旋转矩阵$R_1$。

但是，这种方法需要**已知两个向量的旋转前后的坐标**，这样的条件有时候是不满足的。







从另一个角度讲，



想要使得

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230506202716728.png" alt="image-20230506202716728" style="zoom: 33%;" />

实际上就变成了一个单变量的问题；



虽然是一个非线性方程组，但是这是非常容易求解的；



三维：
$$
R(\theta)=
\begin{bmatrix}
\cos\theta&-\sin\theta\\
\sin\theta&\cos\theta\\
\end{bmatrix}
$$











三维坐标系统下，一共有3个旋转的角度（$C_3^2$）


$$
R_x(\theta)=
\begin{bmatrix}
1&0&0\\
0&\cos\theta&-\sin\theta\\
0&\sin\theta&\cos\theta\\
\end{bmatrix}
$$

$$
R_y(\theta)=
\begin{bmatrix}
\cos\theta&0&\sin\theta\\
0&1&0\\
-\sin\theta&0&\cos\theta\\
\end{bmatrix}
$$

$$
R_z(\theta)=
\begin{bmatrix}
\cos\theta&-\sin\theta&0\\
\sin\theta&\cos\theta&0\\
0&0&1
\end{bmatrix}
$$

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

[1] 



[旋转矩阵（Rotation Matrix）的推导及其应用 - meteoric_cry - 博客园](https://www.cnblogs.com/meteoric_cry/p/7987548.html).

[Rotation matrix - Wikipedia](https://en.wikipedia.org/wiki/Rotation_matrix)



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
