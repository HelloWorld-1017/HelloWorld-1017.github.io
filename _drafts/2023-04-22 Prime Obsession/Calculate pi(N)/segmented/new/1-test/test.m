clc,clear,close all

tic
LowerLimit = 1e8;
UpperLimit = 1e9;
interval = 1e8;

plist = primes(LowerLimit);
num = numel(plist);

for i = 1:(UpperLimit/interval)-1
    numLRprimes = helperSegmentedSieve2Num(LowerLimit+(i-1)*interval,LowerLimit+i*interval,plist);
    num = num+numLRprimes;
end
toc