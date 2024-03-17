---
layout: single
title: Activation Functions of Neural Networks in MATLAB
categories:
 - MATLAB
 - Machine Learning
 - Mathematics
tags:
 - MATLAB Deep Learning Toolbox
date: 2024-03-15 14:46:34 +0800
last_modified_at0: 2024-03-15 14:46:34 +0800
last_modified_at: 2024-03-15 14:46:34 +0800
---

# Sigmoid activation function

The **Sigmoid** activation function is:

$$
\sigma(x)=\dfrac{1}{1+e^{-x}}
$$

we could calculate it using MATLAB `sigmoid` function[^1]:

```matlab
x = dlarray(-5:0.1:5);

figure("Color","w")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"DataAspectRatio",[1,1,1],"FontSize",12)
plot(x,sigmoid(x),"LineWidth",1.5,"Color","b")
xlabel("x")
ylabel("Sigmoid(x)")
xticks(-5:5)
ylim([-5,5])
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403151106725.png" alt="image-20240315110619562" style="zoom:67%;" />

<br>

# ReLU activation function (Rectified Linear Unit)

The **ReLU (Rectified Linear Unit)** activation function is:

$$
f(x)=\left\{\begin{split}
x,\ & x>0\\
0,\ & x\le0\\
\end{split}\right.
$$

we could calculate it using `relu` function[^2]:

```matlab
x = dlarray(-5:0.1:5);

figure("Color","w")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"DataAspectRatio",[1,1,1],"FontSize",12)
plot(x,relu(x),"LineWidth",1.5,"Color","b")
xlabel("x")
ylabel("ReLU(x)")
xticks(-5:5)
ylim([-5,5])
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403142256900.png" alt="image-20240314225625825" style="zoom: 67%;" />

<br>

# Leaky ReLU activation function

The **Leaky ReLU** activation function is:

$$
f(x)=\left\{\begin{split}
&x,\ & x>0\\
&\text{scale}\times x,\ & x\le0\\
\end{split}\right.
$$

where $\text{scale}$ is scale factor of Leaky ReLU. We could calculate it using `leakyrelu` function[^3]:

```matlab
x = dlarray(-5:0.1:5);

figure("Color","w")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"DataAspectRatio",[1,1,1],"FontSize",12)
plot(x,leakyrelu(x),"LineWidth",1.5,"Color","b","DisplayName","Default scale: 0.01")
plot(x,leakyrelu(x,0.05),"LineWidth",1.5,"Color","r","DisplayName","Scale: 0.05")
plot(x,leakyrelu(x,0.1),"LineWidth",1.5,"Color","g","DisplayName","Scale: 0.1")
xlabel("x")
ylabel("Leaky ReLU")
xticks(-5:5)
ylim([-5,5])
legend("Location","southeast")
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403142300579.png" alt="image-20240314230014526" style="zoom:67%;" />

<br>

# Gaussian error linear unit activation function (GELU)

The **GELU (Gaussian error linear unit)** activation function is[^4]:

$$
\text{GELU}(x)=\dfrac{x}2\big(1+\mathrm{erf}(\dfrac{x}{\sqrt{2}})\big)
$$

where $\text{erf}(x)$ is the error function:

$$
\text{erf}(x)=\dfrac2{\sqrt\pi}\int_0^x\mathrm{e}^{-t^2}\mathrm{d}t
$$

we could calculate it using `gelu` function[^4]. Besides,  tanh method can be used to approximate $\text{erf}(x)$ by specifying `"Approximation"` property of `gelu` function as `"tanh"`:

$$
\text{erf}(\dfrac{x}{\sqrt2})\approx\text{tanh}\big(\sqrt{\dfrac2\pi}(x+0.44715x^3)\big)
$$

```matlab
x = dlarray(-5:0.1:5);

figure("Color","w")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"DataAspectRatio",[1,1,1],"FontSize",12)
plot(x,gelu(x),"LineWidth",1.5,"Color","b","DisplayName","Approximation method (default): none")
plot(x,gelu(x,"Approximation","tanh"),"LineWidth",1.5,"Color","r","DisplayName","Approximation method: tanh")
xlabel("x")
ylabel("GELU")
xticks(-5:5)
ylim([-5,5])
legend("Location","southeast")
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403151243856.png" alt="image-20240315124350742" style="zoom:67%;" />

As can be seen, the output values are not significantly different regardless of whether approximation method `"tanh"` is used or not. I guess maybe the function of approximation is to save computation time.

And note that, `gelu` function is only available from **MATLAB R2022b version**.

<br>

# tanh activation function (Heperbolic tangent)

The tanh activation function is:

$$
\text{tanh}(x)=\dfrac{\text{sinh}(x)}{\text{cosh}(x)}=\dfrac{\mathrm{e}^{2x}-1}{\mathrm{e}^{2x}+1}
$$

where $\text{sinh}(x)$ is hyperbolic sine[^6]:

$$
\text{cosh}(x)=\dfrac{\mathrm{e}^{x}-\mathrm{e}^{-x}}{2}
$$

and $\text{cosh}(x)$ is hyperbolic cosine[^7]:

$$
\text{cosh}(x)=\dfrac{\mathrm{e}^{x}+\mathrm{e}^{-x}}{2}
$$

we could calculate it using `gelu` function[^5]:

```matlab
x = dlarray(-5:0.1:5);

figure("Color","w")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"DataAspectRatio",[1,1,1],"FontSize",12)
plot(x,tanh(x),"LineWidth",1.5,"Color","b")
xlabel("x")
ylabel("tanh(x)")
xticks(-5:5)
ylim([-5,5])
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403151207474.png" alt="image-20240315120757149" style="zoom:67%;" />

By the way, not like other activation functions aforementioned, `tanh` function is not provided by MATLAB Deep Learning Toolbox, but from basic MATLAB Mathematics, so it is not necessary to convert input to `dlarray` data type.

# Contrast above activation functions

```matlab
x = dlarray(-5:0.1:5);

figure("Color","w")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"DataAspectRatio",[1,1,1],"FontSize",12)
plot(x,sigmoid(x),"LineWidth",1.5,"DisplayName","sigmoid")
plot(x,relu(x),"LineWidth",1.5,"DisplayName","ReLU")
plot(x,leakyrelu(x,0.1), ...
    "LineWidth",1.5,"DisplayName","Leaky ReLU (Scale: 0.1)")
plot(x,gelu(x),"LineWidth",1.5,"DisplayName","GELU")
plot(x,tanh(x),"LineWidth",1.5,"DisplayName","tanh")
xlabel("x")
ylabel("Activation value")
xticks(-5:5)
ylim([-5,5])
legend("Location","south")
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403151428995.png" alt="image-20240315142839886" style="zoom:67%;" />

<br>

**References**

[^1]: [MATLAB `sigmoid`: Apply sigmoid activation - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.sigmoid.html).
[^2]: [MATLAB `relu`: Apply rectified linear unit activation -  - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.relu.html).
[^3]: [MATLAB `leakyrelu`: Apply leaky rectified linear unit activation - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.leakyrelu.html).
[^4]: [MATLAB `gelu`: Apply Gaussian error linear unit (GELU) activation - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.gelu.html).
[^5]: [MATLAB `tanh`: Hyperbolic tangent - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/tanh.html)
[^6]: [MATLAB `sinh`: Hyperbolic sine  - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/sinh.html).
[^7]: [MATLAB `cosh`: Hyperbolic cosine -MathWorks](https://ww2.mathworks.cn/help/matlab/ref/cosh.html).

