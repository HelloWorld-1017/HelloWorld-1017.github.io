clear,close all

tic
LowerLimit = 1e9;
UpperLimit = 1e12;
interval = 1e9;

plist = primes(LowerLimit)';
num = numel(plist);

for i = 1:(UpperLimit/interval)-1
    numLRprimes = ...
        helperSegmentedSieve2Num(LowerLimit+(i-1)*interval,LowerLimit+i*interval,plist);
    num = num+numLRprimes;
    disp(i)
end
toc