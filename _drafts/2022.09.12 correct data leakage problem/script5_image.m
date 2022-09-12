clc, clear, close all

% Load the training data into memory
[xTrainImages, tTrain] = digitTrainCellArrayData;

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(xTrainImages, tTrain);
    disp(i)
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)

function accu = TrainAndTest(xTrainImages, tTrain)
X = zeros(5000, 28*28);
for i = 1:numel(xTrainImages)
    X(i, :) = xTrainImages{i}(:);
end
[Y, ~] = find(tTrain == 1);

X_generate = [];
Y_generate = [];
X_test = [];
Y_test = [];
numPerClass = 2000;
for i = 1:10
    si = num2str(i);
    % Split the features of different classes
    idx = Y==i;
    expression = sprintf('Image_%s = X(idx, :);', si);
    eval(expression);

    % Split train and test set
    expression = sprintf('[numRows, ~] = size(Image_%s);', si);
    eval(expression)
    idx = randperm(numRows);
    idx_train = idx(round(numRows*0.2)+1:end);
    expression = sprintf('Image_%s_train = Image_%s(idx_train, :);', si, si);
    eval(expression)
    idx_test = idx(round(numRows*0.2)+1:end);
    expression = sprintf('Image_%s_test = Image_%s(idx_test, :);', si, si);
    eval(expression)

    % Calculate the mu and Sigma of features of each sepices from train set
    expression = sprintf('mu_%s = mean(Image_%s_train);', si, si);
    eval(expression);
    expression = sprintf('Sigma_%s = cov(Image_%s_train);', si, si);
    eval(expression);

    % Generate the features and the corresponding labels
    expression = sprintf('X_generate = [X_generate; mvnrnd(mu_%s, Sigma_%s, numPerClass)];', si, si);
    eval(expression);
    expression = sprintf('Y_generate= [Y_generate; %s*ones(numPerClass, 1)];', si);
    eval(expression);

    % Construct test set, including features and labels
    expression = sprintf('X_test = [X_test; Image_%s_test];', si);
    eval(expression)
    expression = sprintf('[rows_%s, ~] = size(Image_%s_test);', si, si);
    eval(expression)
    expression = sprintf('Y_test = [Y_test; %s*ones(rows_%s, 1)];', si, si);
    eval(expression)
end

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

pred = mdl.predict(X_test);
accu = sum(pred==Y_test)/numel(Y_test);
end