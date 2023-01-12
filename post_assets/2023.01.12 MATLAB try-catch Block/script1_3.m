clc, clear, close all

A = rand(3);
B = ones(5);

try
   C = [A; B];
catch ME
   if (strcmp(ME.identifier, 'MATLAB:catenate:dimensionMismatch'))
      msg = ['Dimension mismatch occurred: First argument has ', ...
            num2str(size(A,2)),' columns while second has ', ...
            num2str(size(B,2)),' columns.'];
        causeException = MException('MATLAB:myCode:dimensions', msg);
        ME1 = addCause(ME, causeException);
   end
   rethrow(ME1)
end