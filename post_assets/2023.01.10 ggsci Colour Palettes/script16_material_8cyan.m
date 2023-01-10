clc, clear, close all

mypal = ["DFF7F9"; "B2EBF2"; "7FDEEA"; "4CD0E0"; "26C5D9";
    "00BBD3"; "00ACC0"; "0097A6"; "00838E"; "005F64"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal