clc, clear, close all

mypal = ["0073C2"; "EFC000"; "868686";
    "CD534C"; "7AA6DC"; "003C67";
    "8F7700"; "3B3B3B"; "A73030"; "4A6990"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal
