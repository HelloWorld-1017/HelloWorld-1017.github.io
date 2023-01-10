clc, clear, close all

mypal = ["3182BD"; "E6550D"; "31A354"; "756BB1";
    "636363"; "6BAED6"; "FD8D3C"; "74C476"; "9E9AC8";
    "969696"; "9ECAE1"; "FDAE6B"; "A1D99B"; "BCBDDC";
    "BDBDBD"; "C6DBEF"; "FDD0A2"; "C7E9C0"; "DADAEB";
    "D9D9D9"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal
