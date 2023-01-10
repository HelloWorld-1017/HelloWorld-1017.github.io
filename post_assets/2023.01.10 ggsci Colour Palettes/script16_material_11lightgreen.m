clc, clear, close all

mypal = ["F1F8E9"; "DCECC7"; "C5E0A5"; "ADD480"; "9BCC65";
    "8BC34A"; "7BB241"; "679F38"; "548B2E"; "33681E"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal