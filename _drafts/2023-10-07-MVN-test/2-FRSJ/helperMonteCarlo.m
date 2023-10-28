function [logic,Pvalue] = helperMonteCarlo(SMV,SCM,numG,T0,W,alpha)
Tprimes = nan(W-2,1);
for i = 1:W
    Xstar = mvnrnd(SMV,SCM,numG);
    Ystar = mvnrnd(mean(Xstar),cov(Xstar),numG);
    Tprimes(i) = helperCalculateTprime(Xstar,Ystar);
%     disp(i)
end
Tprimes = sort(Tprimes,"ascend");

idx = Tprimes>=T0;
idx = find(idx==1);
R = idx(1);

logic = R <= alpha*W;

Pvalue = R/W;
if logic == 1
    fprintf("Reject, p-value: %.4f\n",Pvalue);
elseif logic == 0
    fprintf("Accept! p-value: %.4f\n",Pvalue);
end
end