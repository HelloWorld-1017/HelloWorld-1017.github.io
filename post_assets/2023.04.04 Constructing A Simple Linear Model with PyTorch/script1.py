import torch

x_data = torch.Tensor([[1.0], [2.0], [3.0]])
y_data = torch.Tensor([[2.0], [4.0], [6.0]])

class LinearModel(torch.nn.Module):
    def __init__(self):
        super(LinearModel, self).__init__()
        self.linear = torch.nn.Linear(1, 1)
        
    def forward(self, x):
        y_pred = self.linear(x) 
        return y_pred
    
# instantiate LinearModel Class
model = LinearModel() 

criterion = torch.nn.MSELoss(size_average = False) 
optimizer = torch.optim.SGD(model.parameters(), lr = 0.01)

for epoch in range(500):
    # Forward
    y_pred = model(x_data)
    
    # print(epoch,'\t', model.linear.weight.item(),
    #       '\t', model.linear.bias.item(),
    #       '\t',  loss.item())
    
    loss = criterion(y_pred, y_data)
    
    # Backward: autograd
    loss.backward()
    
    # Update
    optimizer.step() 
    
    # Reset gradients
    optimizer.zero_grad()
    
    
print('w = ', model.linear.weight.item())
print('b = ', model.linear.bias.item())

x_test = torch.Tensor([[4.0]])
y_test = model(x_test)
print('y_pred = ', y_test.data)
    