% VT decoder from a single insertion
% x is the input sequence and y is the decoded sequence
% a is syndrome of X
function x=EditDec_Sub(x,a)


n = length(x);
z = 1 : n;

delta = mod( a - x*z', 2*n );
if delta <= n
    x(delta) = 1 - x(delta);
else
    x(2*n - delta) = 1 - x(2*n - delta);
end























end