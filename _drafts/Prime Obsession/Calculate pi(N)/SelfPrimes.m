function p = SelfPrimes(n)

if ~isscalar(n) 
  error(message('MATLAB:primes:InputNotScalar'));
elseif ~isreal(n)
  error(message('MATLAB:primes:ComplexInput'));
end

if n < 2
  p = zeros(1,0,class(n)); 
  return
elseif isfloat(n) && n > flintmax(class(n))
  warning(message('MATLAB:primes:NGreaterThanFlintmax'));
  n = flintmax(class(n));  
end

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
  end
end
p = cast(find(p)*2-1,class(n));
p(1) = 2;

