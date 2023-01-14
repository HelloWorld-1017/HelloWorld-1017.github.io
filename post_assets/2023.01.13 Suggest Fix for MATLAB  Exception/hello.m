function hello(audience)
if nargin < 1
    me = MException('MATLAB:notEnoughInputs', 'Not enough input arguments.');
    aac = matlab.lang.correction.AppendArgumentsCorrection('"world"');
    me = me.addCorrection(aac);
    throw(me);
end

fprintf("Hello, %s!\n", audience);
end