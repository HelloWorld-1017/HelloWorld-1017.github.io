clc, clear, close all

X = round(rand(100000, 4)*9);
Y = round(mean(X, 2));
% tabulate(Y)
[CategoriVariables, Class] = findgroups(Y);

splitapply(X, CategoriVariables)

% 
% function helperFcn(X, c)
% idx = c==
% end
