function accu = TrainAndTest(X_train, Y_train, X_test, Y_test)
% Create and train an SVM
t = templateSVM('Standardize', true);
mdl = fitcecoc(X_train, Y_train, 'Learners', t);

% Predict the labels using the true fetures
pred = mdl.predict(X_test);

% Calculate the accuracy
accu = sum(pred == Y_test)/numel(Y_test);
end