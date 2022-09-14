clc, clear, close all
% Load real dataset
load fisheriris


numTimes = 100;
accus = zeros(numTimes, 1);

for i = 1:numel(accus)
    % Construct train and test data set
    [X_train, Y_train, X_test, Y_test] = helperConstructTrainAndTestSet(meas, species, 1000);

    % Create and train an SVM
    t = templateSVM('Standardize', true);
    mdl = fitcecoc(X_train, Y_train, 'Learners', t, 'ClassNames', {'setosa','versicolor','virginica'});

    % Predict the labels using the true fetures
    pred = mdl.predict(X_test);

    % Calculate the accuracy
    accu = sum(strcmp(pred, Y_test))/numel(Y_test);
end

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
