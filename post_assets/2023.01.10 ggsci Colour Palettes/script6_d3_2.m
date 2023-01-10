clc, clear, close all

mypal = ["1F77B4"; "FF7F0E"; "2CA02C"; "D62728";
    "9467BD"; "8C564B"; "E377C2"; "7F7F7F"; "BCBD22";
    "17BECF"; "AEC7E8"; "FFBB78"; "98DF8A"; "FF9896";
    "C5B0D5"; "C49C94"; "F7B6D2"; "C7C7C7"; "DBDB8D";
    "9EDAE5"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal
