clc, clear, close all

mypal = ["FFEBED"; "FFCCD2"; "EE9999"; "E57272"; "EE5250";
    "F34335"; "E53934"; "D22E2E"; "C52727"; "B71B1B"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal