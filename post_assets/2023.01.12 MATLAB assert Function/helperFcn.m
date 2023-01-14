function out = helperFcn(a,b,c)

assert(a<=b, "MYError:agtb", "a=%d, b=%d, c=%d. a is greater than b", a, b, c)

assert(a<=c, "MYError:agtb", "a=%d, b=%d, c=%d. a is greater than c", a, b, c)

out = a;
end

