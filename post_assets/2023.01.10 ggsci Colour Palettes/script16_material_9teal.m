clc, clear, close all

mypal = ["DFF2F1"; "B2DFDA"; "7FCBC4"; "4CB6AC"; "26A599";
    "009687"; "00887A"; "00796B"; "00685B"; "004C3F"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal