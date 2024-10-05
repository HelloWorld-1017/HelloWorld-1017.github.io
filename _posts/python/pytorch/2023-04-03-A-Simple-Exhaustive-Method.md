---
title: A Simple Exhaustive Method for Selecting Optimum Weight of Linear Model
toc: false
categories: 
 - Machine Learning
 - Python
tags:
 - Python Graphics
 - Python Matplotlib
date: 2023-04-03 16:44:31 +0800
last_modified_at: 2024-05-25 09:48:11 +0800
---

对于一组数据：

$$
\begin{split}
x:1,2,3\\
y:2,4,6
\end{split}\notag
$$

如何得到$x$和$y$之间所对应的关系呢（尽管这个关系很明显，就是$y=2x$）？一种思路是选取一种模型，并穷举这个模型所有系数的可能取值，之后求解出在相应系数组合下，所有的$x$的预测值$\hat{y}$与真实值$y$之间的误差。最终，可以获得一条误差随权重系数变化的曲线，观察分析曲线，就能够得到最优的（即使得误差最小的）权重系数组合。

如果我们选取的模型是不带有bias的线性模型，并使用MSE（Mean Square Error）来度量误差，则可以编写程序如下：

```python
import numpy as np
import matplotlib.pyplot as plt

# Training Set
x_data = [1.0, 2.0, 3.0]
y_data = [2.0, 4.0, 6.0]

def forward(x): # Define model
    return x * w

def loss(x, y): # Define loss function
    y_pred = forward(x)
    return (y_pred - y) * (y_pred - y)

w_list = []    # For saving weights w
mse_list = []  # For saving MSE

for w in np.arange(0.0, 4.1, 0.1): # Exhaustive method for selecting optimum weight
    print('w =', w)
    l_sum = 0 # Reset total sum
    for x_val, y_val in zip(x_data, y_data):
        # Predict value (just for print)
        y_pred_val = forward(x_val)
        # Calculate loss for each sample
        loss_val = loss(x_val, y_val)
        # Print information of each sample
        print('\t', x_val, y_val, y_pred_val, loss_val)
        # Accumulate loss value
        l_sum += loss_val
    print('MSE =', l_sum / 3)
    w_list.append(w)
    mse_list.append(l_sum / 3)
# Plot the change of MSE as a function of weights
plt.plot(w_list, mse_list)
# Scatter the ponit corresponding minimum MSE
min_idx = mse_list.index(min(mse_list))
plt.scatter(w_list[min_idx], mse_list[min_idx],c='red')
# Axes settings
plt.ylabel('Loss')
plt.xlabel('w')
plt.show()
```

![image-20230403155351323](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230403155351323.png?raw=true)

虽然这个示例非常得简单，但是其思想是通用的。

进一步地，如果考虑遍历线性模型的bias，则可以得到类似的结果和图像：

```python
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Training Set
x_data = [1.0, 2.0, 3.0]
y_data = [2.0, 4.0, 6.0]

def forward(x): # Define model
    return (x * w + b)

def loss(x, y): # Define loss function
    y_pred = forward(x)
    return (y_pred - y) * (y_pred - y)

mse_list = []  # For saving MSE

ws = np.arange(0.0, 4.1, 0.01)
bs = np.arange(-1.0, 1.1, 0.01)

Ws,Bs = np.meshgrid(ws,bs)

for w,b in zip(Ws.flatten(),Bs.flatten()):
    l_sum = 0 # Reset total sum
    for x_val, y_val in zip(x_data, y_data):
        # Calculate loss for each sample
        loss_val = loss(x_val, y_val)
        # Accumulate loss value
        l_sum += loss_val
    print('MSE =', l_sum / 3)
    mse_list.append(l_sum / 3)


# Plot the change of MSE as a function of weights and bias
fig = plt.figure()
ax = plt.axes(projection='3d')
surf = ax.plot_surface(Ws,Bs,np.array(mse_list).reshape(Ws.shape),cmap=plt.get_cmap('rainbow'),alpha=0.6)

# Scatter the ponit corresponding minimum MSE
min_idx = mse_list.index(min(mse_list))
ax.scatter(Ws.flatten()[min_idx],Bs.flatten()[min_idx],mse_list[min_idx],s=700,
            c='red',marker='*')

# Axes settings
ax.set_xlabel('weight')
ax.set_ylabel('bias')
ax.set_zlabel('MSE error')
ax.set_title('The change of MSE as a function of weights and bias') 
fig.colorbar(surf, orientation='vertical')
plt.show()
```

![image-20230403201354803](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230403201354803.png?raw=true)

<br>

**References**

[1] [2. 线性模型 - 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=2&vd_source=8aeddead7f39b0189fff9b14fa090a75).