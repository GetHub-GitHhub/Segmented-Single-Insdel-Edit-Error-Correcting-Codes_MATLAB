% VT decoder from a single insertion
% x is the input sequence and y is the decoded sequence
% a is syndrome of X
function u = EditDec_Ins(x,a)

n = length(x)-1;

z = 1 : n;
u = zeros(1,n);
for k = 1 : n+1
    y = x;
    y(k) = [];
    if mod( y*z', 2*n ) == a
        u = y;
        return;
    end
end
























end