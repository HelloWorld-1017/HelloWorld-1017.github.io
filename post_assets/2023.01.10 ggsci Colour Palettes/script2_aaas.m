clc, clear, close all

mypal = ["3B4992"; "EE0000"; "008B45";
    "631879"; "008280"; "BB0021";
    "5F559B"; "A20056"; "808180"; "1B1919"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal