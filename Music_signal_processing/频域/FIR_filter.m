%% 1,设计一段语音/音乐加入噪声的素材，用滑动平均滤波对它进行平滑消噪
 % 用smoothdata和filter两种方法实现，用impz和freqz来查看滤波器的时域冲激响应和频响。
clc;
clear all;
[x,Fs] = audioread('Little_White_Church.wav');
x = x(:,1);
y = x+0.005*randn(size(x));
b = (1/5)*ones(1,5); a = 1;
Y1 = filter(b, a, x);
Y2 = smoothdata(x,'movmean',5);
% 时域冲激响应
%figure;
%impz(b,a,20);
% 频率响应
%figure;
%freqz(b,a,512);
%% 2，使用matlab提供的低通、高通、带通和带阻函数来对一段纯净声音进行滤波：
w1 = 0.1
w2 = 0.4
order = 6 
%[b,a] = butter(order,w,'low');
%[b,a] = butter(order,w,'high');
%[b,a] = butter(order,[w1 w2],'bandpass'); %w是向量则默认带通
[b,a] = butter(order,[w1 w2],'stop');%带阻
dataOut = filter(b,a,x);
sound(dataOut,Fs)
