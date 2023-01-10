clc, clear, close all

mypal = ["E3F2FD"; "BADEFA"; "90CAF8"; "64B4F6"; "41A5F4";
    "2096F2"; "1E87E5"; "1976D2"; "1465BF"; "0C46A0"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal