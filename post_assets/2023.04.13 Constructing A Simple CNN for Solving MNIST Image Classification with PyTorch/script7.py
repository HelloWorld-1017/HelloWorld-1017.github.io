import numpy as np
import torch
import torch.nn.functional as F


x = np.random.randint(0,1,(1,1,28,28))
x = torch.Tensor(x)

class Net(torch.nn.Module):
    def __init__(self):  
        super(Net, self).__init__()
        # Define convolution layers
        self.conv1 = torch.nn.Conv2d(1, 10, kernel_size = 5)
        self.conv2 = torch.nn.Conv2d(10, 20, kernel_size = 5)
        # Define max-pooling layer
        self.pooling = torch.nn.MaxPool2d(kernel_size = 2)
        # # Do NOT define fully-connected netwrok first
        # self.fc = torch.nn.Linear(320, 10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.pooling(self.conv1(x)))
        x = F.relu(self.pooling(self.conv2(x)))
        x = x.view(batch_size, -1)
        # x = self.fc(x)
        return x
    
model = Net()
y = model(x)
print(y.size())