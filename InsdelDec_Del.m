function [y] = InsdelDec_Del(x,a)
% VT decoder from a single deletion
% x is the input sequence and y is the decoded sequence
n = length(x);

z = 1 : n+1;

y = [];

if mod( [0 x]*z', n+2 ) == a || mod( [1 x]*z', n+2 ) == a
    y = [0 x];
    if mod( [1 x]*z', n+2 ) == a
        y = [1 x];
        return
    end
else
    for i = 1 : n
        y0 = [ x(1:i) 0 x(i+1:n) ];
        y1 = [ x(1:i) 1 x(i+1:n) ];
        if mod( y0*z', n+2 ) == a || mod( y1*z', n+2 ) == a
            y = y0;
            if mod( y1*z', n+2 ) == a
                y = y1;
                return
            end
        end
    end


end











end