function [accus_mix, accus_generate, accus_mix_minus_generate] = ...
    helperLoop(Features, Labels, numTimes, numPerClass)

accus_mix = zeros(numTimes, 1);
accus_generate = zeros(numTimes, 1);

for i = 1:numel(accus_mix)
    % Partition data
    [X_mix, Y_mix, X_generate, Y_generate, X_test, Y_test] = ...
        helperPartitionData(Features, Labels, numPerClass);

    % Create and train two SVMs
    t = templateSVM('Standardize', true);
    mdl_mix = fitcecoc(X_mix, Y_mix, 'Learners', t);
    mdl_generate = fitcecoc(X_generate, Y_generate, 'Learners', t);

    % Predict the labels using the true fetures
    pred_mix = mdl_mix.predict(X_test);
    pred_generate = mdl_generate.predict(X_test);

    % Calculate the accuracies
    accus_mix(i) = sum(pred_mix==Y_test)/numel(Y_test);
    accus_generate(i) = sum(pred_generate==Y_test)/numel(Y_test);
end
accus_mix_minus_generate = accus_mix-accus_generate;