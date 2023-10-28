function [totalRuns,runsInfo] = helperCountRuns(samples)
% Count category number
categories = unique(samples);

% Calculate total runs
num = numel(samples);
idx1 = samples(1:num-1)~=samples(2:num);
totalRuns = sum(idx1)+1;

% Find each run slice
pos1 = find(idx1==1);
pos2 = [1,pos1+1];
pos1 = [pos1,num];
slices = arrayfun(@(x,y) samples(x:y),pos2,pos1,"UniformOutput",false);
categoryOfEachSlice = cellfun(@(x) categories(categories==unique(x)),slices);

% Count runs of each length
runsInfo = struct;
for i = 1:numel(categories)
    category = categories(i);
    runsInfo.("Category_"+category).("Category") = category;
    slice = slices(categoryOfEachSlice==category);
    [classVariables1,lengths_1] = findgroups(cellfun(@numel,slice));
    runs_1 = splitapply(@numel,slice,classVariables1);
    runsInfo.("Category_"+category).("Lengths") = lengths_1;
    runsInfo.("Category_"+category).("Runs") = runs_1;
end

% Print results
fprintf("Total run(s): %d\n",totalRuns)
for i = 1:numel(categories)
    category = categories(i);
    fprintf("%s's run(s): %d run(s)\n", ...
        runsInfo.("Category_"+category).("Category"),sum(runsInfo.("Category_"+category).("Runs")));
    arrayfun(@(x,y) fprintf("Length = %d: %d run(s)\n",x,y),runsInfo.("Category_"+category).("Lengths"),runsInfo.("Category_"+category).("Runs"));
    fprintf("\n")
end
end
