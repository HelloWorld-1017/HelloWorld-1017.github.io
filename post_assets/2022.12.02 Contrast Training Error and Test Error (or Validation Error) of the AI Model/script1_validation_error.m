clc, clear, close all

load patients
tbl = table(Diastolic,Systolic,Gender,Height,Weight,Age,Smoker);

rng("default") % For reproducibility of the partition
c = cvpartition(tbl.Smoker,"Holdout",0.30);
trainingIndices = training(c);
validationIndices = test(c);
tblTrain = tbl(trainingIndices,:);
tblValidation = tbl(validationIndices,:);

Mdl = fitcnet(tblTrain,"Smoker", ...
    "ValidationData",tblValidation, ...
    "Verbose",1);

iteration = Mdl.TrainingHistory.Iteration;
trainLosses = Mdl.TrainingHistory.TrainingLoss;
valLosses = Mdl.TrainingHistory.ValidationLoss;

plot(iteration,trainLosses,iteration,valLosses)
legend(["Training","Validation"])
xlabel("Iteration")
ylabel("Cross-Entropy Loss")

[~,minIdx] = min(valLosses);
iteration(minIdx)