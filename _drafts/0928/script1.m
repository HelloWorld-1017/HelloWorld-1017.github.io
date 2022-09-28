% clc, clear, close all
% 
% numTimes = 20;
% numPerClass = 1e3;
% 
% [xTrainImages, tTrain] = digitTrainCellArrayData;
% for i = 1:numel(xTrainImages)
%     X5(i, :) = xTrainImages{i}(:);
% end
% [Y5, ~] = find(tTrain == 1);
% [accus_mix, accus_generate, accus_mix_minus_generate] = ...
%     helperLoop(X5, Y5, numTimes, numPerClass);

% 0.8270    0.8160    0.8300    0.8190    0.8350    0.8260    0.8270    0.8120    0.8340    0.8170    0.8320    0.8280    0.8100    0.8340    0.8080    0.8260    0.8220    0.8100    0.8330    0.8390
% 0.7800    0.7850    0.7930    0.7790    0.7830    0.7940    0.7920    0.7820    0.8020    0.7790    0.7780    0.7760    0.7790    0.8040    0.7920    0.7860    0.7820    0.7770    0.7990    0.8060
% 0.0470    0.0310    0.0370    0.0400    0.0520    0.0320    0.0350    0.0300    0.0320    0.0380    0.0540    0.0520    0.0310    0.0300    0.0160    0.0400    0.0400    0.0330    0.0340    0.0330

sum_obs = sum(accus_mix_minus_generate);




