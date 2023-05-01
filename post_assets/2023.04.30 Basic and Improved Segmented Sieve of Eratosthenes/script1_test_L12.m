clc,clear,close all

[pLRList,num] = helperSegmentedSieve(2,76);
[pLRList_self,num_self] = helperSegmentedSieve(1,1000);
[pLRList_self2,num_self2] = helperSegmentedSieve(2,1000);