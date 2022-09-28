function [X_train, Y_train, X_test, Y_test] = helperConstructTrainAndTestSet(Features, Labels, numPerClass, Tag)
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

if strcmp(Tag, "generate")
    X_train = [];
    Y_train = [];
end

% Generate data and mix with real train data
for i = 1:numel(Classes)
    X_train = [X_train; mvnrnd(means(i, :), covs{i}, numPerClass)];
    Y_train = [Y_train; repmat(Classes(i), numPerClass, 1)];
end

end
