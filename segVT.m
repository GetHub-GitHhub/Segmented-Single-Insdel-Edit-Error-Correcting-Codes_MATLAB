function [S] = segVT(t,n)
%   Input the number of segments t and length n
%   Out put binary VT codeword segments, each segment is encoded by a
%   random vector but not all zeros or ones

s = round(rand(2*t,n));
s(all(s==0),:) = [];
s(all(s==1),:) = [];

s = s(1:t,:);

S = [];
for i = 1:t
    x = s(i,:);
    y = VT1Enc(x,0);
    S = [S;y];
end

end

