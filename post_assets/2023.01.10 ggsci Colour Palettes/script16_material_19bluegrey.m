clc, clear, close all

mypal = ["EBEEF1"; "CED8DC"; "B0BEC5"; "90A4AD"; "78909B";
    "5F7D8B"; "536D79"; "455964"; "37464E"; "263238"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal