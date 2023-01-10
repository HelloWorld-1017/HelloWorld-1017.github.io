clc, clear, close all

mypal = ["1F77B4"; "FF7F0E"; "2CA02C"; "D62728";
    "9467BD"; "8C564B"; "E377C2"; "7F7F7F";
    "BCBD22"; "17BECF"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal
