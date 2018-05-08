%CorofCode.m
function [cor,lag] = CorofCode(c1,c2)
% 求两个扩频码字的相关性 
% 这是离散域的相关性， 书上公式是连续域
Len=length(c1);
cor=[];
for i=-Len:Len
   cor=[cor,sum(c1.*(circshift(c2.',i)).')/Len];
end
lag=-Len:Len;