import numpy as np
import wave
import matplotlib.pyplot as plt
import librosa
f = wave.open(r"04.wav", "rb")
params = f.getparams()
nchannels, sampwidth, framerate, nframes = params[:4]
print(params[:4])
str_data = f.readframes(nframes)#返回字符串类型的数据
signal = np.fromstring(str_data,dtype=np.int16)#转换为short类型的数组
signal_len=len(signal)
signal=signal/(max(abs(signal)))#归一化
signal_add=np.append(signal[0],signal[1:]-0.97*signal[:-1])   #预加重
time=np.arange(0,nframes)/1.0*framerate #时间轴
#画出原始信号和预加重后信号的时域波形图
plt.figure(figsize=(20,10))
plt.subplot(2,1,1)
plt.plot(time[0:len(signal)],signal)
plt.xlabel('time')
plt.subplot(2,1,2)
plt.plot(time[0:len(signal_add)],signal_add)
plt.xlabel('time')
plt.show()
#分帧
wlen=1024
inc=256
N=512
nf = int(np.ceil((1.0 * signal_len - wlen + inc) / inc))
pad_len=int((nf-1)*inc+wlen)
zeros=np.zeros(pad_len-signal_len)
pad_signal=np.concatenate((signal,zeros))
indices=np.tile(np.arange(0,wlen),(nf,1))+np.tile(np.arange(0,nf*inc,inc),(wlen,1)).T
indices=np.array(indices,dtype=np.int32)
frames=pad_signal[indices]
win=np.hamming(wlen)#加窗
def bark_change(x):
    return 6*np.log10(x/(1200*np.pi)+((x/(1200*np.pi))**2+1)**0.5)
def equal_loudness(x):
    return ((x**2+56.8e6)*x**4)/((x**2+6.3e6)**2*(x**2+3.8e8))
x=frames[10:] #选取一帧的数据
y=win*x[0]
a=np.fft.fft(y)#做fft，默认1024点
b=np.square(abs(a[0:N])) #求fft变换结果的模的平方
df=framerate/N  #频率分辨率
#freq_hz=np.fft.fftfreq(N,1/framerate)#频率轴坐标
i=np.arange(N)
freq_hz=i*df
print(freq_hz)
plt.plot(freq_hz,b)
plt.show()
freq_w=2*np.pi*np.array(freq_hz)#转换为角频率
freq_bark=bark_change(freq_w)#转换为bark频率
point_hz= [250, 350, 450, 570, 700, 840, 1000, 1170, 1370, 1600, 1850, 2150,2500,2900,3400]#选取15个中心频率
point_w=2*np.pi*np.array(point_hz)
point_bark =bark_change(point_w)
bank=np.zeros((15,N))#构造15行512列的矩阵，每一行为相应中心频率对应的一个滤波器向量
filter_data=np.zeros(15)#15维频带能量向量
for j in range(15):
    for k in range(N):
        omg= freq_bark[k]- point_bark[j]
        if -1.3<omg<-0.5:
            bank[j,k]=10**(2.5*(omg+0.5))
        elif -0.5<omg<0.5:
            bank[j,k]=1
        elif 0.5<omg<2.5:
            bank[j,k] = 10**(-1.0*(omg-0.5))
        else:
            bank[j,k]=0
    filter_data[j] = np.sum(b * bank[j])  # 15维的频带能量
    plt.plot(freq_hz,bank[j])
    plt.xlim(0,20000)
    plt.xlabel('hz')
plt.show()
equal_data=equal_loudness(point_w)*filter_data
cubic_data=equal_data**0.33
plp_data=np.fft.ifft(cubic_data,30)
print(plp_data)

plp=librosa.lpc(abs(plp_data), 15)
h1=1.0/np.fft.fft(plp,1024)
spec_envelope_plp =10*np.log10(abs(h1[0:512]))
lpc=librosa.lpc(y,15)
h2=1.0/np.fft.fft(lpc,1024)
spec_envelope_lpc =10*np.log10(abs(h2[0:512]))
plt.plot(spec_envelope_plp,'b',spec_envelope_lpc,'r')
plt.show()