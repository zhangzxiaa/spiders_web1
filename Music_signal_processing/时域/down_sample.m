%%读取一个wav文件，判断是单声道还是双声道，并进行相应处理；
%%然后对数据进行1/2以及1/4的降采样，播放降采样后的数据，画出其波形，给出听感评价。
%%
clc;
clear all;
[x,Fs] = audioread('Little_White_Church.wav');
s = size(x); % x是m*n的矩阵，m-样本数，n-通道数，s=[m,n]，是个1*2的向量
if s(:,2)==1  % size(s,2)
    y = x;
elseif s(:,2)==2
    y1 = x(:,1);
    y2 = x(:,2);
    y = 0.5*(y1+y2);               
end
%% 生成采样值对应的时间序列
T = 1/Fs;         % 采样周期
N = length(x);    % 序列点数
time = (N-1)*T;   % 文件总时长
t = 0:T:time;     % 原始t序列
t1 = 0:2*T:time;   % 降采样1/2
t2 = 0:4*T:time;   % 降采样1/4

%%对信号降采样
new_y1 = downsample(y,2);
%downsample通过保留第一个样本，然后保留第一个样本后的第n个样本，来降低x的采样率
%resample函数也可以
new_y2 = downsample(y,4);
subplot(2,1,1);        
plot(t1,new_y1);             
title('1/2降采样声道波形');
subplot(2,1,2);        
plot(t2,new_y2);             
title('1/4降采样声道波形');
%%播放声音信号
sound(new_y2,Fs/4) 