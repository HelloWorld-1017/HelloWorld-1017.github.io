import numpy as np
import matplotlib.pyplot as plt 
import torch

x_s = [1.0, 2.0, 3.0]
y_s = [2.0, 4.0, 6.0]

w = torch.Tensor([1.0])
w.requires_grad = True   

def forward(x):
    return x * w  

def loss(x, y):
    y_pred = forward(x)
    return (y_pred - y) ** 2

print("predict (before training)", 4, forward(4).item())

for epoch in range(100):      
    for x, y in zip(x_s, y_s):
        l = loss(x, y)
        l.backward() # Calculate gradients (where needed) in the calculation diagram
        print('\t grad', x, y, w.grad.item())
        w.data = w.data - 0.01 * w.grad.data
        
        w.grad.data.zero_()
        
    print("progress", epoch, l.item())
print("predict (after training)", 4, forward(4).item())

