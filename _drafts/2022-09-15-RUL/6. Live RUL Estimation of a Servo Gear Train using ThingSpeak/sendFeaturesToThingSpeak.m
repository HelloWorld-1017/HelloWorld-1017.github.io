function sendFeaturesToThingSpeak(features)
% Sends feature values to a ThingSpeak channel as separate fields.

% Configure the Channel ID and the Write API Key values.
channelID = 1864768; % Replace with your channel ID to write data to.
writeKey = 'X8869XZVA35JSJ3Q'; % Replace with the write API key of your channel.

% Write the features to the channel specified by the 'channelID' variable.
fields = 1:numel(features); % Up to 8 features
thingSpeakWrite(channelID, features, 'Fields', fields, 'WriteKey', writeKey);
end