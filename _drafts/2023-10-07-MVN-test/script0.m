clc,clear,close all

load fisheriris;
prednames = {'SepalLength','SepalWidth','PetalLength','PetalWidth'};

% Train a linear discriminant analysis model.
L = fitcdiscr(meas,species,'PredictorNames',prednames);

% Train a quadratic discriminant analysis model
Q = fitcdiscr(meas,species,'PredictorNames',prednames,'DiscrimType','quadratic');

[N,D] = size(meas);
meanKurt = D*(D+2)

varKurt = 8*D*(D+2)/N

mahL = mahal(L,L.X,'ClassLabels',L.Y);
meanL = mean(mahL.^2);
[~,pvalL] = ztest(meanL,meanKurt,sqrt(varKurt))

mahQ = mahal(Q,Q.X,'ClassLabels',Q.Y);
meanQ = mean(mahQ.^2);
[~,pvalQ] = ztest(meanQ,meanKurt,sqrt(varKurt))