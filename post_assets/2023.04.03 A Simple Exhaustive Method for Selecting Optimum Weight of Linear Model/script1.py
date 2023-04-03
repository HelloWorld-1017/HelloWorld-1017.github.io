import numpy as np
import matplotlib.pyplot as plt

# Training Set
x_data = [1.0, 2.0, 3.0]
y_data = [2.0, 4.0, 6.0]

def forward(x): # Define model
    return x * w

def loss(x, y): # Define loss function
    y_pred = forward(x)
    return (y_pred - y) * (y_pred - y)

w_list = []    # For saving weights w
mse_list = []  # For saving MSE

for w in np.arange(0.0, 4.1, 0.1): # Exhaustive method for selecting optimum weight
    print('w =', w)
    l_sum = 0 # Reset total sum
    for x_val, y_val in zip(x_data, y_data):
        # Predict value (just for print)
        y_pred_val = forward(x_val)
        # Calculate loss for each sample
        loss_val = loss(x_val, y_val)
        # Print information of each sample
        print('\t', x_val, y_val, y_pred_val, loss_val)
        # Accumulate loss value
        l_sum += loss_val
    print('MSE =', l_sum / 3)
    w_list.append(w)
    mse_list.append(l_sum / 3)

# Plot the change of MSE as a function of weights
plt.plot(w_list, mse_list)

# Scatter the ponit corresponding minimum MSE
min_idx = mse_list.index(min(mse_list))
plt.scatter(w_list[min_idx], mse_list[min_idx],c='red')

# Axes settings
plt.ylabel('Loss')
plt.xlabel('w')
plt.show()
        
