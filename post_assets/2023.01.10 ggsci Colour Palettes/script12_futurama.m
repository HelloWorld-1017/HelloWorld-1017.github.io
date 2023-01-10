clc, clear, close all

mypal = ["FF6F00"; "C71000"; "008EA0"; "8A4198";
    "5A9599"; "FF6348"; "84D7E1"; "FF95A8"; "3D3B25";
    "ADE2D0"; "1A5354"; "3F4041"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal