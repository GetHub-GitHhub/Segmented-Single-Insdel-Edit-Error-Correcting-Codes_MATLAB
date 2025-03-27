function [S] = zhenzhi(N,b)
%生成N长的b元真值表
S=ones(b^N,N);
for i=0:b^N-1
    S(i+1,:)=dec2base(i,b,N)-'0';
end
end

