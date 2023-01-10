clc, clear, close all

mypal = ["FFF8E0"; "FFEBB2"; "FFDF81"; "FFD44E"; "FFCA27";
    "FFC006"; "FFB200"; "FF9F00"; "FF8E00"; "FF6E00"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal