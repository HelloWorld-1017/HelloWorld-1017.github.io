clc,clear,close all

rng("default")
A = randn(1,10);
value = 71;
P = prctile(A,value)
Q = quantile(A,value/100)

aa = 1/numel(A)*(1:numel(A))
plot(sort(A),aa)
sort(A),aa
