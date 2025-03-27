function [y] = VT2Enc(x,a)
%   Input  x∈{0,1}^k
%   A VT codeword y∈{0，1}^n such that VT(x)≡a(mod m), where m is either n+1 or 2n
%   When m = n+1， VT code can correct a single insdel
%   When m = 2n, VT code can correct a single edit


k = length(x);
n = 0;

for i = k+1 : 2*k
    if i - ceil( log2(2*i) ) == k
        n = i;
    end
end                                 % n, Length of VT Codeword

m = 2*n;    %   Set a value of m

y = zeros(1,n);
z = 1:n;

S1 = 0 : ceil( log2(m) ) - 1;   % 2^j: 0 ≤ j ≤ ceil( log(m) ) - 1,  Redundant Bits
isB=ismember(z,[2.^S1,n]);
S2=z(~isB);                      % Information Bits
isA=ismember(z,S2);
S1=z(~isA);

y(S2) = x;                       % Systematic Encoding


Delta = mod( a - y*z',m );       % Expand Δ, obtain the redundant bits
if Delta < n
    Redundant = flip( dec2bin( Delta,length(S1) ) ) - '0';  % Insert the redundant bits into y
    y(S1) = Redundant;
    y(n) = 0;
else
    Redundant = flip( dec2bin( Delta - n,length(S1) ) ) - '0';
    y(S1) = Redundant;
    y(n) = 1;
end

end