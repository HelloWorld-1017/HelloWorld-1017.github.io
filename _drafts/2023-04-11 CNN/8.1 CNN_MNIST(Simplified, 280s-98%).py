# -*- coding: utf-8 -*-
"""
Created on Fri Dec 17 10:53:19 2021

@author: whatastarrynight
"""
# 50次训练，280s，准确率98%，GPU占用率40以下


import torch
from torchvision import transforms# transforms：对图像进行处理的工具包
from torchvision import datasets
from torch.utils.data import DataLoader
import torch.nn.functional as F # 后续使用ReLU激活函数
import torch.optim as optim
import matplotlib.pyplot as plt
import datetime

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


# width, height = 28, 28 # 图像大小

class Net(torch.nn.Module):
    def __init__(self):  # 在initial中定义“权重计算”
        super(Net, self).__init__()
        # 创建卷积层
        self.conv1 = torch.nn.Conv2d(1, 10, kernel_size = 5)
        self.conv2 = torch.nn.Conv2d(10, 20, kernel_size = 5)
        # 创建池化层
        self.pooling = torch.nn.MaxPool2d(kernel_size = 2)
        # 创建全连接层(只有1层)
        self.fc = torch.nn.Linear(320, 10)
        
        
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
    return 100 * correct / total
    
    
if __name__ == '__main__':
    starttime = datetime.datetime.now()
    
    accuracies = []
    epoches = []
    for epoch in range(50):
        train(epoch)
        accuracy = test()
        accuracies.append(accuracy)
        epoches.append(epoch)


    # 画准确率图像
    plt.cla() # 清除之前的图像
    plt.plot(epoches, accuracies,
             color = '#0072BD', marker = 'o',label = '准确率',
             linewidth = 1,
             markersize = 3)
    plt.ylabel('分类准确度(%)', fontsize = 12)
    plt.xlabel('训练次数(次数)', fontsize = 12)
    plt.plot([0, 110],[accuracies[-1], accuracies[-1]], 
             linestyle = '--',
             color = '#D95319', )
    plt.axis([0, 110, 0, 110]) # x、y坐标轴范围
    # plt.xticks(fontsize = 20) # 设置x轴坐标大小
    # plt.yticks(fontsize = 20) # 设置y轴坐标大小
    plt.text( 10, accuracies[-1]+5, '准确率收敛至：%.0f'% accuracies[-1] + '%', fontsize = 12)
    plt.legend() # 显示图例
    
    # 保存图片到根目录，设置输出图片大小
    fig = plt.gcf()
    fig.set_size_inches(5, 5)
    fig.savefig('fig4.svg')
 
    plt.show()
    
    plt.rcParams['font.sans-serif'] = ['SimHei']
    plt.rcParams['axes.unicode_minus'] = False
    
    endtime = datetime.datetime.now()
    time_span = endtime - starttime
    print((endtime - starttime).seconds)


