clc,clear,close all

tic
for i = 1:10
    a = 1:1e7;
    result = selfIsprime(a);
end
toc

result_builtin = result;
save("result_builtin.mat","result_builtin")

% result_self = result;
% save("result_self.mat","result_self")