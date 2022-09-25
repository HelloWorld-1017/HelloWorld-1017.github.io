clc, clear, close all
load fisheriris

rng('default')
species = categorical(species);
% Class names
C = categories(species); 
% Class numbers
numClasses = size(C,1);

figure('Units', 'pixels', 'Position', [1000, 552, 856, 785])
% Cross validation method with 'Stratify'=false
cv1 = cvpartition(species, 'KFold', 5, 'Stratify', false);
plotBar(cv1, species, numClasses, C, 'Nonstratified Partition')
% Cross validation method with 'Stratify'=true
cv2 = cvpartition(species, 'KFold', 5, 'Stratify', true);
plotBar(cv2, species, numClasses, C, 'Stratified Partition')

function plotBar(cv, species, numClasses, ClassName, titleName)
numFolds = cv.NumTestSets;
nTestData = zeros(numFolds, numClasses);
for i = 1:numFolds
    % Record number of test set observations in each class
    testClasses = species(cv.test(i));
    nCounts = countcats(testClasses); 
    nTestData(i, :) = nCounts';
end
nexttile
bar(nTestData)
xlabel('Test Set (Fold)')
ylabel('Number of Observations')
title(titleName)
legend(ClassName)
grid on
box on
end

