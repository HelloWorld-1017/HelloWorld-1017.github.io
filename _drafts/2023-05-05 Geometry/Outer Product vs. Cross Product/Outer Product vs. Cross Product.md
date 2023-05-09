Outer Product vs. Cross Product



# Cross Product

## Definition of cross product

向量$\boldsymbol{a}$和向量$\boldsymbol{b}$之间的叉积（cross product，又称为矢量积，vector product）**只**定义在三维空间，表示为：
$$
\boldsymbol{a}\times\boldsymbol{b}
$$
在物理和应用数学中，楔形符号（wedge notation）$\boldsymbol{a}\wedge\boldsymbol{b}$也经常被用于表示叉积，但是在纯数学中，$\boldsymbol{a}\wedge\boldsymbol{b}$通常用于表示矢量积抽象到$n$维空间的Exterior product的概念。

叉积$\boldsymbol{a}\times\boldsymbol{b}$定义了一个垂直于向量$\boldsymbol{a}$和向量$\boldsymbol{b}$的向量$\boldsymbol{c}$，矢量$\boldsymbol{c}$的方向满足右手定则：

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Right_hand_rule_cross_product.svg/1200px-Right_hand_rule_cross_product.svg.png" alt="Right hand rule cross product.svg" style="zoom: 33%;" >

而矢量$\boldsymbol{c}$的幅值等于向量$\boldsymbol{a}$和向量$\boldsymbol{b}$所张成的平行四边形的面积。

用定义式表示上述关系为：
$$
\boldsymbol{a}\times\boldsymbol{b}=\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}\vert\vert\sin\theta\cdot\boldsymbol{n},\ \theta\in[0,180]
$$
其中，若向量$\boldsymbol{a}$和向量$\boldsymbol{b}$是平行的，即向量$\boldsymbol{a}$和向量$\boldsymbol{b}$之间的夹角为$0^\circ$或者$180^\circ$，则向量$\boldsymbol{a}$和向量$\boldsymbol{b}$的叉积是零向量$\boldsymbol{0}$。

另外，由于寻找向量$\boldsymbol{c}$的方向遵从右手定则，因此可以得到关系式：
$$
\boldsymbol{b}\times\boldsymbol{a}=-(\boldsymbol{a}\times\boldsymbol{b})
$$

## Computing cross product

在计算$\boldsymbol{a}\times\boldsymbol{b}$时，通常使用矩阵记法（3阶行列式）进行计算：
$$
\begin{split}
\boldsymbol{a}\times\boldsymbol{b}&=
\begin{vmatrix}
\boldsymbol{\mathrm{i}}&\boldsymbol{\mathrm{j}}&\boldsymbol{\mathrm{k}}\\
a_1&a_2&a_3\\
b_1&b_2&b_3\\
\end{vmatrix}\\
&=(a_2b_3-a_3b_2)\boldsymbol{\mathrm{i}}+(a_3b_1-a_1b_3)\boldsymbol{\mathrm{j}}+(a_1b_2-a_2b_1)\boldsymbol{\mathrm{k}}
\end{split}
$$
Cross product这个名字的也是受启发于这种3阶行列式计算方法：

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Sarrus_rule_cross_product_ab.svg/1200px-Sarrus_rule_cross_product_ab.svg.png" alt="Sarrus rule cross product ab.svg" style="zoom:33%;" >

## Geometric meaning

如果$(\boldsymbol{\mathrm{i}},\boldsymbol{\mathrm{j}},\boldsymbol{\mathrm{k}})$是一组正向正交基，则它们之间的叉积满足：
$$
\begin{split}
&\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{j}}=\boldsymbol{\mathrm{k}}\\
&\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{k}}=\boldsymbol{\mathrm{i}}\\
&\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{i}}=\boldsymbol{\mathrm{j}}\\
\end{split}
$$

