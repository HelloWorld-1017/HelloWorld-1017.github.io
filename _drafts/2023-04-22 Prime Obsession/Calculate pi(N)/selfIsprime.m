function isp = selfIsprime(X)

isp = false(size(X));

if ~isempty(X)  
    X = X(:);
    
    n = max(X);
    if isinteger(X) || n <= flintmax(class(X))
        if (isa(X,'uint64') || isa(X,'int64')) && n > flintmax
            p = primes(2.^(nextpow2(n)/2));
        else
            p = primes(cast(sqrt(double(n)),class(X)));
        end
        for k = 1:numel(isp)
            Xk = X(k);
            isp(k) = (Xk>1) && all(rem(Xk, p(p<Xk)));
        end
    else
        
        fm = flintmax(class(X));
        p = primes(sqrt(fm));
        for k = 1:numel(isp)
            Xk = X(k);
            isp(k) = (Xk<fm) && (Xk>1) && all(rem(Xk, p(p<Xk)));
        end
    end
end
