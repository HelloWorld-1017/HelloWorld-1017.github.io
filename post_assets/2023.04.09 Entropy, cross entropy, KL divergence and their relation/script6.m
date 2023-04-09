clc,clear,close all

Loss_M = helperCalcualteLoss([0,1,1,0],[0.1,0.2,0.3,0.9]);
Loss_N = helperCalcualteLoss([0,1,1,0],[0.4,0.2,0.3,0.9]);
Loss_G = helperCalcualteLoss([0,1,1,0],[0.1,0.8,0.9,0.1]);

disp(Loss_M)
disp(Loss_N)
disp(Loss_G)

function Loss = helperCalcualteLoss(r,phat0)
pv0 = 1-r;
Loss = -mean(pv0.*log(phat0)+(1-pv0).*log(1-phat0));
end