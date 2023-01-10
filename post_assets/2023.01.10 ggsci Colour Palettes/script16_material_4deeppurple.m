clc, clear, close all

mypal = ["ECE6F6"; "D1C4E9"; "B29DDA"; "9474CC"; "7E57C1";
    "6639B7"; "5E34B1"; "512CA7"; "45269F"; "311A92"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal