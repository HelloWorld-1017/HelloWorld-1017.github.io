# 2-D Rotation Matrix

在二维空间中，假设有一个向量的坐标为$(1,1)$，经过某种旋转$R$后，其坐标变为$(0,\sqrt2)$。那么，**我们如何知道旋转$R$所对应的矩阵是什么？**该问题可以用数学语言表述为：已知
$$
R\begin{bmatrix}
1\\1
\end{bmatrix}=
\begin{bmatrix}
0\\ \sqrt2
\end{bmatrix},\label{eq1}
$$
求矩阵$R$。

但是，条件$\eqref{eq1}$的显然是不够的。因为矩阵$R$中的各个元素都是未知的，因此式$\eqref{eq1}$可以写作：
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
的矩阵，都可以将$(1,1)$变换为$(0,\sqrt2)$。例如，对于两个不同的矩阵：
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

但是如果对于两个向量构成的线段，例如对于$(1,1)$和$(1,2)$构成的变换，变换$R_1$和$R_2$作用的效果分别为：

![image-20230506195152843](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230506195152843.png)

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

可以看到，只有变换$R_1$才是一个“旋转”矩阵，而$R_2$并不是。

因此，要想使得我们想要找到的矩阵一定是旋转矩阵，我们至少需要找**两个向量**，使得可以构成一个恰定方程组。例如，我们选取两个向量$(1,1)$和$(1,2)$，变换后的向量分别是$(0,\sqrt2)$和$(-\sqrt2/2,3\sqrt2/2)$，从而有：
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

