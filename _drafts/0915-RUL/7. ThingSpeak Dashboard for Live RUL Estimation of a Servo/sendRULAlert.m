%% Send RUL Alert
% Alerts the user of impending servo motor failure through a text message (i.e.,
% a status update to the channel).

% This "MATLAB Analysis" code is associated with the "Send RUL Alert" React
% control to send a text message alert (as a status update in the channel) every
% 10 minutes while the current RUL estimate for an impending failure is
% determined to be less than 4 hours.
%
% Copyright 2021 The MathWorks, Inc.

%% Configure the Channel ID value.
% Replace the [] with channel ID to read data from:
readChannelID = [];
% RUL estimate is stored in field 6 of the channel.
fieldID = 6;

% Read recent RUL estimates and remove any invalid or empty values.
data = thingSpeakRead(readChannelID, 'Fields', fieldID, 'NumPoints', 10, ...
  'OutputFormat', 'timetable');
data = rmmissing(data);

%% Configure the Write API Key value.
% Enter the Write API Key between the '' below:
writeAPIKey = '';

% Post status update message to the channel.
url = sprintf('https://api.thingspeak.com/update.json');
if data.RemainingUsefulLifehr(end) <= 4 
  msg = sprintf("ALERT: %3.1f hours to failure detected at %s", ...
    data.RemainingUsefulLifehr(end), string(datetime));
  % Alternatively, send an email alert.
  %sendAlertEmail(data.RemainingUsefulLifehr(end));
elseif data.RemainingUsefulLifehr(end) <= 8
  msg = sprintf("WARNING: %3.1f hours to failure detected at %s", ...
    data.RemainingUsefulLifehr(end), string(datetime));
else
  msg = sprintf("HEALTHY: More than %3.0f hours to failure as of %s", ...
    data.RemainingUsefulLifehr(end), string(datetime));
end

try
  webwrite(url, 'api_key', writeAPIKey, 'status', msg);
catch E
  fprintf("Failed to send alert:\n %s\n", E.message);
end
