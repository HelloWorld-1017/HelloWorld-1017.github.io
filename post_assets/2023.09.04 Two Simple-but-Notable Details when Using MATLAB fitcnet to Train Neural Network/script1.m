clc,clear,close all

load fisheriris.mat
cv = cvpartition(species,"HoldOut",0.4,"Stratify",true);
species = table2array(cell2table(species));
meas = array2table(meas);
dataTable = addvars(meas,species,'After',"meas4");

trainingDataTable = dataTable(cv.training,:);
testDataTable = dataTable(cv.test,:);

mdl = fitcnet(...
    trainingDataTable,"species", ...
    "LayerSizes",[3,4], ...
    "Activations","relu", ...
    "Standardize",true, ...
    "LossTolerance",1e-6, ...% default value, 1e-6
    "GradientTolerance",1e-6, ...% default value, 1e-6
    "ValidationData",testDataTable, ... 
    "ValidationPatience",Inf... % default value, 6
    );

pred = mdl.predict(testDataTable(:,1:4));
accu = sum(strcmp(pred,table2array(testDataTable(:,5))))/numel(testDataTable(:,5));
disp(accu)

figure
hold(gca,"on"),grid(gca,"on"),box(gca,"on")
plot(mdl.TrainingHistory.Iteration,mdl.TrainingHistory.TrainingLoss, ...
    "LineWidth",1.5,"LineStyle","-","Marker","o","DisplayName","Training loss")
plot(mdl.TrainingHistory.Iteration,mdl.TrainingHistory.ValidationLoss, ...
    "LineWidth",1.5,"LineStyle","-","Marker","square","DisplayName","Test loss")
title(sprintf("Training loss:%.8f",mdl.TrainingHistory.TrainingLoss(end)))
xlabel("Interation")
ylabel("Training loss")
xlim([0,mdl.TrainingHistory.Iteration(end)])
legend
