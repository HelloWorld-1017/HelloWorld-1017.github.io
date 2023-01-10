clc, clear, close all

mypal = ["FFFDE6"; "FFF8C4"; "FFF49D"; "FFF176"; "FFED58";
    "FFEB3A"; "FDD834"; "FABF2C"; "F8A725"; "F47F17"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal