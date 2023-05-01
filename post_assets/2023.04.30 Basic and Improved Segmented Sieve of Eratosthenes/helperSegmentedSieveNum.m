function numLRprimes = helperSegmentedSieveNum(L,R,pList)
pList = pList(pList<=sqrt(R));

isp = true(1,R-L+1);

for pj = pList
    minIdx = ceil(L/pj)*pj;
    maxIdx = floor(R/pj)*pj;
    idx = (minIdx:pj:maxIdx)-L+1;
    isp(idx) = false;
end
numLRprimes = sum(isp);
end