clc, clear, close all

% Load the training data into memory
[xTrainImages, tTrain] = digitTrainCellArrayData;

% Display some of the training images
figure(1)
for i = 1:20
    subplot(4, 5, i);
    imshow(xTrainImages{i});
end

X = zeros(5000, 28*28);
for i = 1:numel(xTrainImages)
    X(i, :) = xTrainImages{i}(:);
end
[Y, ~] = find(tTrain == 1);

X_generate = [];
Y_generate = [];
numPerClass = 2000;
for i = 1:10
    idx = Y==i;
    expression = ['Image_', num2str(i), '=', 'X(idx, :);'];
    eval(expression);
    expression = ['mu_', num2str(i), '=', 'mean(Image_', num2str(i), ');'];
    eval(expression);
    expression = ['Sigma_', num2str(i), '=', 'cov(Image_', num2str(i), ');'];
    eval(expression);
    expression = ['X_generate=', '[X_generate; ', 'mvnrnd(mu_', num2str(i), ', ', 'Sigma_', num2str(i), ', numPerClass)];'];
    eval(expression);
    expression = ['Y_generate=', '[Y_generate;',  num2str(i), '*ones(numPerClass, 1)];'];
    eval(expression);
end

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

pred = mdl.predict(X);
accu = sum(pred==Y)/numel(Y)*100;

% Show generated image in figure(2)
idx = randperm(size(X_generate, 1))';
idx = idx(1:20);
X_show = X_generate(idx, :);
Y_show = Y_generate(idx, :);

X_show_cell = {};
for i = 1:size(X_show, 1)
    X_show_cell(i) = {reshape(X_show(i, :), 28, 28)};
end

figure(2)
for i = 1:size(X_show_cell, 2)
    subplot(4, 5, i);
    imshow(X_show_cell{i});
    title(num2str(Y_show(i)))
end