clc, clear, close all

mypal = ["00468B"; "ED0000"; "42B540";
    "0099B4"; "925E9F"; "FDAF91";
    "AD002A"; "ADB6B6"; "1B1919"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar
