clc, clear, close all

mypal = ["F9F9F9"; "F4F4F4"; "EDEDED"; "DFDFDF"; "BDBDBD";
    "9E9E9E"; "747474"; "606060"; "414141"; "202020"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal