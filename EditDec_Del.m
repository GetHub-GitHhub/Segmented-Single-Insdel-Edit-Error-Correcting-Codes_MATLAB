function [y]=EditDec_Del(x,a)
% VT decoder from a single deletion
% x is the input sequence and y is the decoded sequence
n = length(x);

z = 1 : n+1;

y = [];

for b = 0:1
    y = [b, x];
    if mod(y * z', 2*(n+1)) == a
        return;
    end
end

for i = 1:n
    for b = 0:1
        y = [x(1:i), b, x(i+1:end)];
        if mod(y * z', 2*(n+1)) == a
            return;
        end
    end
end











end