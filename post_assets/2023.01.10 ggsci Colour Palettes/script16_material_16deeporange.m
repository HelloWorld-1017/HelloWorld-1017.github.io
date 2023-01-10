clc, clear, close all

mypal = ["FAE9E6"; "FFCCBB"; "FFAB91"; "FF8A65"; "FF7043";
    "FF5721"; "F3511E"; "E54A19"; "D84314"; "BF350C"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal