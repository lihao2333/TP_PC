%testMsquence.m
%%  生成m序列，观察m序列的相关性
clear
clc
n=9; %移位寄存器个数
%------------generate------------------ 
g = primpoly(n,'min');
g2 = primpoly(n,'max');
[mseq] = m_sequence(g, n);
[mseq2] = m_sequence(g2, n);

%-------------calculate cor-----------
mq=1-2*mseq; % 单极性转双极性
[cor,lag] = CorofCode(mq,mq); % 自相关
mq2=1-2*mseq2; % 单极性转双极性
[cor12,lag12] = CorofCode(mq,mq2); % 互相关

%--------------plot---------------- 

subplot(2,1,1)
stem(lag,cor)
legend(sprintf('auto-correlation of %d ',g));
title(sprintf('mseq when n=%d',n))
subplot(2,1,2)
stem(lag12,cor12)
legend(sprintf('cross-correlation of %d and %d',g,g2));
