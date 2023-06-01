clc,clear,close all

syms eta Q

HC = sqrt(Q^4*(eta^2-1)^2+eta^2*Q^2)/(eta^2+Q^2*(eta^2-1)^2);
diffHC = diff(HC,eta);
etas = solve(diffHC==0,eta);
disp(etas)
ExtreVals = simplify(subs(HC,eta,etas));
disp(ExtreVals)

solve(ExtreVals(3)-Q==0,Q)
