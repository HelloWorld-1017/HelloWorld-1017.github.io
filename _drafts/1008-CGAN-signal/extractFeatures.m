function ci = extractFeatures(flow)
%EXTRACTFEATURES Extract features from flow signal.

% Copyright 2020 The MathWorks, Inc.

fA = flow - mean(flow);
[flowSpectrum, flowFrequencies] = pspectrum(fA, 1000, 'FrequencyLimits', [2 250]);
ci = extractCI(flow, flowSpectrum, flowFrequencies);
end

function ci = extractCI(flow, flowP, flowF)
% Compute signal statistical characteristics.

% Find frequency of peak magnitude in power spectrum
pMax = max(flowP);
fPeak = min(flowF(flowP==pMax));

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
[pKur,fKur] = pkurtosis(flow, 1000);
pKur = fKur(pKur == max(pKur));

% Compute flow cumulative sum range
csFlow = cumsum(flow);
csFlowRange = max(csFlow)-min(csFlow);

% Collect features and feature values in cell array.
qMean = mean(flow);
qVar = var(flow);
qSkewness = skewness(flow);
qKurtosis = kurtosis(flow);
qPeak2Peak = peak2peak(flow);
qCrest = peak2rms(flow);
qRMS = rms(flow);
qMAD = mad(flow);
qCSRange = csFlowRange;
pKurtosis =  pKur(1);

ci = [fPeak, pLow, pMid, pHigh, pKurtosis, ...
    qMean, qVar, qSkewness, qKurtosis, ...
    qPeak2Peak, qCrest, qRMS, qMAD, qCSRange];
end 