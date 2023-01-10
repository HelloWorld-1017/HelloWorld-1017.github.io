clc, clear, close all

mypal = ["FCE4EB"; "F8BAD0"; "F38EB1"; "F06192";
    "EB3F79"; "E91E63"; "D81A5F"; "C1185A";
    "AC1357"; "870D4E"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal