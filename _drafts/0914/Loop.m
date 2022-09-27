function Loop(Features, Labels, numTimes, numPerClass, DatasetName)
% Trained with real and generated data
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    % Construct train and test data set
    [X_train, Y_train, X_test, Y_test] = helperConstructTrainAndTestSet(Features, Labels, numPerClass, "mix");
    % Train and test
    accu = TrainAndTest(X_train, Y_train, X_test, Y_test);
    accus(i) = accu;
end
accu_ave = mean(accus);
accu_std = std(accus);
sprintf('[%s]\nModel trained with real and generated data\n(%d Loops, %d Train sample numbers): \nAverage of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    DatasetName, numTimes, height(X_train), accu_ave, accu_std)

% Trained with ONLY generated data
for i = 1:numel(accus)
    % Construct train and test data set
    [X_train, Y_train, X_test, Y_test] = helperConstructTrainAndTestSet(Features, Labels, numPerClass, "generate");
    % Train and test
    accu = TrainAndTest(X_train, Y_train, X_test, Y_test);
    accus(i) = accu;
end
accu_ave = mean(accus);
accu_std = std(accus);
sprintf('[%s]\nModel trained with ONLY generated data\n(%d Loops, %d Train sample numbers): \nAverage of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    DatasetName, numTimes, height(X_train), accu_ave, accu_std)
end