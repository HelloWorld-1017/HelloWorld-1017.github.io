clc, clear, close all

mypal = ["EEEBE9"; "D7CCC7"; "BBAAA4"; "A0877F"; "8C6D63";
    "795447"; "6C4C40"; "5D3F37"; "4D332D"; "3E2622";];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal