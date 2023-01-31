clc, clear, close all

% options = weboptions("ContentType", "text", ...
%     "Timeout", inf, ...
%     'characterencoding','UTF-8', ...
%     'RequestMethod', 'get');

% content = webread("https://ieeexplore.ieee.org/rest/search", options);

% content = webread("https://ieeexplore.ieee.org/search/searchresult.jsp?contentType=standards&queryText=Circuit%20breakers%20fault%20diagnosis&highlight=true&returnType=SEARCH&matchPubs=true&sortType=newest&pageNumber=1&returnFacets=ALL", ...
%     options);

% content = webread("https://ieeexplore.ieee.org/search/searchresult.jsp", "contentType", "standards",...
%     "queryText", "Circuit breakers fault diagnosis", "highlight", "true", ...
%     "returnType", "SEARCH", "matchPubs", "true", "sortType", "newest", "pageNumber", "1", "returnFacets", "ALL", ...
%     options);

url = 'https://ieeexplore.ieee.org/rest/search';
pp(1).Name = 'Accept';
pp(1).Occupation = 'application/json, text/plain, */*';
pp(2).Name = 'Accept-Encoding';
pp(2).Occupation = 'gzip, deflate, br';
pp(3).Name = 'Accept-Language';
pp(3).Occupation = 'zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6';
pp(4).Name = 'Connection';
pp(4).Occupation = 'keep-alive';
pp(5).Name = 'Content-Length';
pp(5).Occupation = 190;
pp(6).Name = 'Content-Type';
pp(6).Occupation = 'application/json';
pp(7).Name = 'Cookie';
pp(7).Occupation = 'fp=0f716801765bb109bec4a9a4f8be6742; __gads=ID=b3acfd168c0f1d6e:T=1672755636:S=ALNI_Ma1KmLNjDhQTD2uOQUGlioYzdnvuQ; s_ecid=MCMID%7C72265842787085805021887228290453411476; _ga_N9WZ2Y6SV8=GS1.1.1673954076.1.1.1673954092.0.0.0; _ga_YFS85CFJD1=GS1.1.1673955970.2.0.1673955970.0.0.0; s_fid=1999EBE34AA92655-1EE92B4068B520DD; s_vi=[CS]v1|31E3DDE59ED77022-40000580D031C777[CE]; _gid=GA1.2.187895577.1674903468; _hjSessionUser_2916772=eyJpZCI6ImY3OWU2ZWJmLWQ5OGMtNWMyNi1hYTMxLThiMDA4OWQ1Zjg5OSIsImNyZWF0ZWQiOjE2NzQ5MDM0NjgxNjIsImV4aXN0aW5nIjp0cnVlfQ==; AMCVS_8E929CC25A1FB2B30A495C97%40AdobeOrg=1; s_cc=true; _uetsid=110b5a509efb11ed8b14e9eedd3dd99c; _uetvid=110b80c09efb11ed848da1e297455b00; _gcl_au=1.1.870165567.1674903668; _mkto_trk=id:682-UPB-550&token:_mch-ieee.org-1674903467287-51420; _ga=GA1.2.1946688430.1673954076; ipList=210.3.157.153; cookieconsent_status=dismiss; _ga_F0XQ5J74J2=GS1.1.1674908638.2.0.1674908638.0.0.0; _ga_D32ZCZ855C=GS1.1.1674908638.2.0.1674908638.0.0.0; _ga_H0YHKP362D=GS1.1.1674908638.2.0.1674908638.60.0.0; _ga_KWYZYRTGDK=GS1.1.1674908638.2.0.1674908638.0.0.0; WLSESSION=237134476.20480.0000; _ga_L3K51H1X0F=GS1.1.1674914606.2.0.1674914606.0.0.0; _ga_XDL2ME6570=GS1.1.1674914606.2.0.1674914606.60.0.0; _ga_0M725P060E=GS1.1.1674914606.2.0.1674914606.0.0.0; _ga_438KQ3VE2B=GS1.1.1674914580.2.0.1674914606.0.0.0; _ga_PRKVE68L9M=GS1.1.1674914580.2.0.1674914606.0.0.0; AMCV_8E929CC25A1FB2B30A495C97%40AdobeOrg=1687686476%7CMCIDTS%7C19361%7CMCMID%7C72265842787085805021887228290453411476%7CMCAAMLH-1675519451%7C3%7CMCAAMB-1675519451%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1674921851s%7CNONE%7CMCAID%7CNONE%7CvVersion%7C3.0.0; ipCheck=210.3.157.153; s_sq=%5B%5BB%5D%5D; utag_main=v_id:0185780164100020a132cd0b92c805081003607900bd0$_sn:13$_se:27$_ss:0$_st:1674922913173$vapi_domain:ieee.org$ses_id:1674914648105%3Bexp-session$_pn:22%3Bexp-session; __gpi=UID=00000b9d69a2bf08:T=1672755636:RT=1674954321:S=ALNI_Ma33e48g3MGycaeDEv4_dSehY2MCQ; JSESSIONID=vRX7DrkB6mbC_gHauxL4Qk0AgeqHBclOLh-qG3Kd-9T6tgMP8NrB!-1652317715; TS01b03060=012f350623393291b536370a38df3e59df4c3aae46c12db8493ccabde36a3b4303b71809b91ca88d1972392267e17b002e3bbe3aa5; TSaeeec342027=080f8ceb8aab2000384c16e098afae07ca4be1da8392efda4a89d0140be5d5f7d836697dd379f03e08a10a4cff1130003273868a2d19b0e2277af388e396f355e6e637e9b420bf160368c463603a919ec1f9bcd824ea847b2d3fbb6802313e01';
pp(8).Name = 'Host';
pp(8).Occupation = 'ieeexplore.ieee.org';
pp(9).Name = 'Origin';
pp(9).Occupation = 'https://ieeexplore.ieee.org';
pp(10).Name = 'Referer';
pp(10).Occupation = 'https://ieeexplore.ieee.org/search/searchresult.jsp?contentType=standards&queryText=Circuit%20breakers%20fault%20diagnosis&highlight=true&returnType=SEARCH&matchPubs=true&sortType=newest&pageNumber=1&returnFacets=ALL';
pp(11).Name = 'Sec-Fetch-Dest';
pp(11).Occupation = 'empty';
pp(12).Name = 'Sec-Fetch-Mode';
pp(12).Occupation = 'cors';
pp(13).Name = 'Sec-Fetch-Site';
pp(13).Occupation = 'same-origin';
pp(14).Name = 'User-Agent';
pp(14).Occupation = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.70';
pp(15).Name = 'sec-ch-ua';
pp(15).Occupation = '"Not_A Brand";v="99", "Microsoft Edge";v="109", "Chromium";v="109"';
pp(16).Name = 'sec-ch-ua-mobile';
pp(16).Occupation = '?0';
pp(17).Name = 'sec-ch-ua-platform';
pp(17).Occupation = '"Windows"';
options = weboptions(...
    'RequestMethod', 'post',...
    "ContentType", "text", ...
    "Timeout", inf, ...
    'characterencoding','UTF-8');
response = webwrite(url, pp, options)
