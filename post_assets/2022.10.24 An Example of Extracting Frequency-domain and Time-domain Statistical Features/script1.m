clc, clear, close all

load simulatedDataset.mat

flow1 = flow(:, 1);
flow1 = flow1-mean(flow1);
% plot(flow1)
% set(gca, "XLim", [0, numel(flow1)-1])
% xlabel("Observations")
% ylabel("Signal")

[flowSpectrum, flowFrequencies] = pspectrum(flow1, 1000, 'FrequencyLimits', [2 250]);

% figure('Units', 'pixels', 'Position', [391,284,1105,420])
% tiledlayout(1, 2)
% nexttile
% pspectrum(flow1, 1000, 'FrequencyLimits', [2 250])
% nexttile
% plot(flowFrequencies, pow2db(flowSpectrum))
% set(gca, "XLim", [0, 250])
% grid(gca, "on")
% box(gca, "on")
% xlabel("Frequency")
% ylabel("Power Specturm")


ci = extractCI(flow1, flowSpectrum, flowFrequencies);


function ci = extractCI(flow, flowP, flowF)
% Compute signal statistical characteristics.

% Find frequency of peak magnitude in power spectrum
pMax = max(flowP);
fPeak = min(flowF(flowP==pMax));

figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
plot(flowF, flowP)
scatter(fPeak, pMax, "filled")

% Compute power in low-frequency range 10 Hz-20 Hz
fRange = flowF >= 10 & flowF <= 20;
pLow = sum(flowP(fRange));

% Compute power in mid-frequency range 40 Hz-60 Hz
fRange = flowF >= 40 & flowF <= 60;
pMid = sum(flowP(fRange));

% Compute power in high-frequency range >100 Hz
fRange = flowF >= 100;
pHigh = sum(flowP(fRange));

% Find frequency of spectral kurtosis peak
[pKur, fKur] = pkurtosis(flow, 1000);
pKur = fKur(pKur == max(pKur));
pKurtosis =  pKur(1);

% Compute flow cumulative sum range
csFlow = cumsum(flow);
csFlowRange = max(csFlow)-min(csFlow);
qCSRange = csFlowRange;

% Collect features and feature values in cell array.
qMean = mean(flow);
qVar = var(flow);
qSkewness = skewness(flow);
qKurtosis = kurtosis(flow);
qPeak2Peak = peak2peak(flow);
qCrest = peak2rms(flow);
qRMS = rms(flow);
qMAD = mad(flow);

ci = [fPeak, pLow, pMid, pHigh, pKurtosis, ...
    qMean, qVar, qSkewness, qKurtosis, ...
    qPeak2Peak, qCrest, qRMS, qMAD, qCSRange];
end
