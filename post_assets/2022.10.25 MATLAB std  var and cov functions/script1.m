clc, clear, close all

a = [2, 3, 4, 7, 9];
mu = mean(a);

var_builtin = var(a, 1);
var_custom = mean((a-mu) .* (a-mu));

std_builtin = std(a, 1);
std_custom = sqrt(mean((a-mu) .* (a-mu)));

% var_builtin, var_custom, std_builtin, std_custom