clc, clear, close all

mypal = ["E7EAF6"; "C5CAE9"; "9FA7D9"; "7985CB"; "5B6BBF";
    "3F51B4"; "3948AB"; "303F9F"; "273492"; "19227E"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal