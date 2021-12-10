%%使用timbretoolbox或者mirtoolbox，提取一个单音的ADSR模型相关参数；
%%振幅包络是乐器尤其重要的音质和音色特征，演化出了ADSR振幅包络模型（Attack，Decay，Sustain，Release）
%% 
[x,Fs] = audioread('Little_White_Church.wav');
origx = x(:,1);
np1 = 50; np2 = 200;
[up1,lo1] = envelope(x,np1,'peak');
%returns the upper and lower envelopes of the input sequence
[up2,lo2] = envelope(x,np2,'peak');
%peak可以换为RMS，此处比较了峰值法中不同np的结果
figure(1);
plot(origx(8000:10000));hold on 
plot(up1(8000:10000),'r');hold on 
plot(up2(8000:10000),'g');hold on 
plot(lo1(8000:10000),'r');hold on 
plot(lo2(8000:10000),'g');
legend('原信号','np=50','np=200');
%% 应用mirtoolbox提取单个乐音的ADSR参数
mirevents('flute.wav','Attack');
