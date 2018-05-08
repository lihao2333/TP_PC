%m_sequence.m
function [mseq] = m_sequence(g, n)
%+++++++++++++++++++++++variables++++++++++++++++++++++++++%
% g: 线性移位寄存器系数 反馈逻辑 八进制
% state: 寄存器的初始值， 二进制
% mseq: 生成的m序列
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
state=[zeros(1,n-1) 1];
gen=dec2bin(g)-48; % 十进制转二进制  dec2bin转换得到的是string类型，  
%因此用double强制转换后得到的是ASCII值，再减去48就可以了;数字0的ascii值为48
n=length(gen)-1; % 移位寄存器的个数
curState=state;
coeffi=fliplr(gen);% 序列逆序

N = 2^n-1; % m序列的最长周期

for k=1:N  
    a=mod(sum(coeffi(2:end).*curState),2);
    curState=[a curState(1:n-1)];
    mseq(k)=curState(1);
end

