import numpy as np
import torch
from torch.utils.data import Dataset
from torch.utils.data import DataLoader
import matplotlib.pyplot as plt

class DiabetesDataset(Dataset):
    def __init__(self, filepath1, filepath2):
        x = np.loadtxt(filepath1, delimiter = ' ', dtype = np.float32)
        y = np.loadtxt(filepath2, delimiter = ' ', dtype = np.float32)
        y[y < 175] = 0
        y[y >= 175] = 1
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
for epoch in range(1000):
    for i, data in enumerate(train_loader, 0):# 嵌套循环：使用mini-batch
    # 使用enumerate是为了获得当前是第几次epoch, i表示第i个Mini-Batch
    # train_loader拿出来的索引元组就放在data中；
        # 1) Prepare data
        inputs, lables = data 
        # inputs和lable是分别是X（特征值）和Y（标签）的矩阵，之后PyTorch自动地将它们转化为Tensor
        # 2) Forward
        y_pred = model(inputs)
        loss = criterion(y_pred, lables)
        print(epoch, i, loss.item())
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