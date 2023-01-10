clc, clear, close all

mypal = ["E7F4E9"; "C7E5C9"; "A5D6A6"; "80C684"; "66BA6A";
    "4CAE50"; "439F46"; "388D3B"; "2D7D32"; "1A5E1F"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal