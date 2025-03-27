clear;
clc;
% Step 1.   Input segment number t and integer n [the segment length is n+ceil(log(n+1))]

% Step 2.   Generate segmented strings with marker structure,
%           encoded using VT encoding after being randomly generated
        
% Step 3.   Randomly insdel errors occur to segmented string

% Step 4.   Output the comparison result between segmented string and the recovery of its insdel erroneous


t = 40000; n = 8;  % Set segment number and information length

f = 1000;
F = ones(f,t-3);
for h = 1:f

%% 
[S, k, SegEditString] = SegEditECC( t,n );  % Segmented marker+VT+marker codeword, whose VT codewords are encoded from length n random generated strings
                                            % Moreover, these VT codewords are neither all 0s nor all 1s
% k is the length of VT codewords
%% 

[AfterEdit,ND,NI,NS,DelLoc,InsLoc,SubLoc,E,M] = RandomEdit( SegEditString );   % Received string after random single segmented-insdel errors 

%% 

Decoded_VT = SegEditDec( AfterEdit,t,k );
%S,AfterEdit,DelLoc,InsLoc,SubLoc
%Decoded_VT(1:t-3,:)
%S(1:t-3,:)
Compare = sum ( abs( Decoded_VT(1:t-3,:) - S(1:t-3,:) ),2);
% [M,k];
% [ND,DelLoc];
% [NI,InsLoc];
% [NS,SubLoc];
%[E(1:t-3),Compare]

F(h,:) = Compare';
end
%[row,col] = find(F~=0)
isAllZero = (nnz(F) == 0)