$$
\begin{split}
&\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{i}}=-\boldsymbol{\mathrm{k}}\\
&\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{j}}=-\boldsymbol{\mathrm{i}}\\
&\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{k}}=-\boldsymbol{\mathrm{j}}\\
\end{split}
$$

且：
$$
\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{i}}=\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{j}}=\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{k}}=\boldsymbol{0}
$$
因此：
$$
\begin{split}
\boldsymbol{a}\times\boldsymbol{b}=&(a_1\boldsymbol{\mathrm{i}}+a_2\boldsymbol{\mathrm{j}}+a_3\boldsymbol{\mathrm{k}})\times(b_1\boldsymbol{\mathrm{i}}+b_2\boldsymbol{\mathrm{j}}+b_3\boldsymbol{\mathrm{k}})\\
=&a_1b_1(\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{i}})+a_1b_2(\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{j}})+a_1b_3(\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{k}})+\\
&a_2b_1(\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{i}})+a_2b_2(\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{j}})+a_2b_3(\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{k}})+\\
&a_3b_1(\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{i}})+a_3b_2(\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{j}})+a_3b_3(\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{k}})\\
=&(a_2b_3-a_3b_2)\boldsymbol{\mathrm{i}}+(a_3b_1-a_1b_3)\boldsymbol{\mathrm{j}}+(a_1b_2-a_2b_1)\boldsymbol{\mathrm{k}}
\end{split}
$$
使用列向量表示计算的结果，有：
$$
\begin{split}
\begin{bmatrix}
c_1\\
c_2\\
c_3
\end{bmatrix}=
\begin{bmatrix}
a_2b_3-a_3b_2\\
a_3b_1-a_1b_3\\
a_1b_2-a_2b_1
\end{bmatrix}
\end{split}
$$
向量记法计算的结果与矩阵记法计算的结果是一致的，但是之前总是看到矩阵记法的叉积计算公式，第一次看到这种向量记法的计算式，觉得还是挺有意思的~

<br>

正如前文提到过的，向量$\boldsymbol{a}$和向量$\boldsymbol{b}$的叉积等于两个向量所张成的平行四边形的正面积：
$$
\vert\vert\boldsymbol{a}\times\boldsymbol{b}\vert\vert=\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}\vert\vert\ \vert\sin\theta\vert
$$
<img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Cross_product_parallelogram.svg" alt="Cross product parallelogram.svg" height="375" width="480" style="zoom: 50%;" >

进一步地，以向量$\boldsymbol{a}$，$\boldsymbol{b}$和$\boldsymbol{c}$作为边的平行六面体（parallelepiped）的面积可以通过叉积和点积的组合（称为scalar triple product，即标量三重积）进行计算：

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Parallelepiped_volume.svg/1200px-Parallelepiped_volume.svg.png" alt="Parallelepiped volume.svg" style="zoom: 33%;" >
$$
\boldsymbol{a}\cdot(\boldsymbol{b}\times\boldsymbol{c})=
\boldsymbol{b}\cdot(\boldsymbol{c}\times\boldsymbol{a})=
\boldsymbol{c}\cdot(\boldsymbol{a}\times\boldsymbol{b})
$$
由于标量三重积的结果可能是负值，因此平行六面体体的体积可以使用其绝对值进行表示：
$$
V=\vert\boldsymbol{a}\cdot(\boldsymbol{b}\times\boldsymbol{c})\vert
$$
<br>

对比叉积和内积的定义式 ==[XX]==：
$$
\begin{split}
&\text{Dot product}: \\
&\text{Cross product}: \boldsymbol{a}\times\boldsymbol{b}=\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}\vert\vert\sin\theta\cdot\boldsymbol{n}
\end{split}
$$








<br>

**References**

[1] [Outer product - Wikipedia](https://en.wikipedia.org/wiki/Outer_product).

[2] [Cross product - Wikipedia](https://en.wikipedia.org/wiki/Cross_product).

[3] [Exterior algebra - Wikipedia](https://en.wikipedia.org/wiki/Exterior_algebra).





