【MATLABOptimization Toolbox】使用 Problem-Based 方法求解有理函数以及 `solve` 函数


# Problem-Based 方法求解有理函数

本实例展示了使用 MATLAB Optimization Toolbox 中的 Problem-Based 方法求解有理函数，本实例来自：[Rational Objective Function, Problem-Based](https://ww2.mathworks.cn/help/optim/ug/rational-objective-function.html)

有理函数是多项式的商。比如求解有理函数：

$$
f=\dfrac{(x-y)^2}{4+(x+y)^4}\dfrac{x+y^2}{1+y^2}\notag
$$

## 求解步骤

（1）设置求解变量和目标函数

```matlab
% Write objective function
x = optimvar('x');
y = optimvar('y');
f = (x-y)^2/(4+(x+y)^4)*(x+y^2)/(1+y^2);
```

（2）创建 optimization problem

```matlab
% Create an optimization problem
prob = optimproblem('Objective',f);
```

（3）为求解器设置初值，并使用 `solve` 函数求解

```matlab
% Set initial points, and call solve
x0.x = -1;
x0.y = 1;
[sol,fval,exitflag,output] = solve(prob,x0)
```

## 输出结果

运行程序，命令行中显示

```matlab
>> script1

Solving problem using fminunc.

Local minimum found.

Optimization completed because the size of the gradient is less than
the value of the optimality tolerance.

<stopping criteria details>
```

点击 `<stopping criteria details>` 显示如下信息

```matlab
Optimization completed: The first-order optimality measure, 7.499390e-08, is less 
than options.OptimalityTolerance = 1.000000e-06.
```

输出变量的信息：

```matlab
sol = 

  struct with fields:

    x: -2.1423
    y: 0.7937
```

结构体 `sol` 中保存着最小值处变量 x 和 y 的值。

```matlab
fval =

   -1.0945
```

变量 `fval` 为函数最小值。

```matlab
exitflag = 

    OptimalSolution
```

变量 `exitflag` 表示算法终止信息。

```matlab
output = 

  struct with fields:

             iterations: 9
              funcCount: 10
               stepsize: 1.7073e-06
           lssteplength: 1
          firstorderopt: 1.4999e-07
              algorithm: 'quasi-newton'
                message: 'Local minimum found.↵↵Optimization completed because the size of the gradient is less than↵the value of the optimality tolerance.↵↵<stopping criteria details>↵↵Optimization completed: The first-order optimality measure, 7.499390e-08, is less ↵than options.OptimalityTolerance = 1.000000e-06.'
    objectivederivative: "reverse-AD"
                 solver: 'fminunc'
```

结构体 `output` 保存着求解信息。

<br>

# `solve` 函数

在上述求解步骤中，使用的是 `solve` 函数（[solve - Mathworks](https://ww2.mathworks.cn/help/symbolic/solve.html)），`solve` 函数实际上是 MATLAB Math Toolbox 的一个函数，它也可以用于求解符号方程或者符号不等式。

## 求解符号方程

### 实例1：求解一元二次符号方程

求解一元二次方程的求根公式：

```matlab
syms a b c x
eqn = a*x^2 + b*x + c == 0

S = solve(eqn, x)
```

```matlab
>> script2
eqn =
a*x^2 + b*x + c == 0
 
S =
-(b + (b^2 - 4*a*c)^(1/2))/(2*a)
-(b - (b^2 - 4*a*c)^(1/2))/(2*a)
```

同时可以指定求解变量：

```matlab
Sa = solve(eqn, a)
```

```matlab
Sa =
 
-(c + b*x)/x^2
```

### 实例2：求解一元三次方程的根

但是该函数不能求解一些复杂的问题，比如求解一元三次方程的解：

```matlab
syms a b c d x
eqn = a*x^3 + b*x^2 + c*x + d == 0;

S = solve(eqn, x)
```

```matlab
>> script2
S =
root(a*z^3 + b*z^2 + c*z + d, z, 1)
root(a*z^3 + b*z^2 + c*z + d, z, 2)
root(a*z^3 + b*z^2 + c*z + d, z, 3)
```

该结果的含义就是得到的三个根是分别是方程 $az^2+bz^2+cz+d=0$ 的三个根。

这时，需要设置求解器的 `MaxDegree` 参数。这个选项指定了求解器试图返回解析解的多项式最高次项的次数。

```matlab
syms a b c d x
eqn = a*x^3 + b*x^2 + c*x + d == 0;

S = solve(eqn, x, 'MaxDegree', 3)
```

```matlab
>> script2
S =
(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3) - b/(3*a) - (- b^2/(9*a^2) + c/(3*a))/(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)
(- b^2/(9*a^2) + c/(3*a))/(2*(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)) - (3^(1/2)*((- b^2/(9*a^2) + c/(3*a))/(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3) + (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3))*1i)/2 - b/(3*a) - (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)/2
(- b^2/(9*a^2) + c/(3*a))/(2*(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)) + (3^(1/2)*((- b^2/(9*a^2) + c/(3*a))/(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3) + (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3))*1i)/2 - b/(3*a) - (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (- b^2/(9*a^2) + c/(3*a))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)/2
```

### 实例3：求解复数根

但是，`solve` 函数是可以求解出复数根的：

```matlab
syms x
eqn = x^5 == 3125;
S = solve(eqn,x)
```

```matlab
>> script3
S =
                                                         5
- (2^(1/2)*(5 - 5^(1/2))^(1/2)*5i)/4 - (5*5^(1/2))/4 - 5/4
  (2^(1/2)*(5 - 5^(1/2))^(1/2)*5i)/4 - (5*5^(1/2))/4 - 5/4
  (5*5^(1/2))/4 - (2^(1/2)*(5^(1/2) + 5)^(1/2)*5i)/4 - 5/4
  (5*5^(1/2))/4 + (2^(1/2)*(5^(1/2) + 5)^(1/2)*5i)/4 - 5/4
```

并且可以指定只返回实数根

```matlab
syms x
eqn = x^5 == 3125;
S = solve(eqn,x,"Real",true)
```

```matlab
>> script3
S =
5
```

### 示例4：使用简化规则

对于求解方程：
$$
\exp(\log(x)\log(3x)) = 4\notag
$$
在默认情况下，`solve` 函数并不会应用简化规则，它并不会假定 x 是一个正实数，因此它就不会应用类似 $\log(3x)=\log(3)+\log(x)$ 的运算法则。最终，`solve` 无法对方程进行符号求解。

```matlab
syms x
eqn = exp(log(x)*log(3*x)) == 4;
S = solve(eqn,x)
```

```matlab
>> script4
Warning: Unable to solve symbolically. Returning a numeric
solution using vpasolve. 
> In sym/solve (line 304)
In script4 (line 3) 
 
S =
 
- 14.009379055223370038369334703094 - 2.9255310052111119036668717988769i
```

此时，我们可以设置 `IgnoreAnalyticConstraints` 为 `true` 以应用简化规则，详见：[solve - Algorithms](https://ww2.mathworks.cn/help/symbolic/solve.html#bue1fkj-6)

```matlab
S = solve(eqn,x,'IgnoreAnalyticConstraints',true)
```

```matlab
>> script4
S =
(3^(1/2)*exp(-(log(256) + log(3)^2)^(1/2)/2))/3
 (3^(1/2)*exp((log(256) + log(3)^2)^(1/2)/2))/3
```

## 求解不等式

对于不等式
$$
\begin{align}
&x>0\notag \\
&y>0\notag\\
&x^2+y^2+xy<1\label{ieq1}
\end{align}
$$
将 `Simplification Rules` 设置为 `true` 来返回 ny parameters in the solution and conditions on the solution。

```matlab
syms x y
eqn1 = x > 0;
eqn2 = y > 0;
eqn3 = x^2 + y^2 + x*y < 1;
eqns = [eqn1 eqn2 eqn3];

S = solve(eqns,[x y],'ReturnConditions',true);
```

```matlab
>> S.parameters
ans =
[u, v]
 
>> S.x
ans =
(- 3*v^2 + u)^(1/2)/2 - v/2

>> S.y
ans =
v
 
>> S.conditions
ans =
4*v^2 < u & u < 4 & 0 < v
```

<br>

下面解释一下上述结果的含义。

不等式 $\eqref{ieq1}$ 实际上定义了三维空间中的一个曲面，如下图所示：

![image-20220818153304623](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220818153304623.png)

```matlab
clc, clear, close all

t = 0:0.01:1;
[x, y] = meshgrid(t);
z = x.^2+y.^2+x.*y-1;
mesh(x, y, z)
xlabel('x')
ylabel('y')
zlabel('z')
axis([0 1 0 1 -1 0])
colormap("jet")
```

MATLAB 在求解该不等式的时候，实际上求解的是 x 和 y 的参数形式，并且给出参数的取值范围。根据求解结果，我们可以得到：
$$
\begin{align*}
x&=\dfrac{\sqrt{u-3v^2}}2-\dfrac{v}2\\
y&=v
\end{align*}
$$
参数取值范围为：
$$
\{4v^2<u\}\cap\{u<4\}\cap\{v>0\}\label{C1}
$$
参数 `u` 和 `v`  并不在 MATLAB workspace 中，需要使用 `S.parameters` 进行设置。例如，我们令 $u=7/2$ ，$v=1/2$ ，并且查看这个取值是否满足约束 $\eqref{C1}$ 。

```matlab
condWithValues = subs(S.conditions, S.parameters, [7/2,1/2]);
isAlways(condWithValues)
```

```
ans = logical
   1
```

`isAlways` 返回逻辑 1 (`true`) ，说明 $u=7/2$ ，$v=1/2$ 的取值满足不等式，并且我们可以获得 x 和 y 的值：

```matlab
xSol = subs(S.x, S.parameters, [7/2,1/2])
ySol = subs(S.y, S.parameters, [7/2,1/2])
```

```matlab
xSol =
11^(1/2)/4 - 1/4

ySol =
1/2
```

==参数方程绘图==





