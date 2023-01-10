clc, clear, close all

mypal = ["F2E5F4"; "E0BEE6"; "CD92D8"; "B967C7";
    "AB46BB"; "9B26B0"; "8D24AA";
    "7A1FA1"; "6A1A99"; "4A138C"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal