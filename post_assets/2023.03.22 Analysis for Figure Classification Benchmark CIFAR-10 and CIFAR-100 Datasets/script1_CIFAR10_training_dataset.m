clc,clear,close all

numsBatches = 5;
nums = nan(numsBatches,10);

for i = 1:numsBatches
    filename = sprintf("data_batch_%s.mat",num2str(i));
    load(filename)
    disp(batch_label)

    [ClassVariable,Class] = findgroups(labels);
    nums(i,:) = splitapply(@numel, labels, ClassVariable);

    disp("Sample size")
    disp(sum(nums(i,:)))
    disp("Sample size of each class in per batch")
    disp(nums(i,:))

    clear batch_label data labels
end
disp("Sample size of each class in whole training dataset")
disp(sum(nums))
