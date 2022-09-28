clc, clear, close all

numTimes = 15;
numPerClass = 1e3;

load fisheriris
[accus_mix1, accus_generate1, accus_mix_minus_generate1] = ...
    helperLoop(meas, species, numTimes, numPerClass);
p1 = helperSignificanceTest(accus_mix_minus_generate1, numTimes);
fprintf('p1: %.4f\n', p1)

load ionosphere.mat
[accus_mix2, accus_generate2, accus_mix_minus_generate2] = ...
    helperLoop(X, Y, numTimes, numPerClass);
p2 = helperSignificanceTest(accus_mix_minus_generate2, numTimes);
fprintf('p2: %.4f\n', p2)

load ovariancancer.mat
[accus_mix3, accus_generate3, accus_mix_minus_generate3] = ...
    helperLoop(obs, grp, numTimes, numPerClass);
p3 = helperSignificanceTest(accus_mix_minus_generate3, numTimes);
fprintf('p3: %.4f\n', p3)

load simulatedDataset.mat
flow = flow';
labels = labels';
[accus_mix4, accus_generate4, accus_mix_minus_generate4] = ...
    helperLoop(flow, labels, numTimes, numPerClass);
p4 = helperSignificanceTest(accus_mix_minus_generate4, numTimes);
fprintf('p4: %.4f\n', p4)

[xTrainImages, tTrain] = digitTrainCellArrayData;
for i = 1:numel(xTrainImages)
    X5(i, :) = xTrainImages{i}(:);
end
[Y5, ~] = find(tTrain == 1);
[accus_mix5, accus_generate5, accus_mix_minus_generate5] = ...
    helperLoop(X5, Y5, numTimes, numPerClass);
p5 = helperSignificanceTest(accus_mix_minus_generate5, numTimes);
fprintf('p5: %.4f\n', p5)

