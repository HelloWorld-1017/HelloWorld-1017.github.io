function y = myfunc1(x) %#codegen
coder.allowpcode('plain');
y = sqrt(x.^3 + x.^2 + x + 1);
end