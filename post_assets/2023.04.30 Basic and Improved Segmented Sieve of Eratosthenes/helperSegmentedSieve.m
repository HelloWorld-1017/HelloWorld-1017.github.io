function [pLRList,numLRprimes] = helperSegmentedSieve(L,R)
pList = primes(sqrt(R));

isp = true(1,R-L+1);

for pj = pList
    minIdx = ceil(L/pj)*pj;
    maxIdx = floor(R/pj)*pj;
    idx = (minIdx:pj:maxIdx)-L+1;
    isp(idx) = false;
end

pLRList = find(isp)+L-1;
pLRList = [pList(pList>=L), pLRList];
pLRList(pLRList==1) = [];
numLRprimes = numel(pLRList);
end