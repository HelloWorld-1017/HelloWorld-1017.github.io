import torch

in_channels, out_channels = 5,10
width, height = 100,100
kernel_size = 3
batch_size = 1

input = torch.randn(batch_size, # Batch
                    in_channels,# Channels
                    width,      # Width
                    height)     # Height

conv_layer = torch.nn.Conv2d(in_channels,
                            out_channels,
                            kernel_size=kernel_size)

output = conv_layer(input)

print(input.shape)
print(conv_layer.weight.shape)
print(output.shape)