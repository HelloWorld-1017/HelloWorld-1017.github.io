std var cov funcitons in MATLAB

在MATLAB中，`std`函数、`var`函数和`cov`函数都是用来计算描述样本散布特征特征的函数，分别用于计算标准差(Standard deviation)、方差(Variance)和协方差矩阵(Covariance matrix)。但是，当函数的输入是一个矩阵或者是多个向量时，它们所输出的结果比较容易混淆，本文就简单梳理一下它们计算的原理，和在指定不同输入时输出的形式。

# 方差和标准差

## 输入为单个向量

首先，按照定义，标准差和方差是紧密联系的：

> 定义1(方差，Variance；标准差，Standard deviation)
>
> 设$X$为随机变量，分布为$F$，则：
> $$
> \mathrm{Var}(X)=E(X-EX)^2\label{variance}
> $$
> 称为$X$(或其分布)的**方差**，其平方根$\sqrt{\mathrm{Var}(X)}$(取正值)称为$X$(或其分布)的标准差。

比如对于单个样本，我们计算方差和标准差：

```matlab
a = [2, 3, 4, 7, 9];
var_builtin = var(a, 1);
var_custom = mean((a-mean(a)) .* (a-mean(a)));

std_builtin = std(a, 1);
std_custom = sqrt(mean((a-mean(a)) .* (a-mean(a))));
```

```matlab
var_builtin =
    6.8000
var_custom =
    6.8000
std_builtin =
    2.6077
std_custom =
    2.6077
```

需要注意的是，在使用MATLAB的`var`和`std`函数时，都使用了`1`这个flag，这表示此时计算的结果是有偏的。如果不设置`flag`，则`flag`的默认值为`0`，表示计算无偏的结果：





## 输入矩阵

