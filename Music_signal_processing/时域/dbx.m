%%实现一段音频波形数据的分贝幅度显示：20*log10(y/y0) 
%%1.放大中小幅度的差异，减小大幅度的差异；2.缩小动态范围，有利于后端计算。
%%由于x有正有负，先取绝对值进行对数运算，然后再乘以sign（x）得到原始的正负对数值。
clc;
clear all;
[x,Fs] = audioread('Little_White_Church.wav');
origx = x(:,1);
signx = sign(origx);
%返回与 x 大小相同的数组 Y，其中 Y 的每个元素是：x 的对应元素大于0为1， x 的对应元素等于0为0，x 的对应元素小于0为-1
x=abs(origx);
%选取基准声压
temp = find(x~=0);
tempx = x(temp);
p0 = min(tempx)/2;
%对数运算
tempdBx = 20*log10(x/p0);
dBx = signx.*tempdBx;
dBx = fillmissing(dBx,'constant',0);
%用0值填充NaN值
subplot(2,1,1);
plot(origx(9000:10000));
subplot(2,1,2);
plot(dBx(9000:10000));


