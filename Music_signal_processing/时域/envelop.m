%%ʹ��timbretoolbox����mirtoolbox����ȡһ��������ADSRģ����ز�����
%%�������������������Ҫ�����ʺ���ɫ�������ݻ�����ADSR�������ģ�ͣ�Attack��Decay��Sustain��Release��
%% 
[x,Fs] = audioread('Little_White_Church.wav');
origx = x(:,1);
np1 = 50; np2 = 200;
[up1,lo1] = envelope(x,np1,'peak');
%returns the upper and lower envelopes of the input sequence
[up2,lo2] = envelope(x,np2,'peak');
%peak���Ի�ΪRMS���˴��Ƚ��˷�ֵ���в�ͬnp�Ľ��
figure(1);
plot(origx(8000:10000));hold on 
plot(up1(8000:10000),'r');hold on 
plot(up2(8000:10000),'g');hold on 
plot(lo1(8000:10000),'r');hold on 
plot(lo2(8000:10000),'g');
legend('ԭ�ź�','np=50','np=200');
%% Ӧ��mirtoolbox��ȡ����������ADSR����
mirevents('flute.wav','Attack');
