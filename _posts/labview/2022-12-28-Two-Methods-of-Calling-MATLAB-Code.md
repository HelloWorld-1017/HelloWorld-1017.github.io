---
title: Two Methods of Calling MATLAB Code in LabVIEW
toc: false
categories: 
 - LabVIEW
 - MATLAB
date: 2022-12-28 20:51:50 +0800
last_modified_at: 2024-10-23 19:48:21 +0800
---

LabVIEW官方以求解Lorenz Attractor differential equation(洛伦兹吸引子微分方程)为例，提供了两个调用MATLAB代码的范例，对应着两种调用MATLAB代码的方式。

第一个范例为`MATLAB script node - Lorenz Diff Eq.vi`，该示例是通过`MATLAB script node`模块承载MATLAB代码。在`MATLAB script node`模块中调用的函数需要传入提前传入绝对地址。

该范例的程序框图为：

![image-20221228202953549](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228202953549.png?raw=true)

所对应的前面板为：

![image-20221228203111483](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228203111483.png?raw=true)

第二个范例是`MATLAB node - Lorenz Diff Eq.vi`，该范例并不在LabVIEW中键入MALTAB代码，而是直接通过地址来调用函数文件。

程序框图为：

![image-20221228203622475](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228203622475.png?raw=true)

前面板为：

![image-20221228203642294](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228203642294.png?raw=true)

直接调用的函数`LorenzDiffEq.m`：

```matlab
function[t,Y] = LorenzDiffEq()
    y= [1, 1, 1];
    n = 30 / 0.05;
    
    % Generate a vector of values which are 
    % linearly spaced between 0 and 30
    T = linspace(0, 30, n);
    
    % Solve nonstiff differential equations — low order method
    [t, Y] = ode23('LorenzEqs',T, y );

end
```

使用第二种方式需要注意的是：

- `打开MATLAB会话`([Open MATLAB Session Function](https://www.ni.com/docs/en-US/bundle/labview/page/glang/open_matlab_session.html))、`调用MATLAB函数`([Call MATLAB Function](https://www.ni.com/docs/en-US/bundle/labview/page/glang/run_matlab_function.html))和`关闭MATLAB会话`([Close MATLAB Session Function](https://www.ni.com/docs/en-US/bundle/labview/page/glang/close_matlab_session.html))这三个函数需要一起使用。

  ![image-20221228204733417](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228204733417.png?raw=true)

- `Call MATLAB Function`函数的输出需要进行解除捆绑操作(Unbundle):

  ![image-20221228204921517](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228204921517.png?raw=true)

<br>