function sendSyntheticFeaturesToThingSpeak()
% Generate synthetic features and send them to ThinkSpeak.
persistent bandPower
if isempty(bandPower)
  bandPower = 5;
end

% Simulate motor features and fault band metrics.
motorCurrent = 308+12*rand(1); % between [308 320] mA
rpm = 20+3*rand(1); % between [20 23] rpm
bandPower = bandPower + rand(1)/2; % bandPower degradation
metrics = [rand(1), rand(1), bandPower];
features = [metrics, motorCurrent, rpm];

disp('Sending features to ThingSpeak...');
sendFeaturesToThingSpeak(features)
end