function [y] = VT1Enc(x,a)
%   Input  x∈{0,1}^k
%   Output VT codeword y∈{0，1}^n such that VT(x)≡a(mod n+1)


k = length(x);
n = 0;

for i = k+1 : 2*k
    if i - ceil( log2(i+1) ) == k
        n = i;
    end
end                                 % Length of VT Codeword

m = n+1;    %   Set a value of m

y = zeros(1,n);
z = 1 : n;

S1 = 0 : ceil( log2(m) ) - 1 ;   % 2^j: 0 ≤ j ≤ ceil( log(m) ) - 1,  Redundant Bits
isB=ismember(z,2.^S1);
S2=z(~isB);                         % Information Bits


y(S2) = x;                          % Systematic Encoding

Delta = mod( a - y*z',m );          % Expand Δ, obtain the redundant bits

Redundant = flip( dec2bin( Delta,length(S1) ) ) - '0';  % Insert the redundant bits into y

y(2.^S1) = Redundant;





end