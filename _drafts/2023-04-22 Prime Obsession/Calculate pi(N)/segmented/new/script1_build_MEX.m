clc,clear,close all

L = coder.typeof(1e9,[1,1],1);
R = coder.typeof(1e9,[1,1],1);
plist = primes(1e9)';
plist = coder.typeof(plist,[inf,1],1);

codegen -report helperSegmentedSieve2Num -args {L, R, plist}
