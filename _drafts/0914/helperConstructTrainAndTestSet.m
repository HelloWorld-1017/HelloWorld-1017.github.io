function [X_train, Y_train, X_test, Y_test] = helperConstructTrainAndTestSet(Features, Labels, numPerClass)

classes = unique(Labels);
if isa(classes, "double")
    classes = string(classes);
end


X_train = []; Y_train = [];
X_generate = []; Y_generate = [];
X_test = []; Y_test = [];

for i = 1:numel(classes)
    class = string(classes{i});
    % Split the features of different classes
    eval(['idx = strcmp(Labels, ', char(class), ');']);
    eval(sprintf('Features_%s = Features(idx, :);', class));

    % Split train and test set
    eval(sprintf('numRows = height(Features_%s);', class));
    idx = randperm(numRows);
    idx_train = idx(round(numRows*0.2)+1:end);
    idx_test = idx(1:round(numRows*0.2));
    eval(sprintf('Features_%s_train = Features_%s(idx_train, :);', class, class));
    eval(sprintf('Features_%s_test = Features_%s(idx_test, :);', class, class));

    % Calculate the mu and Sigma of Features from train set
    eval(sprintf('mu_%s = mean(Features_%s_train);', class, class));
    eval(sprintf('Sigma_%s = cov(Features_%s_train);', class, class));

    % Generate the features and the corresponding labels
    eval(sprintf('X_generate = [X_generate; mvnrnd(mu_%s, Sigma_%s, numPerClass)];', class, class));
    eval(sprintf('Y_generate = [Y_generate; %s*ones(numPerClass, 1)];', class));

    % Construct test set, including features and labels
    eval(sprintf('X_test = [X_test; Features_%s_test];', class));
    eval(sprintf('[rows_%s, ~] = size(Features_%s_test);', class, class));
    eval(sprintf('Y_test = [Y_test; repmat(%s, rows_%s, 1)];', class));

    % Construct real train set
    eval(sprintf('X_train = [X_train; Features_%s_train];', class));
    eval(sprintf('[rows_%s, ~] = size(Features_%s_train);', class, class));
    eval(sprintf('Y_train = [Y_train; %s*ones(rows_%s, 1)];', class, class));
end

X_train = [X_generate; X_train];
Y_train = [Y_generate; Y_train];
end
