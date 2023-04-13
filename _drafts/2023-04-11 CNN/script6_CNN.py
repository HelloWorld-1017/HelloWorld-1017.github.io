import torch
from torchvision import transforms
from torchvision import datasets
from torch.utils.data import DataLoader
import torch.nn.functional as F 
import torch.optim as optim
import matplotlib.pyplot as plt
import datetime

# Prepare MNIST dataset
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


class Net(torch.nn.Module):
    def __init__(self):  
        super(Net, self).__init__()
        # Define convolution layers
        self.conv1 = torch.nn.Conv2d(1, 10, kernel_size = 5)
        self.conv2 = torch.nn.Conv2d(10, 20, kernel_size = 5)
        # Define max-pooling layer
        self.pooling = torch.nn.MaxPool2d(kernel_size = 2)
        # Define fully-connected layer
        self.fc = torch.nn.Linear(320, 10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.pooling(self.conv1(x)))
        x = F.relu(self.pooling(self.conv2(x)))
        x = x.view(batch_size, -1)
        x = self.fc(x)
        return x

model = Net()

criterion = torch.nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr = 0.01, momentum = 0.5)

# Use GPU if available
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
model.to(device)

def train(epoch):
    for batch_idx, data in enumerate(train_loader, 0):
        # Transfer the data and model to GPU or CPU
        inputs, target = data
        inputs, target = inputs.to(device), target.to(device)
        optimizer.zero_grad()
        
        outputs = model(inputs)
        loss = criterion(outputs, target)
        loss.backward()
        optimizer.step()
        
        if batch_idx % 300 == 299:
            print('[%d, %5d] loss:%.4f' % (epoch + 1, batch_idx + 1, loss.item()))

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
    print('Accuracy on test set: %d %%' % (100 * correct / total))
    return 100 * correct / total
    
    
if __name__ == '__main__':
    starttime = datetime.datetime.now()
    
    accuracies = []
    epoches = []
    for epoch in range(10):
        train(epoch)
        accuracy = test()
        accuracies.append(accuracy)
        epoches.append(epoch)

    plt.cla()
    plt.plot(epoches, accuracies,
             color = '#0072BD', marker = 'o',label = 'Test accuracy',
             linewidth = 1,
             markersize = 3)
    plt.ylabel('Test accuracy(%)', fontsize=20)
    plt.xlabel('Epoch', fontsize=20)
    plt.plot([0, 10],[accuracies[-1], accuracies[-1]], 
             linestyle = '--',
             color = '#D95319', )
    plt.axis([0, 10, 0, 110])
    plt.xticks(fontsize=20)
    plt.yticks(fontsize=20)
    plt.text(5, accuracies[-1]-8, 'Converge to: %.0f'% accuracies[-1] + '%', fontsize = 15)
    plt.legend(fontsize=20)
    plt.show()
    
    # # Save figure
    # fig = plt.gcf()
    # fig.set_size_inches(5, 5)
    # fig.savefig('fig.svg')
 
    plt.rcParams['font.sans-serif'] = ['Arial'] # SimHei
    plt.rcParams['axes.unicode_minus'] = False
    
    endtime = datetime.datetime.now()
    time_span = endtime - starttime
    print((endtime - starttime).seconds)