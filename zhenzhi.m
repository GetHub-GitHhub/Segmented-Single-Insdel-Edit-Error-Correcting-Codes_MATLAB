function [S] = zhenzhi(N,b)
%����N����bԪ��ֵ��
S=ones(b^N,N);
for i=0:b^N-1
    S(i+1,:)=dec2base(i,b,N)-'0';
end
end

