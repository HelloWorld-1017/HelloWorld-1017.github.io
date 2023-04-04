import numpy as np
import matplotlib.pyplot as plt

# Training data
x_data = [1.0, 2.0, 3.0]
y_data = [2.0, 4.0, 6.0]

# Initial weight
w = 1.0 

w_list = []
cost_list = []
epoch_list = []

def forward(x):
    return x * w

def cost(x, y):
    cost = (forward(x) - y) ** 2
    return cost

def gradient(x, y):
    grad = 2 * x * (x * w - y)
    return grad

print('Predict (befor training):', 4, forward(4))
for epoch in range(100): # 100-times epochs training
    for x, y in zip(x_data,y_data):
        cost_val = cost(x, y) # Calculate loss (just for display)
        grad_val = gradient(x, y) # Caculate gradient
        w -= 0.01 * grad_val  # Update weights
    w_list.append(w)
    cost_list.append(cost_val)
    epoch_list.append(epoch)
    print('Epoch:', epoch, 'w=', w, 'loss = ', cost_val)
    
# Make a prediction
print('Predict (after training)', 4, forward(4))

ax1 = plt.subplot(121)
plt.plot(w_list, cost_list)
plt.grid ()
ax1.set_xlabel('Weight')
ax1.set_ylabel('Loss value')

ax2 = plt.subplot(122)
plt.plot(epoch_list, cost_list)
plt.grid ()
ax2.set_xlabel('Epoch')
ax2.set_ylabel('Loss value')
plt.show()