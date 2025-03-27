function [s] = VT2(a,n)
%   Input a,n
%   Output VT code: { x : Σ i·x_i ≡ a (mod 2n) }

r = 1 : n;
s = [];
m = 2*n;
for k = 0:2^n-1
    x = dec2bin(k,n) - '0';
    if mod(x*r,m) == a
        s = [s;x];
    end
end

end