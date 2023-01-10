clc, clear, close all

mypal = ["800000"; "D6D6CE"; "FFB547"; "ADB17D";
    "5B8FA8"; "D49464"; "B1746F"; "8A8B79"; "725663"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal