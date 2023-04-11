# -*- coding: utf-8 -*-
"""
Created on Tue Dec 14 18:33:11 2021

@author: whatastarrynight
"""

import numpy as np
import torch
import torch.nn.functional as F

# 构造随机输入，1个就够了
x = np.random.randint(0,1,(2,1,28,28)) # 0~1之间；矩阵大小
x = torch.Tensor(x)


class Model(torch.nn.Module):
    def __init__(self):  # 在initial中定义“权重计算”
        super(Model, self).__init__()
        # 创建卷积层
        self.conv1 = torch.nn.Conv2d(1, 10, kernel_size = 5)
        self.conv2 = torch.nn.Conv2d(10, 20, kernel_size = 5)
        # 创建池化层
        self.pooling = torch.nn.MaxPool2d(kernel_size = 2)
        # 测试输出向量大小的时候不设置全连接层
        # self.fc = torch.nn.Linear(320, 10)
        
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.pooling(self.conv1(x)))
        x = F.relu(self.pooling(self.conv2(x)))
        x = x.view(batch_size, -1) # 把这行注释掉就能得到通过CNN后没有拉成向量的图片的大小
        
        return x

model = Model()
y = model(x)
print(y.size())

    



