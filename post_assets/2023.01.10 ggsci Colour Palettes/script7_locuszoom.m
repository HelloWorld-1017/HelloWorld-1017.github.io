clc, clear, close all

mypal = ["D43F3A"; "EEA236"; "5CB85C";
    "46B8DA"; "357EBD"; "9632B8"; "B8B8B8"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal
