clc, clear, close all

mypal = ["FFF2DF"; "FFDFB2"; "FFCC7F"; "FFB74C"; "FFA626";
    "FF9800"; "FA8C00"; "F47B00"; "EE6C00"; "E55100";];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal