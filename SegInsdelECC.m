function [S, k, SegInsdelString] = SegInsdelECC(t,n)
%   Input t,n
%   Output segmented string S with t segments with each one has length k, where each segment is a VT
%   codeword, whose informatioin bits are of length n, randomly generated


count = 0;

for i = n+1 : 2*n
    if i - ceil( log2(i+1) ) == n
        n_VT2Enc = i;
    end
end

S = zeros(2*t, n_VT2Enc);

for i = 1:1024*t
    x = randi([0,1], 1, n);
    if ~all(x == 0) && ~all(x == 1)
        y = VT1Enc(x,0);    % Due to the Assumption 1
        if ~isempty(y) && y(1) == 0
            count = count + 1;
            S(count, :) = y;
            if count >= 2*t
                break;
            end
        end
    end
end

S(all(S==1,2),:) = [];
S = S(1:t,:);          % Remove the strings that consisted by all 0's or 1's
k = size(S,2);         % Length of VT codeword

a1 = [1 1 1 1 0 1];
b0 = 0;

SegInsdelString = [b0.*ones(t,1),S,a1.*ones(t,1)];







end