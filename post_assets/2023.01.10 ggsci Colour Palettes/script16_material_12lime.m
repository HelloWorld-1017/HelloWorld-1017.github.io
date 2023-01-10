clc, clear, close all

mypal = ["F8FAE6"; "F0F3C3"; "E5ED9B"; "DCE674"; "D3E057";
    "CCDC39"; "BFCA33"; "AEB32B"; "9E9D24"; "817717"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal