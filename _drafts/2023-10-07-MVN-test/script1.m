clc,clear,close all

rng(1)

for i = 1:3
    helperRandn
end

function helperRandn
    disp(randn(1,3))
end