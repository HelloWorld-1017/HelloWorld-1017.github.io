function [pLRList,numLRprimes] = helperSegmentedSieve2(L,R)
pList = primes(sqrt(R));
pList(pList==2) = [];

if rem(L,2) % L is odd
    isp = true(1,ceil((R-L+1)/2));
    for pj = pList
        if rem(ceil(L/pj),2) % ceil(L/pj) is odd
            minIdx = (ceil(L/pj)*pj-L+1+1)/2;
        else                 % ceil(L/pj) is even
            minIdx = ((ceil(L/pj)+1)*pj-L+1+1)/2;
        end
        maxIdx = (floor(R/pj)*pj-L+1+1)/2;
        idx = minIdx:pj:maxIdx;
        isp(idx) = false;
    end
    pLRList = find(isp)*2-1+L-1;
else % L is even
    isp = true(1,floor((R-L+1)/2));
    for pj = pList
        if rem(ceil(L/pj),2) % ceil(L/pj) is odd
            minIdx = (ceil(L/pj)*pj-L+1)/2;
        else                 % ceil(L/pj) is even
            minIdx = ((ceil(L/pj)+1)*pj-L+1)/2;
        end
        maxIdx = (floor(R/pj)*pj-L+1)/2;
        idx = minIdx:pj:maxIdx;
        isp(idx) = false;
    end
    pLRList = find(isp)*2+L-1;
end
pLRList = [pList(pList>=L), pLRList];
pLRList(pLRList==1) = [];
if L == 2 || L == 1
    pLRList = [2, pLRList];
end
numLRprimes = numel(pLRList);
end