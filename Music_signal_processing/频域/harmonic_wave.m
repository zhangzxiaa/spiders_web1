%% �����ź���г�����У��������ĸߵ�г�������ȡ���żг�������ȡ��Լ�����г�ȡ�
clc;
clear all;
%% 
[x,Fs] = audioread('piano.wav');
x = x(:,1);
framelength = round(Fs*0.025); %֡��25ms
framestep = round(framelength/2); %֡��һ��
win = hamming(framelength); %������
x_frame = enframe(x,win,framestep,'z');
frameNum = size(x_frame,1);
L1 = length(x_frame);
P = nextpow2(L1);
N = pow2(P);
x_fft = abs(fft(x_frame,N,2));
x_fft = x_fft(:,2:N/2+1); 
%%
HL_Energy_ratio = zeros(frameNum-8,1)
OE_Energy_ratio = zeros(frameNum-8,1)
Inharmonicity = zeros(frameNum-8,1)
for i = 9:frameNum
    temp = x_fft(i,:);
    envelope_flute = envelope(temp,100,'rms');
    %���Ƶ��Ӧ�ĵ���λ�ú�Ƶ�ʴ�С
    [max_flute,locmax_flute]= max(envelope_flute); 
    f_d2_flute = locmax_flute*Fs/N; 
    %���÷�ֵ������г��
    [peak_flute,loc_flute] = findpeaks(envelope_flute,'minpeakdistance',0.005,'minpeakheight',0.005);
    %minpeakdistance;����͵�ľ��롣 minpeakheight����ֵ�ڸ�ֵ֮��
    loc_flute = loc_flute(2:10); 
    %��ߵ�г��������
    F_high = peak_flute(5:10);
    F_low = peak_flute(2:4);
    HL_Energy_ratio(i) = sum(power(F_high,2))./sum(power(F_low,2)); 
    %����żг��������
    F_odd = peak_flute(2:2:10);
    F_even = peak_flute(3:2:10);
    OE_Energy_ratio(i) = sum(power(F_odd,2))./sum(power(F_even,2));
    %�󲻺�г��
    Ff0 = locmax_flute;
    Ff_predict = (2:10).*Ff0;
    Ff_actual = loc_flute;
    Temp1 = abs(Ff_actual-Ff_predict).* power(envelope_flute(Ff_actual),2);
    Temp2 = power(envelope_flute(Ff_actual),2);
    Inharmonicity(i) = (2/Ff0)*sum(Temp1)/sum(Temp2);
end
