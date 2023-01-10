clc, clear, close all

mypal = ["800000"; "767676"; "FFA319"; "8A9045"; "155F83";
    "C16622"; "8F3931"; "58593F"; "350E20"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal