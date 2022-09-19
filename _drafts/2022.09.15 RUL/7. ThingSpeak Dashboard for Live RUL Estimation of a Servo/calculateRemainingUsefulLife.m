%% Calculate Remaining Useful Life Estimate
% Calculates the remaining useful life of the servo motor using the total band
% power of the motor current as the health indicator. Saves the RUL estimate to
% the ThingSpeak channel as the field "Remaining Useful Life (hr)".

% This "MATLAB Analysis" code is associated with the "Calculate Remaining Useful
% Life Estimate" React control that runs whenever a new, valid feature value is
% inserted into the "Total Band Power" field of the channel.
%
% Copyright 2021 The MathWorks, Inc.

%% Configure the Channel ID and the Read API Key values.
% Replace the [] with channel ID to read data from:
readChannelID = [];
% If your channel is private, then enter the Read API Key between the '' below:
readAPIKey = '';
% Total Band Power feature is stored in field 3 of the channel.
fieldID = 3;

%% Read the data since the last servo motor replacement.
% For our example, we assume that the servo motor fails and is replaced every 24
% hours at 12:00 AM.
dStart = dateshift(datetime, "start", "day");
dNow = datetime;
range = [dStart, dNow];
% Read feature data and remove any invalid or empty values.
data = thingSpeakRead(readChannelID, 'Fields', fieldID, ...
  'ReadKey', readAPIKey, 'DateRange', range, 'OutputFormat', 'timetable');
data = rmmissing(data);

% Return if there is no valid data available, for example, right after the servo
% motor was replaced.
if isempty(data)
  return;
end

%% Construct the exponential degradation model
% Use the Total Band Power as the health index and compute the current RUL
% estimate of the servo motor. Reload from channel Metadata setting the initial
% state of the model parameters obtained from fitting historical data to the
% degradation model. The parameter priors are used to initialize the degradation
% model before estimating a new RUL value from available data.
state = loadModelState();
mdl = exponentialDegradationModel( ...
  'Theta', state.Theta, ...
  'ThetaVariance', state.ThetaVariance, ...
  'Beta', state.Beta, ...
  'BetaVariance', state.BetaVariance, ...
  'Phi', state.Phi, ...
  'Rho', state.Rho, ...
  'NoiseVariance', 0.1, ...
  'SlopeDetectionLevel', [], ...
  'LifeTimeVariable', data.Properties.DimensionNames{1}, ...
  'LifeTimeUnit', "hours", ...
  'DataVariables', data.Properties.VariableNames{1});

% Set RUL degradation threshold for the health index (Total Band Power).
threshold = 13;

% The data here is not historical data, but rather recent real-time observations
% of the servo motor features recorded in the fields of the ThingSpeak channel.

% Update the degradation model using available feature values since the servo
% motor was last replaced. Then compute the current RUL estimate based on the
% failure threshold.
update(mdl, data)
rul = hours(predictRUL(mdl, threshold));

%% Configure the Channel ID and the Write API Key values.
% Replace the [] with channel ID to write data to:
writeChannelID = [];
% Enter the Write API Key between the '' below:
writeAPIKey = '';

% Write the updated RUL estimate to the channel specified by the
% 'writeChannelID' variable.
% RUL estimate value is stored in field 6 of the ThingSpeak channel.
fieldID = 6;
thingSpeakWrite(writeChannelID, rul, 'Fields', fieldID, 'WriteKey', writeAPIKey);