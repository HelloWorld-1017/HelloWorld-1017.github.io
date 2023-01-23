clc, clear, close all

% Obtain access token
api_key = '*****************';
secret_key = '*****************';
url_token = ['https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=', api_key, '&client_secret=', secret_key];
token = webread(url_token);
token = token.access_token;

% Read image and convert it to base64 code
filname = fullfile(pwd, "before_sunrise.png");
base64string = base64file(filname);

% Post via API
webb = ['https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=' token];
ocrResults = webwrite(webb, 'image', base64string, ...
    'Content-Type', 'application/x-www-form-urlencoded');

ocrResults.words_result.words