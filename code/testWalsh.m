%testWalsh.m
%-Walsh序列的产生，并观察其相关性
clc
clear
n=4;
H = hadamard(n);
indx1=3; indx2=4;
c1=H(indx1,:); % 取第一个码字
c2=H(indx2,:); % 取第二个码字
% --------------完全同步时的自相关性 与互相关性--------------
R1=sum(c1.*c1)/length(c1);   
R2=sum(c2.*c2)/length(c2);
R1a2=sum(c1.*c2)/length(c2);
%--------码字之间有时移时的相关性------
[cor11,lag11] = CorofCode(c1,c1);
[cor22,lag22] = CorofCode(c2,c2);
[cor12,lag12] = CorofCode(c1,c2);
subplot(3,1,1)
stem(lag11,cor11);legend('auto-correlation');
subplot(3,1,2)
stem(lag22,cor22);legend('auto-correlation');
subplot(3,1,3)
stem(lag12,cor12);legend('cross-correlation');



