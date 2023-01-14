clc, clear, close all

try
    out1 = helperFcn(2,1,4);
catch ME1
end

try
    out2 = helperFcn(2,4,1);
catch ME2
end

try
    out3 = helperFcn(2,3,4);
catch ME3
end
