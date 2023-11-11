%% Generate Synthetic Servo Motor Features
% Generate synthetic servo motor features and save the values to the ThingSpeak
% channel as separate fields.

% This "MATLAB Analysis" code is associated with the "Generate Synthetic Servo
% Motor Features" TimeControl that runs every 5 minutes to trigger the
% computation of new servo motor features from available or synthetic data.
%
% Copyright 2021 The MathWorks, Inc.

%% Simulate time-domain motor features.
% Motor winding current fluctuates between [308 320] mA.
motorCurrent = 308 + 12*rand(1);

% Motor speed fluctuates between [20 23] rpm.
rpm = 20 + 3*rand(1);

%% Simulate frequency domain features of the motor current.
% Power spectrum amplitudes at motor shaft frequencies (1xFS1 and 2xFS1) and
% the total band power.

% Parameters to simulate complete degradation of the servo motor over the course
% of a full day.
dStart = dateshift(datetime, "start", "day");
dNow = datetime;
dayScale = seconds(dNow - dStart) / (24*3600);

% Peak power spectrum amplitude at the first harmonic of the motor shaft
% frequency (1xFS1) changes linearly between [-30 10] dB as degradation
% increases. White noise is added to simulate more realistic sensor data.
peak1FS1 = -30 + (10+30)*dayScale + randn(1);

% Peak power spectrum amplitude at the second harmonic of the motor shaft
% frequency (2xFS1) changes linearly between [-20 0] dB as degradation
% increases. White noise is added to simulate more realistic sensor data.
peak2FS1 = -20 + (0+20)*dayScale + randn(1);

% Total band power of the motor current changes exponentially between [1 13] as
% degradation increases and failure is assumed to occur at the threshold value
% 13. White noise is added to simulate more realistic sensor data. The band
% power is used as the Health Index for RUL estimations.
phi = 0.5;
theta = 0.5;
threshold = 13;
beta = log((threshold-phi) / theta);
bandPower = phi + theta * exp(beta*dayScale + randn(1)/10);

%% Configure the Channel ID and the Write API Key values.
% Replace the [] with channel ID to write data to:
writeChannelID = [];
% Enter the Write API Key between the '' below:
writeAPIKey = '';

% Write the features to the channel specified by the 'writeChannelID' variable.
features = [peak1FS1, peak2FS1, bandPower, motorCurrent, rpm];
fields = 1:numel(features);
thingSpeakWrite(writeChannelID, features, 'Fields', fields, 'WriteKey', writeAPIKey);