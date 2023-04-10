import torch 
from torch.utils.data import DataLoader
from torchvision import transforms
from torchvision import datasets

train_dataset = datasets.MNIST(root='mnist',
                               train=True,
                               transform=transforms.ToTensor(), # Convert PIL Image (Python Image Library Image) to Tensor
                               download=True)

test_dataset = datasets.MNIST(root='mnist',
                              train=False,
                              transform=transforms.ToTensor(),
                              download=True)

train_loader = DataLoader(dataset=train_dataset,
                          batch_size=32,
                          shuffle=True)
test_loader = DataLoader(dataset=test_dataset,
                         batch_size=32,
                         shuffle=False)# Attention here
