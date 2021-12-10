%% ������ɢ���ұ任�͸���Ҷ�任��Ƶ��ͼ,���жԱȷ�����
clc;
clear all;
[x,Fs] = audioread('Little_White_Church.wav');
x = x(:,1);
%FFTƵ��ȡһ��
L1 = length(x); P = nextpow2(L1);
N = pow2(P); X = fft(x,N);
f = Fs/N:Fs/N:Fs/2;
Y_fft = X(2:N/2+1);
figure(1);
subplot(2,1,1)
plot(f,abs(Y_fft));
%DCTƵ��ȫȡ
X_dct = dct(x,N); Y_dct = X_dct(2:end);
f = Fs/(2*N):Fs/(2*N):(Fs/2-Fs/(2*N));
subplot(2,1,2);
plot(f,abs(Y_dct));
% ��idct�ؽ��ź�
X_dct = dct(x); %�ؽ��ź�ʱ���任�����������ݳ���
[XX,ind] = sort(abs(X_dct),'descend');
i = 1;
%% ѡȡ�����ζ��壩�ļ��������ؽ��ź�
while norm(X_dct(ind(1:i)))/norm(X_dct)<0.99
    i = i+1; %norm�Ƿ�����һά�����ķ����Ǿ�����
end
Needed = i; %NeededΪ11734���任������409925
X_dct(ind(Needed+1:end)) = 0;
xx = idct(X_dct);  
figure(2);
subplot(2,1,1);
plot(x)
subplot(2,1,2);
plot(xx)