clc, clear, close all

a = [2, 3, 4, 7, 9];
var_builtin = var(a, 1);
var_custom = mean((a-mean(a)) .* (a-mean(a)));

std_builtin = std(a, 1);
std_custom = sqrt(mean((a-mean(a)) .* (a-mean(a))));

