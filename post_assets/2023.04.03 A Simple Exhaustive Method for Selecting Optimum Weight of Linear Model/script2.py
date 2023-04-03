import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Training Set
x_data = [1.0, 2.0, 3.0]
y_data = [2.0, 4.0, 6.0]

def forward(x): # Define model
    return (x * w + b)

def loss(x, y): # Define loss function
    y_pred = forward(x)
    return (y_pred - y) * (y_pred - y)

mse_list = []  # For saving MSE

ws = np.arange(0.0, 4.1, 0.01)
bs = np.arange(-1.0, 1.1, 0.01)

Ws,Bs = np.meshgrid(ws,bs)

for w,b in zip(Ws.flatten(),Bs.flatten()):
    l_sum = 0 # Reset total sum
    for x_val, y_val in zip(x_data, y_data):
        # Calculate loss for each sample
        loss_val = loss(x_val, y_val)
        # Accumulate loss value
        l_sum += loss_val
    print('MSE =', l_sum / 3)
    mse_list.append(l_sum / 3)


# Plot the change of MSE as a function of weights and bias
fig = plt.figure()
ax = plt.axes(projection='3d')
surf = ax.plot_surface(Ws,Bs,np.array(mse_list).reshape(Ws.shape),cmap=plt.get_cmap('rainbow'),alpha=0.6)

# Scatter the ponit corresponding minimum MSE
min_idx = mse_list.index(min(mse_list))
ax.scatter(Ws.flatten()[min_idx],Bs.flatten()[min_idx],mse_list[min_idx],s=700,
            c='red',marker='*')

# Axes settings
ax.set_xlabel('weight')
ax.set_ylabel('bias')
ax.set_zlabel('MSE error')
ax.set_title('The change of MSE as a function of weights and bias') 
fig.colorbar(surf, orientation='vertical')
plt.show()