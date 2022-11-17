clc, clear, close all

fun = @(x) (x-1)*(x-2)*(x-3)*(x-4)*(x-5)*(x-6)-10^(-6)*x^(7);
f_zero = fzero(fun, 10);
