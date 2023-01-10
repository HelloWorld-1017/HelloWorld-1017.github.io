clc, clear, close all

mypal = ["FF410D"; "6EE2FF"; "F7C530"; "95CC5E";
    "D0DFE6"; "F79D1E"; "748AA6"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal