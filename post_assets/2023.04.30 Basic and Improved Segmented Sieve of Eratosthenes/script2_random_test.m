clc,clear,close all

tic
results = nan(1e5,2);
for i = 1:height(results)
    [diffPrimes,diffSums] = helperTest;
    results(i,1) = diffPrimes;
    results(i,2) = diffSums;
end
toc

function [diffPrimes,diffSums] = helperTest
L = ceil(rand*1e6);
R = L+ceil(rand*1e5);

[pLRList_self,num_self] = helperSegmentedSieve(L,R);
pLRList_builtin = primes(R);
pLRList_builtin(pLRList_builtin<L | pLRList_builtin>R) = [];
diffPrimes = sum(pLRList_self - pLRList_builtin);
diffSums = num_self - numel(pLRList_builtin);
end

