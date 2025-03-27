function [s] = seg(x,t)
%   Input sequence x
%   Output segmented sequence X with segment length t

n = length(x);
n1 = ceil(n/t);
N = n1*t;

y = zeros(1,N);
y([1:n]) = x;   % If the length of x is not divisiable by t, then add zeros to make it satisfied

X = zeros(n1,t);

for i = 1:n1
    X(i,:) = y([ (i-1)*n1+1 : (i-1)*n1+t ]);
end

end