%% 这里用的自己计算的方法，也可以直接使用spectrogram(x,hamming(framelength),framestep,f,Fs,'yaxis‘);
clc;
clear all;
[x,Fs] = audioread('Little_White_Church.wav');
x = x(:,1);
framelength = round(Fs*0.025); %帧长25ms
framestep = round(framelength/2); %帧移一半
win = hamming(framelength); %海明窗
x_frame = enframe(x,win,framestep,'z');
frameNum = size(x_frame,1);
L1 = length(x_frame);
P = nextpow2(L1);
N = pow2(P);
x_fft = abs(fft(x_frame,N,2));
x_fft = x_fft(:,2:N/2+1); 
t_end = frameNum*framelength/(2*Fs);
t =0:framestep/Fs:t_end;
f = Fs/N:Fs/N:Fs/2;
x_fft = 20*log10(x_fft);
surf(t,f,x_fft','EdgeColor','none');
axis tight; 
%view(0,90);