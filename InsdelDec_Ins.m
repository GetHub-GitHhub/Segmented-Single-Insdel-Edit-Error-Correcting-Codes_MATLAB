% VT decoder from a single insertion
% x is the input sequence and y is the decoded sequence
% a is syndrome of X
function [u] = InsdelDec_Ins(x,a)

n=length(x)-1;

z = 1 : n;
u = [];
for k = 1 : n+1
    y = x;
    y(k) = [];
    if mod( y*z', n+1 ) == a
        u = [u;y];
        return;
    end
end





end