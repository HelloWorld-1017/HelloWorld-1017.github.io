# -*- coding: utf-8 -*-
"""
Created on Mon Dec 13 20:54:05 2021

@author: whatastarrynight
"""
import torch
from torchvision import transforms# transforms：对图像进行处理的工具包
from torchvision import datasets
from torch.utils.data import DataLoader
import torch.nn.functional as F # 后续使用ReLU激活函数
import torch.optim as optim
import numpy as np

# 准备数据
batch_size = 64
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.1370, ),(0.3081, ))
])

train_dataset = datasets.MNIST(root = '../dataset/mnist/',
                               train = True,
                               download = True,
                               transform = transform)

train_loader = DataLoader(train_dataset,
                          shuffle = True,
                          batch_size = batch_size)

test_dataset = datasets.MNIST(root = '../dataset/mnist/',
                               train = False,
                               download = True,
                               transform = transform)

test_loader = DataLoader(test_dataset,
                          shuffle = False,
                          batch_size = batch_size)




width, height = 28, 28 # 图像大小

class Net(torch.nn.Module):
    def __init__(self):  # 在initial中定义“权重计算”
        super(Net, self).__init__()
        
        # in_channels, out_channels = 1, 10 
        # （1）in_channels = 5
        # 每个通道都要配一个卷积核，卷积核的数量和输入通道的数量是一样的
        # （2）out_channels = 10
        # “卷积核立方体”(c*w*h)的数量是和输出通道一致
        
        # 创建卷积层
        # 初始化卷积层时有很多选项可以设置，但是必须设置的4个参数，就是决定卷积核形状的4个数
        # 输入通道，输出通道，卷积核的尺寸（5*5）
        # 当然也可以设置为矩形的卷积核kernel_size = (5, 3)
        # 卷积层只对“通道数”有要求，必须和输入通道保持一致！！！对batch和图片大小都没有要求
        # 另外可以设置padding & stride，改变输出的大小
        self.conv1 = torch.nn.Conv2d(1, 10, kernel_size = 5)
        self.conv2 = torch.nn.Conv2d(10, 20, kernel_size = 5)
        self.pooling = torch.nn.MaxPool2d(kernel_size = 2)
        self.fc = torch.nn.Linear(320, 10) # 相当于全连接层只有一层
        
        
    def forward(self, x):  # 在前馈中定义“激活函数”，从而形成整个计算图（模型）
        batch_size = x.size(0)
        x = F.relu(self.pooling(self.conv1(x)))
        x = F.relu(self.pooling(self.conv2(x)))
        x = x.view(batch_size, -1)
        x = self.fc(x)
        
        return x

model = Net()

criterion = torch.nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr = 0.01, momentum = 0.5)

# 设置使用cpu加速
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
model.to(device)

def train(epoch):
    running_loss = 0.0
    for batch_idx, data in enumerate(train_loader, 0):
        # enumerate函数：用于可迭代/可遍历的的数据对象组合为一个索引序列，同时列出数据和数据下标
        inputs, target = data
        inputs, target = inputs.to(device), target.to(device) # 把数据送到和模型一致的GPU中
        optimizer.zero_grad()
        
        outputs = model(inputs)
        loss = criterion(outputs, target)
        loss.backward()
        optimizer.step()
        
        running_loss += loss.item()
        if batch_idx % 300 == 299:
            print('[%d, %5d] loss:%3.f' % (epoch + 1, batch_idx + 1, running_loss / 300))
            running_loss = 0.0

def test():
    correct = 0
    total = 0
    with torch.no_grad(): # 下面的过程不再计算梯度
        for data in test_loader:
            images, labels = data 
            images, labels = images.to(device), labels.to(device) 
            outputs = model(images)
            
            _, predicted = torch.max(outputs.data, dim = 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    print('Accuracy on test set: %d %%' % (100 * correct / total))
    
if __name__ == '__main__':
    for epoch in range(100):
        train(epoch)
        test()
        


