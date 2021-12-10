%% 过零率和自相关函数可以近似求基频，短时平均幅度差函数乘法运算量比自相关少
%过零率方法求正弦基频
clc;
clear all;
T = 1;
fs = 8000;%采样频率
f = 10;%正弦信号的频率
t = 0:1/fs:T;
y = sin(2*pi*f*t);
figure(1);
plot(t,y);
s = sign(y);
d = abs(diff(s));
zcr = sum(d)/2;
f_zcr = zcr/2;
disp(f_zcr);  % 9.75Hz
% 自相关法求正弦基频
[acf,lags] = autocorr(y,fs);
figure(2);
plot(lags,acf);
grid on;
[m,n] = findpeaks(acf);%m为peak的值，n为位置
peak = n(2)-n(1);%直接找第二个峰值，或者用第三个峰值与第二个峰值的距离
f_cor = fs/peak;
disp(f_cor); % 10Hz
%% 计算一段旋律的基频曲线
[x,Fs] = audioread('Little_White_Church.wav');
x = x(:,1);
minfreq = 100;
framelength = round(2.5*Fs/minfreq);%帧长要大于2.5倍的基音周期，这里取2.5倍
framestep = round(framelength/2);
frame = enframe(x,framelength,framestep,'z');
%mode input:'z': zero pad to fill up final frame
numframes = size(frame,1);
freq=ones(numframes,1);
for i=1:numframes
    temp = frame(i,:);
    [acf,lags] = autocorr(temp,framelength-2)
 [m,n] = findpeaks(acf);
    freq(i) = Fs/(n(2)-n(1));
end
%做中值滤波去除野点
freq = medfilt1(freq,3);
figure(3);
plot(freq);xlabel('帧数');ylabel('基频（Hz）');
