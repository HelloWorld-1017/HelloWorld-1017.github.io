function state = loadModelState()
% Load the model state (i.e., the prior for the model parameters) from the
% Metadata setting of the channel and convert it to a MATLAB variable (struct).

% Configure the Channel ID.
% Replace the [] with channel ID to read data from:
readChannelID = [];

% Read the stored RUL model initialization state from the Metadata field of the
% channel specified by the 'readChannelID' variable.
url = sprintf('https://api.thingspeak.com/channels/%d/feeds.json', readChannelID);
response = webread(url, 'metadata', 'true', 'status', 'true', 'results', 30);

state = jsondecode(response.channel.metadata);
end

% Copyright 2021 The MathWorks, Inc.