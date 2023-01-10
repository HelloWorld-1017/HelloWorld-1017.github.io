clc, clear, close all

mypal = ["4500AC"; "2600D1"; "6B58EE"; "8787FF";
    "C6C0FF"; "D4D4FF"; "FFBFE5"; "FF8888"; "FF707F";
    "FF5959"; "EE3F3F"; "D60C00"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal