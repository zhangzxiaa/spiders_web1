%% 1,���һ������/���ּ����������زģ��û���ƽ���˲���������ƽ������
 % ��smoothdata��filter���ַ���ʵ�֣���impz��freqz���鿴�˲�����ʱ��弤��Ӧ��Ƶ�졣
clc;
clear all;
[x,Fs] = audioread('Little_White_Church.wav');
x = x(:,1);
y = x+0.005*randn(size(x));
b = (1/5)*ones(1,5); a = 1;
Y1 = filter(b, a, x);
Y2 = smoothdata(x,'movmean',5);
% ʱ��弤��Ӧ
%figure;
%impz(b,a,20);
% Ƶ����Ӧ
%figure;
%freqz(b,a,512);
%% 2��ʹ��matlab�ṩ�ĵ�ͨ����ͨ����ͨ�ʹ��躯������һ�δ������������˲���
w1 = 0.1
w2 = 0.4
order = 6 
%[b,a] = butter(order,w,'low');
%[b,a] = butter(order,w,'high');
%[b,a] = butter(order,[w1 w2],'bandpass'); %w��������Ĭ�ϴ�ͨ
[b,a] = butter(order,[w1 w2],'stop');%����
dataOut = filter(b,a,x);
sound(dataOut,Fs)
