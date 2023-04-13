import torch

input = [3,4,6,
         2,4,6,
         1,6,7]

input = torch.Tensor(input).view(1,1,3,3)

maxpooling_layer = torch.nn.MaxPool2d(kernel_size=2,stride=1)

output = maxpooling_layer(input)
print(output)