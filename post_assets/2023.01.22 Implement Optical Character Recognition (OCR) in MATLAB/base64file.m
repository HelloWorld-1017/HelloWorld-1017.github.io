function base64string = base64file(file)
%BASE64FILE encode a file in base64
%
% base64 = base64file(filename) returns the file's contents as a
%  base64-encoded string
%
% This file uses the base64 encoder from the Apache Commons Codec, 
% http://commons.apache.org/codec/ and distrubed with MATLAB under the
% Apache License http://commons.apache.org/license.html

% Copyright 2009 The MathWorks, Inc.

fid = fopen(file,'rb');
bytes = fread(fid);
fclose(fid);
encoder = org.apache.commons.codec.binary.Base64;
base64string = char(encoder.encode(bytes))';