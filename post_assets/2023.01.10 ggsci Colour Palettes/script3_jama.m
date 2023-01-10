clc, clear, close all

mypal = ["374E55"; "DF8F44"; "00A1D5";
    "B24745"; "79AF97"; "6A6599";
    "80796B"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar