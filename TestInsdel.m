clear;
clc;

%rand('state', 0);

% Step 1.   Input segment number t and integer n [the segment length is n+ceil(log(n+1))]

% Step 2.   Generate segmented strings with marker structure,
%           encoded using VT encoding after being randomly generated
        
% Step 3.   Randomly insdel errors occur to segmented string

% Step 4.   Output the comparison result between segmented string and the recovery of its insdel erroneous

t = 40000; n = 6;  % Set segment number and information length

f = 1000;
F = ones(f,t-3);
for h = 1:f
%% 

[S, k, SegInsdelString] = SegInsdelECC( t,n );  % Segmented marker+VT+marker codeword, whose VT codewords are encoded from length n random generated strings
                                           % Moreover, these VT codewords are neither all 0s nor all 1s
%k = size(S,2);
% k is the length of VT codewords
%% 

[AfterInsdel,ND,NI,DelLoc,InsLoc,E,M] = RandomInsdel( SegInsdelString );   % Received string after random single segmented-insdel errors 

%% 

Decoded_VT = SegInsdelDec( AfterInsdel,t,k );
% S,AfterInsdel,DelLoc,InsLoc
% Decoded_VT(1:t-3,:)
% S(1:t-2,:)
Compare = sum ( abs( Decoded_VT(1:t-3,:) - S(1:t-3,:) ),2);

F(h,:) = Compare';
end

%[row] = find(F == 0, 2)
isAllZero = (nnz(F) == 0)






































