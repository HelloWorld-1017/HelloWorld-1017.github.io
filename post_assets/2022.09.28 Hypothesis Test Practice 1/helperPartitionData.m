function [X_mix, Y_mix, X_generate, Y_generate, X_test, Y_test] = helperPartitionData(Features, Labels, numPerClass)

% Convert labels to categorical variable
Labels = categorical(Labels);
% % Class names
% ClassNames = categories(Labels);

% Partition train and test set
cv = cvpartition(Labels, 'HoldOut', 0.2, 'Stratify', true);
X_train = Features(cv.training, :);
Y_train = Labels(cv.training, :);
X_test = Features(cv.test, :);
Y_test = Labels(cv.test, :);

% Calculate the mean and covariance matrix
[CategoricalVariable, Classes] = findgroups(Y_train);
means = splitapply(@mean, X_train, CategoricalVariable);
covs = splitapply(@(x){cov(x)}, X_train, CategoricalVariable);

X_generate = [];
Y_generate = [];
% Generate data and mix with real train data
for i = 1:numel(Classes)
    X_generate = [X_generate; mvnrnd(means(i, :), covs{i}, numPerClass)];
    Y_generate = [Y_generate; repmat(Classes(i), numPerClass, 1)];
end

X_mix = [X_train; X_generate];
Y_mix = [Y_train; Y_generate];
end
