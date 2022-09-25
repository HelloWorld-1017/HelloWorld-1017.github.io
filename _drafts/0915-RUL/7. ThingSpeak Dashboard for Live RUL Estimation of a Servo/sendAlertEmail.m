function sendAlertEmail(rul)
% Send alert email indicating the estimated RUL value.
alertMessage = sprintf("ALERT: %3.1f hours to failure detected.", rul);
alertSubject = sprintf("Pending servo motor failure");

% Configure the Alert API Key value.
% Enter the Alert API Key between the '' below:
alertAPIKey = '';
options = weboptions("HeaderFields", ["ThingSpeak-Alerts-API-Key", alertAPIKey ]);

alertURL = "https://api.thingspeak.com/alerts/send";
try
  webwrite(alertURL, "body", alertMessage, "subject", alertSubject, options);
catch E
  fprintf("Failed to send alert:\n %s\n", E.message);
end
end

% Copyright 2021 The MathWorks, Inc.