从另一个角度讲，对于向量的旋转，可以看做是对坐标系的旋转，也即对基向量的旋转；**线性变换仅仅改变基向量的位置，并不改变基的线性组合** [[1]](#ref)。如果对基向量逆时针旋转$\theta$角度，则从几何上可以推导出旋转后的基向量坐标：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230508133745234.png" alt="image-20230508133745234" style="zoom: 50%;" />

另一方面，由于“**矩阵对应着一种线性变换，并且矩阵的每一列都是线性变换后基向量的坐标**” [[1]](#ref)，旋转矩阵亦是如此，因此逆时针旋转$\theta$角度的旋转矩阵为：
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

对比式$\eqref{eq2}$，可以看到式$\eqref{eq3}$是一个**单变量**的求解问题。尽管式$\eqref{eq3}$是一个*非线性方程（组）*，但是它是非常容易求解的，我们可以解得$\theta=\pi/4$，并且旋转矩阵为：
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

不同于二维坐标系统的情况，三维坐标系统下，一共有3个（$C_3^2$）旋转的角度。我们可以类比二维坐标系统下的基向量旋转，可以推导出三个基本旋转矩阵（basic rotation, AKA elemental rotation）[[2]](#ref) 。

（1）绕$x$轴旋转（在$zy$平面内逆时针旋转）的旋转矩阵

$$
R_x(\theta)=
\begin{bmatrix}
1&0&0\\
0&\cos\theta&-\sin\theta\\
0&\sin\theta&\cos\theta\\
\end{bmatrix}\label{eq2-1}
$$

（2）绕$y$轴旋转（在$zx$平面内逆时针旋转）的旋转矩阵：
$$
R_y(\theta)=
\begin{bmatrix}
\cos\theta&0&\sin\theta\\
0&1&0\\
-\sin\theta&0&\cos\theta\\
\end{bmatrix}\label{eq2-2}
$$

（3）绕$z$轴旋转（在$xy$平面内逆时针旋转）的旋转矩阵：
$$
R_z(\theta)=
\begin{bmatrix}
\cos\theta&-\sin\theta&0\\
\sin\theta&\cos\theta&0\\
0&0&1
\end{bmatrix}\label{eq2-3}
$$

## General rotations (Intrinsic rotation and Extrinsic rotation)

在三维空间中的一般旋转可以看作是三种基本旋转（式$\eqref{eq2-1}$，$\eqref{eq2-2}$，和$\eqref{eq2-3}$）的共同作用。对于关于轴$z$，$y$，$x$的欧拉角分别为$\alpha$，$\beta$，$\gamma$的**Intrinsic Rotation**，有 [[2]](#ref)：

$$
\begin{split}
R&=R_z(\textcolor{red}{\alpha})R_y(\textcolor{red}{\beta})R_x(\textcolor{red}{\gamma})\\
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
\end{split}\label{eq-intrinsic}
$$

对于关于轴$x$，$y$，$z$旋转角分别为$\alpha$，$\beta$，$\gamma$的**Extrinsic Rotation**，有：
$$
\begin{split}
R&=R_z(\textcolor{blue}{\gamma})R_y(\textcolor{blue}{\beta})R_x(\textcolor{blue}{\alpha})\\
&=
\begin{bmatrix}
\cos\gamma&-\sin\gamma&0\\
\sin\gamma&\cos\gamma&0\\
0&0&1
\end{bmatrix}
\begin{bmatrix}
\cos\beta&0&\sin\beta\\
0&1&0\\
-\sin\beta&0&\cos\beta\\
\end{bmatrix}
\begin{bmatrix}
1&0&0\\
0&\cos\alpha&-\sin\alpha\\
0&\sin\alpha&\cos\alpha\\
\end{bmatrix}\\
&=
\begin{bmatrix}
\cos\beta\cos\gamma&\sin\alpha\sin\beta\cos\gamma-\cos\alpha\sin\gamma&\cos\alpha\sin\beta\cos\gamma+\sin\alpha\sin\gamma\\
\cos\beta\sin\gamma&\sin\alpha\sin\beta\sin\gamma+\cos\alpha\cos\gamma&\cos\alpha\sin\beta\sin\gamma-\sin\alpha\cos\gamma\\
-\sin\beta&\sin\alpha\cos\beta&\cos\alpha\cos\beta
\end{bmatrix}
\end{split}\label{eq-extrinsic}
$$

## How to calculate rotation matrix? [[5]](#ref)

Added on Oct. 30, 2023.
{: .notice--primary}

If having known the $\alpha$, $\beta$, $\gamma$ in $\eqref{eq-intrinsic}$, we could calculate the corresponding rotation matrix $R$ easily. But, if we have a rotation matrix $R$, how could we get the angle values of $\alpha$, $\beta$, and $\gamma$?  Slabaugh's provides a method [[5]](#ref) to solve $R$ for Extrinsic rotation matrix $\eqref{eq-extrinsic}$. In oder to be consistent with his deduction, here we re-denote $\gamma$, $\beta$, and $\alpha$ in $\eqref{eq-extrinsic}$ as $\phi$, $\theta$, and $\psi$, i.e.,
$$
\begin{split}
R&=R_z(\phi)R_y(\theta)R_x(\psi)\\
&=
\begin{bmatrix}
\cos\phi&-\sin\phi&0\\
\sin\phi&\cos\phi&0\\
0&0&1
\end{bmatrix}
\begin{bmatrix}
\cos\theta&0&\sin\theta\\
0&1&0\\
-\sin\theta&0&\cos\theta\\
\end{bmatrix}
\begin{bmatrix}
1&0&0\\
0&\cos\psi&-\sin\psi\\
0&\sin\psi&\cos\psi\\
\end{bmatrix}\\
&=
\begin{bmatrix}
\cos\theta\cos\phi&\sin\psi\sin\theta\cos\phi-\cos\psi\sin\phi&\cos\psi\sin\theta\cos\phi+\sin\psi\sin\phi\\
\cos\theta\sin\phi&\sin\psi\sin\theta\sin\phi+\cos\psi\cos\phi&\cos\psi\sin\theta\sin\phi-\sin\psi\cos\phi\\
-\sin\theta&\sin\psi\cos\theta&\cos\psi\cos\theta
\end{bmatrix}
\end{split}\label{eq-extrinsic2}
$$

### Find two possible angles for $\theta$ based on element $R_{31}$ 

In $\eqref{eq-extrinsic2}$, we have:
$$
R_{31}=-\sin\theta\notag
$$
and therefore:
$$
\theta=-\asin(R_{31})\label{eqd-1}
$$
But it should be noted that, since:
$$
\sin(\pi-\theta)=\sin\theta\notag
$$
there exist two distinct values of $\theta$ that satisfy $\eqref{eqd-1}$ when $R_{31}\ne\pm1$, i.e.,
$$
\begin{split}
&\theta_1=-\asin(R_{31})\\
&\theta_2=\pi+\asin(R_{31})\\
\end{split}\label{eq-conclusion-1}
$$
are both valid. So, using the $R_{31}$ element of the rotation matrix, we could to determine two possible values for $\theta$.

N.B., The special case of $R_{31}=\pm1$ will be handled later.
{: .notice--warning}

### Find the corresponding angles of elements $R_{32}$ and $R_{33}$

In $\eqref{eq-extrinsic2}$, we have:
$$
\dfrac{R_{32}}{R_{33}}=\tan\psi\notag
$$
and therefore:
$$
\psi=\mathrm{atan2}({R_{32}},{R_{33}})\label{eqd-2}
$$
where $\mathrm{atan2}(y,x)$ is arc tangent of the two variables $x$ and $y$. It is similar to calculating the arc tangent of $y/x$, except that the signs of both arguments are used to determine the quadrant of the results, which lies in the range $[-\pi,\pi]$. The function $\mathrm{atan2}$ is available in many programming languages, like MATLAB `atan2` function for instance [[6]](#ref). 

For $\eqref{eqd-2}$, if $\cos\theta>0$, then $$\psi=\mathrm{atan2}(R_{32},R_{33})$$, but when $\cos\theta<0$, $$\psi=\mathrm{atan2}(-R_{32},-R_{33})$$. So, a simple way to handle this problem is use the equation:
$$
\psi=\mathrm{atan2}(\dfrac{R_{32}}{\cos\theta},\dfrac{R_{33}}{\cos\theta})\label{eqd-3}
$$
And for each value of $\theta$, we could compute a corresponding value of $\psi$ using $\eqref{eqd-3}$:
$$
\begin{split}
\psi_1=\mathrm{atan2}(\dfrac{R_{32}}{\cos\theta_1},\dfrac{R_{33}}{\cos\theta_1})\\
\psi_2=\mathrm{atan2}(\dfrac{R_{32}}{\cos\theta_2},\dfrac{R_{33}}{\cos\theta_2})\\
\end{split}\label{eq-conclusion-2}
$$
N.B., The special case of $\cos\theta=0$ will be handled later.
{: .notice--warning}

### Find the corresponding angles of $\psi$ based on elements $R_{21}$ and $R_{11}$

A similar analysis holds for finding $\phi$, in $\eqref{eq-extrinsic2}$, we have:
$$
\dfrac{R_{21}}{R_{11}}=\tan\phi\notag
$$
and we could solve $\phi$ using:
$$
\phi=\mathrm{atan2}(\dfrac{R_{21}}{\cos\theta},\dfrac{R_{11}}{\cos\theta})\label{eqd-4}
$$
And for each value of $\theta$, we could compute a corresponding value of $\psi$ using $\eqref{eqd-4}$:
$$
\begin{split}
\phi_1=\mathrm{atan2}(\dfrac{R_{21}}{\cos\theta_1},\dfrac{R_{11}}{\cos\theta_1})\\
\phi_2=\mathrm{atan2}(\dfrac{R_{21}}{\cos\theta_2},\dfrac{R_{11}}{\cos\theta_2})\\
\end{split}\label{eq-conclusion-3}
$$
N.B., The special case of $\cos\theta=0$ will be handled later as well.
{: .notice--warning}

### Two solutions if $\cos\theta\ne0$

To sum up, for the case of $\cos\theta\ne0$, we have two triplets of Euler angles that reproduce the rotation matrix, namely:
$$
\begin{split}
&(\psi_1,\theta_1,\phi_1)\\
&(\psi_2,\theta_2,\phi_2)\\
\end{split}
$$
Both of these solutions will be valid.

### What if $\cos\theta=0$?

The equations described above does not work if the $R_{31}$ element of the rotation matrix is $1$ or $-1$, which corresponds to $\theta=-\pi/2$ or $\theta=\pi/2$, respectively, and to $\cos\theta=0$. When we try to solve for the possible values of $\psi$ and $\phi$ using the above equations, problems will occur, since the elements $R_{11}$, $R_{21}$, $R_{32}$, and $R_{33}$ will all be zero, and $\eqref{eqd-3}$ and $\eqref{eqd-4}$ will become:
$$
\begin{split}
&\psi=\mathrm{atan2}(\dfrac00,\dfrac00)\\
&\phi=\mathrm{atan2}(\dfrac00,\dfrac00)\\
\end{split}
$$
In this case,  $R_{11}$, $R_{21}$, $R_{32}$, and $R_{33}$ do not constrain the values of $\psi$ and $\phi$. Therefore, we must use different elements of the rotation matrix to compute the values of $\psi$ and $\phi$.

(1) $\theta=\pi/2$ case

When $\theta=\pi/2$, equation $\eqref{eq-extrinsic2}$ could be simplified to:
$$
\begin{split}
R
&=
\begin{bmatrix}
0&\sin\psi\cos\phi-\cos\psi\sin\phi&\cos\psi\cos\phi+\sin\psi\sin\phi\\
0&\sin\psi\sin\phi+\cos\psi\cos\phi&\cos\psi\sin\phi-\sin\psi\cos\phi\\
-1&0&0
\end{bmatrix}
\end{split}
$$
i.e,
$$
\begin{split}
&R_{12}=\sin(\psi-\phi)\\
&R_{13}=\cos(\psi-\phi)\\
&R_{22}=\cos(\psi-\phi)=R_{13}\\
&R_{23}=\sin(\phi-\psi)=-R_{12}\\
\end{split}
$$

Any $\psi$ and $\phi$ that satisfy these equations will be a valid solution. Using the equations for $R_{12}$ and $R_{13}$, we could find that:
$$
(\psi-\phi)=\mathrm{atan2}(R_{12},R_{13})
$$
i.e.,
$$
\psi=\phi+\mathrm{atan2}(R_{12},R_{13})\label{eq-conclusion-4}
$$
(2) $\theta=-\pi/2$ case

When $\theta=-\pi/2$, equation $\eqref{eq-extrinsic2}$ could be simplified to:

$$
\begin{split}
R&=
\begin{bmatrix}
0&-\sin\psi\cos\phi-\cos\psi\sin\phi&-\cos\psi\cos\phi+\sin\psi\sin\phi\\
0&-\sin\psi\sin\phi+\cos\psi\cos\phi&-\cos\psi\sin\phi-\sin\psi\cos\phi\\
1&0&0
\end{bmatrix}
\end{split}
$$
i.e.,
$$
\begin{split}
&R_{12}=-\sin(\psi+\phi)\\
&R_{13}=-\cos(\psi+\phi)\\
&R_{22}=\cos(\psi+\phi)=-R_{13}\\
&R_{23}=-\sin(\psi+\phi)=R_{12}\\
\end{split}
$$
Using the equations for $R_{12}$ and $R_{13}$, we have:
$$
(\psi+\phi)=\mathrm{atan2}(-R_{12},-R_{13})
$$
i.e., 
$$
\psi=-\phi+\mathrm{atan2}(-R_{12},-R_{13})\label{eq-conclusion-5}
$$
In both the $\theta=\pi/2$ and $\theta=-\pi/2$ cases, we could find that $\psi$ and $\phi$ are linked. This phenomenon is called **Gimbal lock** [[7]](#ref). Although in this case, ==there are an infinite number of solutions to the problem, in practice, one is often interested in finding one solution. For this task, it is convenient to set $\phi=0$ and compute $\psi$ as described above==.

### Conclusion

According to $\eqref{eq-conclusion-1}$, $\eqref{eq-conclusion-2}$, $\eqref{eq-conclusion-3}$, $\eqref{eq-conclusion-4}$, and $\eqref{eq-conclusion-5}$, we could obtain the complete method for computing Euler angles from a rotation matrix:
$$
\begin{split}
&\text{if }R_{31}\ne\pm1\\
\quad&\begin{split}
\quad&\theta_1=-\asin(R_{31})\\
\quad&\theta_2=\pi-\theta_1\\
\quad&\psi_1=\mathrm{atan2}(\dfrac{R_{32}}{\cos\theta_1},\dfrac{R_{33}}{\cos\theta_1})\\
\quad&\psi_2=\mathrm{atan2}(\dfrac{R_{32}}{\cos\theta_2},\dfrac{R_{33}}{\cos\theta_2})\\
\quad&\phi_1=\mathrm{atan2}(\dfrac{R_{21}}{\cos\theta_1},\dfrac{R_{11}}{\cos\theta_1})\\
\quad&\phi_2=\mathrm{atan2}(\dfrac{R_{21}}{\cos\theta_2},\dfrac{R_{11}}{\cos\theta_2})\\
\end{split}\\
&\text{elseif }R_{31}=\pm1\\
&\quad\phi=\forall,\ \text{here is set to 0.}\\
\quad&\quad\text{if }\theta=\pi/2\\
\quad&\quad\begin{split}
&\quad\theta=\pi/2\\
&\quad\psi=\phi+\mathrm{atan2}(R_{12},R_{13})\\
\end{split}\\
\quad&\quad\text{elseif }\theta=-\pi/2\\
\quad&\quad\begin{split}
&\quad\theta=-\pi/2\\
&\quad\psi=-\phi+\mathrm{atan2}(-R_{12},-R_{13})\\
\end{split}\\
\quad&\quad\text{end}\\
&\text{end}
\end{split}\notag
$$

<br>

<div id="ref"></div>

**References**

[1] [Matrix and its Relation to Linear Transformation - What a starry night~](https://helloworld-1017.github.io/2022-06-11/17-06-09.html).

[2] [Rotation matrix - Wikipedia](https://en.wikipedia.org/wiki/Rotation_matrix).

[3] [旋转矩阵（Rotation Matrix）的推导及其应用 - meteoric_cry - 博客园](https://www.cnblogs.com/meteoric_cry/p/7987548.html).

[4] [旋转(Rotation)矩阵转欧拉角(euler）_tuszhangs的博客-CSDN博客](https://blog.csdn.net/weixin_39675633/article/details/103434557#:~:text=θ1 θ2 %3D −asin (R31) %3D π− θ1,%3D ±1 的情况。 因此，通过利用 R31 元素的值，我们可以确定 θ 的两个不同的值。).

[5] Gregory G. Slabaugh, [Computing Euler angles from a rotation matrix](https://eecs.qmul.ac.uk/~gslabaugh/publications/euler.pdf).

[6] [`atan2`: Four-quadrant inverse tangent - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/atan2.html).

[7] [Gimbal lock - Wikipedia](https://en.wikipedia.org/wiki/Gimbal_lock).





