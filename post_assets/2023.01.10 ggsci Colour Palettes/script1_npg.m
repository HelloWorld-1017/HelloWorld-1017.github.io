clc, clear, close all

mypal = ["E64B35"; "4DBBD5"; "00A087";
    "3C5488"; "F39B7F"; "8491B4";
    "91D1C2"; "DC0000"; "7E6148"; "B09C85"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar