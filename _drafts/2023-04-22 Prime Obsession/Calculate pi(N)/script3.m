% clc,clear,close all

load result_builtin.mat
load result_self.mat

result = sum(result_self == result_builtin);
% pos = find(result==0);

% result_self(pos(1)), result_builtin(pos(1))