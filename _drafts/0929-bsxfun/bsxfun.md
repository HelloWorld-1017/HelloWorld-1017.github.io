基本用法

`C = bsxfun(@(x, y) func, A, B)`

- `@(x, y) func`表示一个匿名函数，`x`和`y`是匿名函数的形参；
- `A`和`B`分别是匿名函数形参`x`和`y`的具体取值；
- `C`是返回的向量（或者矩阵）；
- 另外，该函数仅支持两个向量的输入。

如果`A`和`B`都是具有4个元素的行向量，





例如：

```matlab
% A, 1-by-4; B, 1-by-4
C = bsxfun(@(a, b) a-b, [1, 2, 3, 4], [6, 9, 7, 10]);
```

```matlab
C =
    -5    -7    -4    -6
```

如果`A`和`B`是具有3个元素的列向量；



例如：

```matlab
% A, 3-by-1; B, 3-by-1
C = bsxfun(@(a, b) a-b, [1, 2, 3]', [6, 9, 7]');
```

```matlab
C =
    -5
    -7
    -4
```

如果`A`是具有3个元素的列向量，`B`是具有4个元素的行向量：



例如：

```matlab
% A, 3-by-1; B, 1-by-4
C = bsxfun(@(a, b) a-b, [1, 2, 3]', [6, 9, 7, 10]);
```

```matlab
C =
    -5    -8    -6    -9
    -4    -7    -5    -8
    -3    -6    -4    -7
```

如果`A`是具有3个元素的行向量，`B`是具有4个元素的列向量：



```matlab
% A, 1-by-3; B, 4-by-1
C = bsxfun(@(a, b) a-b, [1, 2, 3], [6, 9, 7, 10]');
```

```matlab
C =
    -5    -4    -3
    -8    -7    -6
    -6    -5    -4
    -9    -8    -7
```







# Usage for Plot Profiles with Different Parameters





'UniformOutput'的使用。



[1] [bsxfun - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/bsxfun.html).
