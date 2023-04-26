clc,clear,close all

tic
for i = 1:10
    result_helper = helperIsprime(1:1e7);
end
toc

tic
for i = 1:10
    result_builtin = isprime(1:1e7);
end
toc