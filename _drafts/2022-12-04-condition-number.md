在数值分析领域，function的条件数(condition number)衡量了当function的input argument发生了很小的变化时，output value的变化程度。常用于测量function对输入的变化或者错误的敏感程度， 以及input中的错误会导致的output的错误程度。通常情况下，人们都是在解决inverse problem：给定$f(x)=y$，求解$x$，因此必须使用(local) inverse的条件数。在线性回归中，moment matrix的条件数可以用于诊断多重共线性(multicollinearity)。

条件数是导数的一个应用，正是定义为输入相对变化时输出的渐进最坏情况的相对相对变化值(value of the asymptotic worst-case relative change)。

“function”是问题的解决方案，而“argument”是问题中的数据。

条件数被频繁应用于线性代数的求解问题中，在这种情况下，导数是straightforward，但误差可能在不同的方向上，因此可以根据矩阵的几何结构来计算条件数。更一般地情况，可以由多变量地非线性function进行定义。

一个具有低条件数的问题被称作是well-conditioned，而具有高条件数的问题被称作是ill-conditioned。在非数学术语中，病态问题是指输入（自变量）发生微小变化时，答案或因变量发生较大变化的问题。这意味着很难找到方程的正确解/答案。

条件数是问题本身的性质，而与求解问题的算法无关。解决问题的算法由很多，有一些算法具有*[backward stability](https://en.wikipedia.org/wiki/Numerical_stability)*的性质，一般而言，后向稳定的算法能够准确地解决well-conditioned问题。一些数值分析的书给出了一些问题的条件数计算公式，并且给出了一些已知的后向稳定的算法。

根据经验，如果条件数$\mathcal{k}(A)=10^k$，那么在计算的过程中可能会损失多达$k$位数的精度，而数值方法的使用会使精度损失进一步加大。 然而，条件数并不给出在算法中可能丢失的最大精度的准确值，它通常只是用一个估计值（其计算值取决于度量不准确度的范数的选择）来界定。





[What is the Condition Number of a Matrix? » Cleve’s Corner: Cleve Moler on Mathematics and Computing - MATLAB & Simulink (mathworks.com)](https://blogs.mathworks.com/cleve/2017/07/17/what-is-the-condition-number-of-a-matrix/?from=cn)