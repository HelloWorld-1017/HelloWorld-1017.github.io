clc, clear, close all

load CloseDataset_array.mat
load OpenDataset_array.mat

[CloseDataset_train, CloseDataset_test] = DataProcess(CloseDataset);
save("CloseDataset_train.mat", "CloseDataset_train");
save("CloseDataset_test.mat", "CloseDataset_test");

[OpenDataset_train, OpenDataset_test] = DataProcess(OpenDataset);
save("OpenDataset_train.mat", "OpenDataset_train");
save("OpenDataset_test.mat", "OpenDataset_test");

function [Dataset_train, Dataset_test] = DataProcess(Dataset)
X_generate = [];
Y_generate = [];
X_test = [];
Y_test = [];
X_train = [];
Y_train = [];

numPerClass = 1000;
for i = 0:6
    si = num2str(i);
    % Split the features of different classes
    eval(sprintf('idx = Dataset(:, 1)==%s;', si));
    eval(sprintf('Features_%s = Dataset(idx, 2:end);', si));

    % Split train and test set
    eval(sprintf('[numRows, ~] = size(Features_%s);', si));
    idx = randperm(numRows);
    idx_train = idx(round(numRows*0.2)+1:end);
    idx_test = idx(1:round(numRows*0.2));
    eval(sprintf('Features_%s_train = Features_%s(idx_train, :);', si, si));
    eval(sprintf('Features_%s_test = Features_%s(idx_test, :);', si, si));

    % Calculate the mu and Sigma of Features from train set
    eval(sprintf('mu_%s = mean(Features_%s_train);', si, si));
    eval(sprintf('Sigma_%s = cov(Features_%s_train);', si, si));

    % Generate the features and the corresponding labels
    eval(sprintf('X_generate = [X_generate; mvnrnd(mu_%s, Sigma_%s, numPerClass)];', si, si));
    eval(sprintf('Y_generate = [Y_generate; %s*ones(numPerClass, 1)];', si));

    % Construct test set, including features and labels
    eval(sprintf('X_test = [X_test; Features_%s_test];', si));
    eval(sprintf('[rows_%s, ~] = size(Features_%s_test);', si, si));
    eval(sprintf('Y_test = [Y_test; %s*ones(rows_%s, 1)];', si, si));

    % Construct real train set
    eval(sprintf('X_train = [X_train; Features_%s_train];', si));
    eval(sprintf('[rows_%s, ~] = size(Features_%s_train);', si, si));
    eval(sprintf('Y_train = [Y_train; %s*ones(rows_%s, 1)];', si, si));
end
Dataset_train= [Y_generate, X_generate; Y_train, X_train];
Dataset_test = [Y_test, X_test];
end




