clc;
clear all;
[x,fs,nbits]=wavread('zuoye4_a.wav');
figure(1);
stem(x,'.');
title('����aԭʼ�źŲ���')
%%
%����ĸa��������ĸpΪ�������������ʱ����غ����Ͷ�ʱƽ�����Ȳ�����Ƚ���������
%����Ƶ��Ϊ44100��ѡ�񴰳�Ϊ20ms��882��
frameSize=882;
overLap=441;
frameMat=buffer(x,frameSize,overLap);%��y����ΪframeSize��ceil(L/frameSize)�е����ݣ�ÿһ��Ϊһ֡���� 
[ndim,nFrame]=size(frameMat);
N=882  %�Ӿ��δ�
frame1=frameMat(:,50);%ȡ�����еĵ�50�м���50֡����

B=[];
for k=1:N;
    sum=0;
    for m=1:N-k;
        sum=sum+frame1(m)*frame1(m+k); %��������غ���
    end
    R(k)=sum
end

for k=1:N
    R1(k)=R(k)/R(1);%��һ��B(k)
end

figure(2);
subplot(3,1,1);
plot(frame1);
title('һ֡�����ź�')
subplot(3,1,2);
plot(R1);
title('����غ���')
xlabel('��ʱ k')
ylabel('R(k)')


for k=1:N;
    sum=0;
    for m=1:N-k;
        sum=sum+abs(frame1(m)-frame1(m+k)); %����AMDF
    end
    amdf1(k)=sum
end
subplot(3,1,3);
plot(amdf1);
title('��ʱƽ�����Ȳ��')
xlabel('��ʱ k')
