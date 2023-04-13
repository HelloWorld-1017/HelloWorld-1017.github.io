import torch

input = [3,4,
         2,4]
input = torch.Tensor(input).view(1,1,2,2) # BCWH

conv_layer = torch.nn.Conv2d(1, 1, 
                             kernel_size=5,
                             padding='same',
                             bias=False)

kernel = torch.Tensor(range((25))).view(1,1,5,5)
conv_layer.weight.data = kernel.data # Initial kernel weight

output = conv_layer(input)
print(output)