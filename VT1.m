function [s] = VT1(a,n)
%   Input a,n
%   Output VT code: { x : Σ i·x_i ≡ a (mod n+1) }

r = [1:n]';
s = [];
m = n+1;
for k = 0:2^n-1
    x = dec2bin(k,n) - '0';
    if mod(x*r,m) == a
        s = [s;x];
    end
end

end