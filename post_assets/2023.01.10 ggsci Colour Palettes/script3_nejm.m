clc, clear, close all

mypal = ["BC3C29"; "0072B5"; "E18727";
    "20854E"; "7876B1"; "6F99AD"; "FFDC91"; "EE4C97"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal