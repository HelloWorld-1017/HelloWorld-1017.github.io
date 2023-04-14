import torch
from torchvision import transforms
from torchvision import datasets
from torch.utils.data import DataLoader
import torch.nn.functional as F
import torch.optim as optim
import matplotlib.pyplot as plt
import torch.nn as nn
import datetime

# Prepare MNIST dataset: 28x28 pixels
batch_size = 64
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.1370, ),(0.3081, ))
])

train_dataset = datasets.MNIST(root = 'mnist',
                               train = True,
                               download = True,
                               transform = transform)
train_loader = DataLoader(train_dataset,
                          shuffle = True,
                          batch_size = batch_size)
test_dataset = datasets.MNIST(root = 'mnist',
                               train = False,
                               download = True,
                               transform = transform)
test_loader = DataLoader(test_dataset,
                          shuffle = False,
                          batch_size = batch_size)

class InceptionA(nn.Module): 
    def __init__(self, in_channels):
        super(InceptionA, self).__init__()
        
        # The first branch (Pooling branch)：output 24 channels
        self.branch_pool = nn.Conv2d(in_channels,24,kernel_size=1)
        # Output size ：28 + 2*1 - (3-1) - 1 + 1 = 28
        
        # The second branch: output 16 channels
        self.branch1x1 = nn.Conv2d(in_channels,16,kernel_size=1)
        # Output size：28
        
        # The third branch: output 24 channels
        self.branch5x5_1 = nn.Conv2d(in_channels,16,kernel_size=1) # 1x1 convolution
        self.branch5x5_2 = nn.Conv2d(16,24,kernel_size=5,padding=2)# 5x5 convolution
        # Output size：28+2*2-1*(5-1)-1 +1 = 28
        
        # The fourth branch: output 24 channels
        self.branch3x3_1 = nn.Conv2d(in_channels,16,kernel_size=1) # 1x1 convolution
        self.branch3x3_2 = nn.Conv2d(16,24,kernel_size=3,padding=1)# 3x3 convolution
        self.branch3x3_3 = nn.Conv2d(24,24,kernel_size=3,padding=1)# 3x3 convolution
        # Output size：28 + [2*1-(3-1)-1 + 1] + [2*1-(3-1)-1 +1] = 28

    def forward(self, x):
        # The first branch (Pooling branch)
        branch_pool = F.avg_pool2d(x,kernel_size=3,stride=1,padding=1) # 池化层默认stride = kernel_size
        branch_pool = self.branch_pool(branch_pool)
        
        # The second branch
        branch1x1 = self.branch1x1(x)
        
        # The third branch
        branch5x5 = self.branch5x5_1(x)
        branch5x5 = self.branch5x5_2(branch5x5)
        
        # The fourth branch
        branch3x3 = self.branch3x3_1(x)
        branch3x3 = self.branch3x3_2(branch3x3)
        branch3x3 = self.branch3x3_3(branch3x3)

        outputs = [branch1x1,branch5x5,branch3x3,branch_pool]
        return torch.cat(outputs,dim=1) # Concatenate outputs
    
class Net(torch.nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        # Define convolution layer
        self.conv1 = torch.nn.Conv2d(1,10,kernel_size=5)
        self.conv2 = torch.nn.Conv2d(88,20,kernel_size=5)
        
        # Instantiate InceptionA module
        self.incep1 = InceptionA(in_channels=10)
        self.incep2 = InceptionA(in_channels=20)
        
        # Max-pooling layer
        self.mp = torch.nn.MaxPool2d(kernel_size=2)
        
        # Fully-connected layer
        self.fc = torch.nn.Linear(1408, 10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.mp(self.conv1(x))) # Output 10 channels
        x = self.incep1(x)                 # Output 88 channels
        
        x = F.relu(self.mp(self.conv2(x))) # Output 20 channels
        x = self.incep2(x)                 # Output 88 channels 
        x = x.view(batch_size, -1)
        x = self.fc(x)
        
        return x

model = Net()

criterion = torch.nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr = 0.01, momentum = 0.5)

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
model.to(device)

def train(epoch):
    for batch_idx, data in enumerate(train_loader, 0):
        inputs, target = data
        inputs, target = inputs.to(device), target.to(device) 
        optimizer.zero_grad()
        
        outputs = model(inputs)
        loss = criterion(outputs, target)
        loss.backward()
        optimizer.step()
        
        if batch_idx % 300 == 299:
            print('[%d, %5d] loss:%.4f' % (epoch+1,batch_idx+1,loss.item()))

def test():
    correct = 0
    total = 0
    with torch.no_grad():
        for data in test_loader:
            images, labels = data 
            images, labels = images.to(device), labels.to(device) 
            outputs = model(images)
            
            _, predicted = torch.max(outputs.data, dim = 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    print('Accuracy on test set: %.4f %%' % (100 * correct / total))
    return 100 * correct / total
    
if __name__ == '__main__':
    starttime = datetime.datetime.now()

    accuracies = []
    epoches = []
    for epoch in range(5):
        train(epoch)
        accuracy = test()
        accuracies.append(accuracy)
        epoches.append(epoch)

    plt.cla()
    plt.plot(epoches,accuracies,
             color='#0072BD', marker = 'o',label = 'Test accuracy',
             linewidth = 1,
             markersize = 3)
    plt.ylabel('Test accuracy (%)', fontsize = 20)
    plt.xlabel('Epoch', fontsize = 20)
    plt.plot([0, 10],[accuracies[-1], accuracies[-1]], 
             linestyle='--',
             color='#D95319')
    plt.axis([0,50,0,110])
    plt.xticks(fontsize = 20)
    plt.yticks(fontsize = 20)
    plt.text(1,accuracies[-1]+5,
             'Accuracy converge to: %.0f'%accuracies[-1]+'%',fontsize=10)
    plt.legend()
    plt.show()
    
    # # Save figure
    # fig = plt.gcf()
    # fig.set_size_inches(5, 5)
    # fig.savefig('fig11.svg')
 
    plt.rcParams['font.sans-serif'] = ['Times New Roman']
    plt.rcParams['axes.unicode_minus'] = False
    
    endtime = datetime.datetime.now()
    time_span = endtime - starttime
    print((endtime - starttime).seconds)
