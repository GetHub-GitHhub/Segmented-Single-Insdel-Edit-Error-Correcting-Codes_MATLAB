function [AfterEdit,ND,NI,NS,DelLoc,InsLoc,SubLoc,E,M] = RandomEdit(S)
%   Input segments of size (t,n)
%   Output string after random insdel errors

t = size(S,1);
M = size(S,2);
E = round( rand(t,1)*3 - 1 ); % Random insdel error to each segment { -1: deletion, 0: no error, 1: insertion }

DelLoc = [];
ND = find(E==-1);   % Indices of segments that have deletion errors
if size(ND,1) ~= 0
DelLoc = round( rand(size(ND,1),1)*(M-1) + 1 );   % Deletion location in each segment { in the range [1:M] }
end

InsLoc = [];
NI = find(E==1);    % Indices of segments that have insertion errors
if size(NI,1) ~= 0
InsLoc = round( rand(size(NI,1),1)*M );  % Insertion location in each segment { in the range [0:M] }
end                                      % for which 0 refers the insertion is front the beginning, the others are behind the bit of exact value
InsBits = round( rand(size(NI,1),1) );

SubLoc = [];
NS = find(E==2);   % Indices of segments that have substitution errors
if size(NS,1) ~= 0
SubLoc = round( rand(size(NS,1),1)*(M-1) + 1 );   % Deletion location in each segment { in the range [1:M] }
end

%%
DelS = S(ND,:); % To apply deletion errors;
for i = 1:size(ND,1)
    DelS( i,DelLoc(i) )= 100;
end             % These `100' are in fact the deleted locations, they will be deleted at the last step
DelS = [DelS,100*ones(size(ND,1),1)];

InsS = S(NI,:); % To apply insertion errors;
insS = [];
for i = 1:size(NI,1)
    part1 = InsS(i,1:InsLoc(i));
    part2 = InsS(i,InsLoc(i)+1:M);
    if InsLoc(i) == 0
        insS(i,:) = [InsBits(i),InsS(i,:)]; % Insertion location is 0
    else
        insS(i,:) = [part1,InsBits(i),part2];% Insertion location is not 0
    end
end


SS = [S,100*ones(t,1)]; % Extend one column to store those inserted segments
SS(ND,:) = DelS;
SS(NI,:) = insS;

% To apply substitution errors;
if size(NS,1) ~= 0
    for i = 1 : size(NS,1)
        Q = NS(i);
        W = SubLoc(i);
        SS( Q,W ) = 1 - SS( Q,W );
    end
end

SS = SS';

AfterEdit= SS(:)'; % Spread the matrix as a string as column
AfterEdit(AfterEdit==100) = []; % List the segments as a whole string











end