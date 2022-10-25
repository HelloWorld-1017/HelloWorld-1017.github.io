clc, clear, close all

A = [2, 5;
    3, 3;
    4, 2;
    7, 4;
    9, 6];

mus = mean(A);
num = height(A);

var_builtin = var(A);
var_custom = [mean((A(:, 1)-mus(1)).*(A(:, 1)-mus(1)))*num/(num-1), ...
    mean((A(:, 2)-mus(2)).*(A(:, 2)-mus(2)))*num/(num-1)
    ];


std_builtin = std(A);
std_custom = [sqrt(mean((A(:, 1)-mus(1)).*(A(:, 1)-mus(1))*num)/(num-1)), ...
    sqrt(mean((A(:, 2)-mus(2)).*(A(:, 2)-mus(2))*num)/(num-1))
    ];


var_builtin, var_custom, std_builtin, std_custom