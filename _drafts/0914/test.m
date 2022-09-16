clc, clear
load fisheriris

Labels = species;
Features = meas;

numPerClass = 5e2;

[CategoricalVariable, Classes] = findgroups(Labels);



% Try: trainDataFused = cellfun(@(data) degradationSensorFusion(data, sensorToFuse, weights), trainDataNormalized, ...
%     'UniformOutput', false);
% for i = 1:unique(CategoricalVariable)
%     
% end
% Dataset = {Labels, Features};
% [X_train, X_test, Y_train, Y_test] = splitapply(@(x1, x2){splitTrainAndTestIdx(x1, x2)}, Dataset, CategoricalVariable);
% 

% dd = splitapply(@mean, Features, CategoricalVariable);
% vv = splitapply(@(x){cov(x)}, Features, CategoricalVariable);
% for i = 1:numel(classes)
% 
% end

% function  [X_train, X_test, Y_train, Y_test] = splitTrainAndTestIdx(Dataset)
% 
% numRows = height(Labels);
% numSelectedRows = round(numRows*0.2);
% idx = randperm(numSelectedRows);
% idx_train = idx(numSelectedRows+1:end);
% idx_test = idx(1:numSelectedRows);
% X_train = Features(idx_train, :);
% X_test = Features(idx_test, :);
% Y_train = Labels(idx_train, :);
% Y_test = Labels(idx_test, :);
% end
