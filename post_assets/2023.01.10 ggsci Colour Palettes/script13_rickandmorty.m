clc, clear, close all

mypal = ["FAFD7C"; "82491E"; "24325F";
    "B7E4F9"; "FB6467"; "526E2D"; "E762D7";
    "E89242"; "FAE48B"; "A6EEE6"; "917C5D"; "69C8EC"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal