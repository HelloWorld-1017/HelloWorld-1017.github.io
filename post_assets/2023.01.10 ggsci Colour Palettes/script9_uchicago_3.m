clc, clear, close all

mypal = ["800000"; "767676"; "CC8214"; "616530"; "0F425C";
    "9A5324"; "642822"; "3E3E23"; "350E20"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal