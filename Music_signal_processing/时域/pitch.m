%% �����ʺ�����غ������Խ������Ƶ����ʱƽ�����Ȳ���˷����������������
%�����ʷ��������һ�Ƶ
clc;
clear all;
T = 1;
fs = 8000;%����Ƶ��
f = 10;%�����źŵ�Ƶ��
t = 0:1/fs:T;
y = sin(2*pi*f*t);
figure(1);
plot(t,y);
s = sign(y);
d = abs(diff(s));
zcr = sum(d)/2;
f_zcr = zcr/2;
disp(f_zcr);  % 9.75Hz
% ����ط������һ�Ƶ
[acf,lags] = autocorr(y,fs);
figure(2);
plot(lags,acf);
grid on;
[m,n] = findpeaks(acf);%mΪpeak��ֵ��nΪλ��
peak = n(2)-n(1);%ֱ���ҵڶ�����ֵ�������õ�������ֵ��ڶ�����ֵ�ľ���
f_cor = fs/peak;
disp(f_cor); % 10Hz
%% ����һ�����ɵĻ�Ƶ����
[x,Fs] = audioread('Little_White_Church.wav');
x = x(:,1);
minfreq = 100;
framelength = round(2.5*Fs/minfreq);%֡��Ҫ����2.5���Ļ������ڣ�����ȡ2.5��
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
%����ֵ�˲�ȥ��Ұ��
freq = medfilt1(freq,3);
figure(3);
plot(freq);xlabel('֡��');ylabel('��Ƶ��Hz��');
