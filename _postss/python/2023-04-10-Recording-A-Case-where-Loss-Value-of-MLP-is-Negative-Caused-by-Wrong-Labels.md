---
layout: single
title: Record A Case where Loss Value of MLP is Negative Caused by Wrong Labels
categories: 
 - Machine Learning
 - Python
tags:
 - Python PyTorch
toc: false
date: 2023-04-10 20:19:38 +0800
last_modified_at0: 2023-04-10 20:19:38 +0800
last_modified_at1: 2024-05-22 21:04:42 +0800
last_modified_at: 2024-05-22 21:04:42 +0800
---

前天在学习二分类交叉熵损失函数时总结了[^1]：对于二分类问题，由于输出层后面Sigmoid函数的存在，交叉熵损失函数不可能是负数.但是，今天在应用MLP解决糖尿病数据集的分类问题时[^2]，由于在处理数据标签时的一个失误，在训练迭代过程中出现了损失函数为负数的情况。觉得这个点还是挺有意思的，因此记录一下。

```python
import numpy as np
import torch
from torch.utils.data import Dataset
from torch.utils.data import DataLoader
import matplotlib.pyplot as plt

class DiabetesDataset(Dataset):
    def __init__(self, filepath1, filepath2):
        x = np.loadtxt(filepath1, delimiter = ' ', dtype = np.float32)
        y = np.loadtxt(filepath2, delimiter = ' ', dtype = np.float32)
        print('Minimum y', min(y)) # Minimum y 25.0
        print('Maximum y', max(y)) # Maximum y 346.0
        
        y[y < 175] = 0
        y[y > 175] = 1
        
        y = np.array([y]).reshape((y.size, 1))
        xy = np.hstack((x, y))

        self.len = xy.shape[0]
        self.x_data = torch.from_numpy(xy[:, :-1])
        self.y_data = torch.from_numpy(xy[:, [-1]])

    def __getitem__(self, index):
        return self.x_data[index], self.y_data[index] # Return a tuple

    def __len__(self):
        return self.len

dataset = DiabetesDataset('diabetes_data.csv.gz', 
                          'diabetes_target.csv.gz')

train_loader = DataLoader(dataset = dataset,
                          batch_size = 32, 
                          shuffle = True)
                          # num_workers=2)

class Model(torch.nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.linear1 = torch.nn.Linear(10, 6)
        self.linear2 = torch.nn.Linear(6, 4)
        self.linear3 = torch.nn.Linear(4, 1)
        self.activate = torch.nn.ReLU()
        self.sigmoid = torch.nn.Sigmoid()
        
    def forward(self, x):
        x = self.activate(self.linear1(x))
        x = self.activate(self.linear2(x))
        x = self.sigmoid(self.linear3(x))
        return x

model = Model()

criterion = torch.nn.BCELoss(size_average = True)
optimizer = torch.optim.SGD(model.parameters(), lr = 0.1)

# if __name__ == '__main__':
loss_list = []
for epoch in range(100):
    for i, data in enumerate(train_loader, 0):# 嵌套循环：使用mini-batch
    # 使用enumerate是为了获得当前是第几次epoch, i表示第i个Mini-Batch
    # train_loader拿出来的索引元组就放在data中；
        # 1) Prepare data
        inputs, lables = data 
        # inputs和lable是分别是X（特征值）和Y（标签）的矩阵，之后PyTorch自动地将它们转化为Tensor
        # 2) Forward
        y_pred = model(inputs)
        loss = criterion(y_pred, lables)
        # print(epoch, i, loss.item())
        loss_list.append(loss.item())
        # 3) Backward
        optimizer.zero_grad()
        loss.backward()
        # 4) update
        optimizer.step()
        
ax = plt.subplot()
plt.plot(np.linspace(1,len(loss_list),len(loss_list)), loss_list)
plt.grid()
ax.set_xlabel('Iteration')
ax.set_ylabel('Loss value')
```

上述代码使用一个MLP模型解决了一个糖尿病数据集对应的分类问题。可以看到，由于scikit-learn库自带的糖尿病数据集的标签是代表程度的实数（最小值为25，最大值为346），因此我们对标签做了一个简单的处理，选取175作为一个阈值，小于175表示没有糖尿病（类0），大于175表示患者有糖尿病（类1）：

```python
        y[y < 175] = 0
        y[y > 175] = 1
```

但是，在MLP的训练过程中，出现了二分类交叉熵损失值小于0的情况，而且出现得很频繁：

![image-20230410195959578](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230410195959578.png?raw=true)

其实问题就出现在对于数据集标签的处理上。代码：

```python
        y[y < 175] = 0
        y[y > 175] = 1
```

并没有对取值为175的标签进行处理，导致在二分类交叉熵时出现了负数：

$$
Loss=...+(1-175)\log(\mathrm{XX})\notag
$$

并且每次遇到这个没有处理的、标签为175的样本，损失值就会骤变为负数，使得训练过程无法继续下去。

因此，只需要将代码更改为：

```python
        y[y < 175] = 0
        y[y >= 175] = 1
```

即可纠正这一错误：

![image-20230410201500966](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230410201500966.png?raw=true)

这个问题也侧面反映出，用于计算二分类交叉熵的损失函数`torch.nn.BCELoss(size_average = True)`仅仅负责计算，而不会检查输入的标签是否仅有两个分类。

<br>

# References

[^1]: [Entropy, Cross entropy, KL Divergence and Their Relation - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-04-09/14-25-33.html).
[^2]: [Construct A Simple MLP for Diabetes Dataset Binary Classification Problem with PyTorch (Load Datasets using PyTorch DataSet and DataLoader) - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-04-10/13-44-03.html).