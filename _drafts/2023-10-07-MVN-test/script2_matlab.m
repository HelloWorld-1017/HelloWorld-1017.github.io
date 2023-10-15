clc,clear,close all

load fisheriris;
prednames = {'SepalLength','SepalWidth','PetalLength','PetalWidth'};

% Train a linear discriminant analysis model.
L = fitcdiscr(meas,species,'PredictorNames',prednames);

[N,D] = size(meas);

meanL = mean(mahal(L,L.X,'ClassLabels',L.Y).^2);
[~,pvalL] = ztest(meanL,D*(D+2),sqrt(8*D*(D+2)/N))