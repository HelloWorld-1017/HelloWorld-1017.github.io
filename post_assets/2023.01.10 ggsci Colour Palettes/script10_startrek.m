clc, clear, close all

mypal = ["CC0C00"; "5C88DA"; "84BD00"; "FFCD00";
    "7C878E"; "00B5E2"; "00AF66"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal