clc, clear, close all

mypal = ["E0F4FE"; "B2E5FC"; "80D3F9"; "4EC3F7"; "28B6F6";
    "02A9F3"; "029AE5"; "0187D1"; "0177BD"; "00579A"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal