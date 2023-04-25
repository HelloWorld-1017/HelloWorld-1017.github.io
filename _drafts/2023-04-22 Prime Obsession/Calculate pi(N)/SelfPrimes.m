function p = SelfPrimes(n)

n = floor(n);
p = true(1,double(ceil(n/2)));
q = length(p);
if (isa(n,'uint64') || isa(n,'int64')) && n > flintmax
  ub = 2.^(nextpow2(n)/2);  %avoid casting large (u)int64 to double
else
  ub = sqrt(double(n));
end
for k = 3:2:ub
  if p((k+1)/2)
     p(((k*k+1)/2):k:q) = false;
     disp(p)
  end
end
disp(find(p))
p = cast(find(p)*2-1,class(n)); % Convert variable to different data type
disp(p)
p(1) = 2;

