%%ʵ��һ����Ƶ�������ݵķֱ�������ʾ��20*log10(y/y0) 
%%1.�Ŵ���С���ȵĲ��죬��С����ȵĲ��죻2.��С��̬��Χ�������ں�˼��㡣
%%����x�����и�����ȡ����ֵ���ж������㣬Ȼ���ٳ���sign��x���õ�ԭʼ����������ֵ��
clc;
clear all;
[x,Fs] = audioread('Little_White_Church.wav');
origx = x(:,1);
signx = sign(origx);
%������ x ��С��ͬ������ Y������ Y ��ÿ��Ԫ���ǣ�x �Ķ�ӦԪ�ش���0Ϊ1�� x �Ķ�ӦԪ�ص���0Ϊ0��x �Ķ�ӦԪ��С��0Ϊ-1
x=abs(origx);
%ѡȡ��׼��ѹ
temp = find(x~=0);
tempx = x(temp);
p0 = min(tempx)/2;
%��������
tempdBx = 20*log10(x/p0);
dBx = signx.*tempdBx;
dBx = fillmissing(dBx,'constant',0);
%��0ֵ���NaNֵ
subplot(2,1,1);
plot(origx(9000:10000));
subplot(2,1,2);
plot(dBx(9000:10000));


