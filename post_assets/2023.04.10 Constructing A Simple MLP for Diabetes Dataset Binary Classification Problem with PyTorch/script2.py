import torch
import numpy as np
import matplotlib.pyplot as plt

x = np.loadtxt('C:\ProgramData\Anaconda3\Lib\site-packages\sklearn\datasets\data\diabetes_data.csv.gz', delimiter = ' ', dtype = np.float32)
y = np.loadtxt('C:\ProgramData\Anaconda3\Lib\site-packages\sklearn\datasets\data\diabetes_target.csv.gz', delimiter = ' ', dtype = np.float32)
# 注意：y不是一个0~1之间的数，而是一个实数，所以直接用这个y不是分类问题，而是回归问题
y[y < 175] = 0
y[y >= 175] = 1
x_data = torch.from_numpy(x)
y_data = torch.from_numpy(y).view(y.size, 1) # y_需要是个矩阵

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


for epoch in range(1000):
    
    y_pred = model(x_data) # 一个Batch直接进行训练，而没有采用mini-batch
    loss = criterion(y_pred, y_data)
    print(epoch, loss.item())
    
    optimizer.zero_grad()
    loss.backward()
    
    optimizer.step()
    