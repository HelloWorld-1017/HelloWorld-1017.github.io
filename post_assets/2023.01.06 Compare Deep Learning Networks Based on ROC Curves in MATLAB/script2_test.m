clc, clear, close all

load results.mat

% Prepare the test data
augimdsTest = augmentedImageDatastore(inputSize, imdsTest);

% Classify the test data
[YTestSmallNet, scoresSmallNet] = classify(netSmallNet, augimdsTest);
[YTestGoogLeNet, scoresGoogLeNet] = classify(netGoogLeNet, augimdsTest);

% Compare the accuracy
TTest = imdsTest.Labels;
% accSmallNet = sum(TTest == YTestSmallNet)/numel(TTest);
% accGoogLeNet = sum(TTest == YTestGoogLeNet)/numel(TTest);

% % Plot confunsion matrix
% figure 
% tiledlayout(1,2)
% nexttile
% confusionchart(TTest, YTestSmallNet)
% title("SmallNet")
% nexttile
% confusionchart(TTest, YTestGoogLeNet)
% title("GoogLeNet")

% Compare ROC Curves
% Create rocmetrics objects
classNames = netSmallNet.Layers(end).Classes;
rocSmallNet = rocmetrics(TTest, scoresSmallNet, classNames);
rocGoogLeNet = rocmetrics(TTest, scoresGoogLeNet, classNames);

% % Plot ROC Curves
% figure
% tiledlayout(1,2)
% nexttile
% plot(rocSmallNet)
% title("ROC Curve: SmallNet")
% nexttile
% plot(rocGoogLeNet)
% title("ROC Curve: GoogLeNet")

% % Access the AUC value for each class
% aucSmallNet = rocSmallNet.AUC;
% aucGoogLeNet = rocGoogLeNet.AUC;
% 
% figure
% bar([aucSmallNet; aucGoogLeNet]')
% xticklabels(classNames)
% legend(["SmallNet","GoogLeNet"],Location="southeast")
% title("AUC")

% % Plot ROC curves of 'sunflowers' class
% classToInvestigate = "sunflowers";
% 
% figure
% c = cell(2,1);
% g = cell(2,1);
% [c{1},g{1}] = plot(rocSmallNet,ClassNames=classToInvestigate);
% hold on
% [c{2},g{2}] = plot(rocGoogLeNet,ClassNames=classToInvestigate);
% modelNames = ["SmallNet","GoogLeNet"];
% for i = 1:2
%     c{i}.DisplayName = replace(c{i}.DisplayName, ...
%         classToInvestigate,modelNames(i));
%     g{i}(1).DisplayName = join([modelNames(i),"Model Operating Point"]);
% end
% title("ROC Curve","Class: " + classToInvestigate)
% hold off

% Compare average ROC curves
figure
[FPR1, TPR1, Thresholds1, AUC1] = average(rocSmallNet, "macro");
[FPR2, TPR2, Thresholds2, AUC2] = average(rocGoogLeNet, "macro");
hold(gca, "on")
box(gca, "on")
plot([0; FPR1], [0; TPR1],...
    DisplayName=sprintf("SmallNet (AUC=%.4f)", AUC1))
plot([0; FPR2], [0; TPR2],...
    DisplayName=sprintf("GoogLelNet (AUC=%.4f)", AUC2))
legend("Location", "southeast")
xlabel("FPR")
ylabel("TPR")

