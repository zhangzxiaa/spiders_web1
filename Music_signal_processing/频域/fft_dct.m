%% 画出离散余弦变换和傅里叶变换的频谱图,进行对比分析。
clc;
clear all;
[x,Fs] = audioread('Little_White_Church.wav');
x = x(:,1);
%FFT频谱取一半
L1 = length(x); P = nextpow2(L1);
N = pow2(P); X = fft(x,N);
f = Fs/N:Fs/N:Fs/2;
Y_fft = X(2:N/2+1);
figure(1);
subplot(2,1,1)
plot(f,abs(Y_fft));
%DCT频谱全取
X_dct = dct(x,N); Y_dct = X_dct(2:end);
f = Fs/(2*N):Fs/(2*N):(Fs/2-Fs/(2*N));
subplot(2,1,2);
plot(f,abs(Y_dct));
% 用idct重建信号
X_dct = dct(x); %重建信号时，变换点数等于数据长度
[XX,ind] = sort(abs(X_dct),'descend');
i = 1;
%% 选取最大（如何定义）的几个分量重建信号
while norm(X_dct(ind(1:i)))/norm(X_dct)<0.99
    i = i+1; %norm是范数，一维向量的范数是均方根
end
Needed = i; %Needed为11734，变换点数是409925
X_dct(ind(Needed+1:end)) = 0;
xx = idct(X_dct);  
figure(2);
subplot(2,1,1);
plot(x)
subplot(2,1,2);
plot(xx)