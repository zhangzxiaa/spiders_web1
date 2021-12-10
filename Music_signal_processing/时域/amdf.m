clc;
clear all;
[x,fs,nbits]=wavread('zuoye4_a.wav');
figure(1);
stem(x,'.');
title('浊音a原始信号波形')
%%
%以韵母a和清音声母p为分析对象，求其短时自相关函数和短时平均幅度差函数，比较清浊音；
%采样频率为44100，选择窗长为20ms即882点
frameSize=882;
overLap=441;
frameMat=buffer(x,frameSize,overLap);%将y整理为frameSize行ceil(L/frameSize)列的数据，每一列为一帧数据 
[ndim,nFrame]=size(frameMat);
N=882  %加矩形窗
frame1=frameMat(:,50);%取出其中的第50列即第50帧数据

B=[];
for k=1:N;
    sum=0;
    for m=1:N-k;
        sum=sum+frame1(m)*frame1(m+k); %计算自相关函数
    end
    R(k)=sum
end

for k=1:N
    R1(k)=R(k)/R(1);%归一化B(k)
end

figure(2);
subplot(3,1,1);
plot(frame1);
title('一帧语音信号')
subplot(3,1,2);
plot(R1);
title('自相关函数')
xlabel('延时 k')
ylabel('R(k)')


for k=1:N;
    sum=0;
    for m=1:N-k;
        sum=sum+abs(frame1(m)-frame1(m+k)); %计算AMDF
    end
    amdf1(k)=sum
end
subplot(3,1,3);
plot(amdf1);
title('短时平均幅度差函数')
xlabel('延时 k')
