% Define the sampling frequency and rhythm duration for each note
fs = 44100; % Standard sampling rate for audio
rhythm = 0.75; % Example rhythm duration of half a second for each note
scale = 1;
%%
tone1=[6 7 1 7 1 3 7 3 3 6 5 6 1 5 0 3 3 4 3 4 1];
tone2=[3 0 1 1 1 7 4 4 7 7 0 6 7 1 7 1 3 7 0 3 3 6 5 6 1];
tone3=[5 0 3 4 1 7 7 1 2 2 3 1 0 1 7 6 6 7 5 6 0 1 2 3 2 3 5];
tone4=[2 0 5 5 1 7 1 3 3 0 0 6 7 1 7 2 2 1 5 5 0 4 3 2 1];
tone5=[3 3 3 6 5 5 3 2 1 0 1 2 1 2 2 5 3 0 3];
tone6=[6 5 3 2 1 0 1 2 1 2 2 7 6 0 6 7 6];

noctave1=[0 0 1 0 1 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1];
noctave2=[0 0 1 1 1 0 0 0 0 0 0 0 0 1 0 1 1 0 0 0 0 0 0 0 1];
noctave3=[0 0 0 0 1 0 0 1 1 1 1 1 0 1 0 0 0 0 0 0 0 1 1 1 1 1 1];
noctave4=[1 0 0 0 1 0 1 1 1 0 0 0 0 1 0 1 1 1 0 0 0 1 1 1 1];
noctave5=[1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1];
noctave6=[1 1 1 1 1 0 1 1 1 1 1 0 0 0 0 0 0];


rising1=[zeros(1,21)];
rising2=[0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
rising3=zeros(1,length(tone3));
rising3(19)=1;
rising4=zeros(1,length(tone4));
rising5=zeros(1,length(tone5));
rising6=zeros(1,length(tone6));
rising1=rising1-1;
rising2=rising2-1;
rising3=rising3-1;
rising4=rising4-1;
rising5=rising5-1;
rising6=rising6-1;
rhythm1=[0.5 0.5 1.5 0.5 1 1 3 0.5 0.5 1.5 0.5 1 1 2 1 0.5 0.5 1.5 0.5 0.5 1.5];
rhythm2=[2 0.5 0.5 0.5 0.5 1.5 0.5 1 1 2 1 0.5 0.5 1.5 0.5 1 1 2 1 0.5 0.5 1.5 0.5 1 1];
rhythm3=[3 0.5 0.5 1 0.5 0.5 1 1 0.66 0.66 0.66 1 1 1 0.5 0.5 0.5 1 1 2 1 0.5 0.5 1.5 0.5 1 1];
rhythm4=[2 1 0.5 0.5 0.5 0.5 1 1 2 1 1 0.5 0.5 1 1 0.5 0.5 1.5 0.5 1 1 1 1 1 1];
rhythm5=[6 0.5 1 2 1 1 0.5 0.5 1 0.5 0.5 1 0.5 0.5 0.5 1 2 1 1];
rhythm6=[2 2 0.5 0.5 2 0.5 0.5 1 0.5 0.5 0.5 1 2 1 0.5 0.5 4];

% 
% tone1=[6 7 1 7 1 3 7 3 3 6 5 6 1 5 0 3 3 4 3 4 1];
% tone2=[3 0 1 1 1 7 4 4 7 7 0 6 7 1 7 1 3 7 0 3 3 6 5 6 1];
% tone3=[5 0 3 4 1 7 7 1 2 2 3 1 0 1 7 6 6 7 5 6 0 1 2 3 2 3 5];
% tone4=[2 0 5 5 1 7 1 3 3 0 0 6 7 1 7 2 2 1 5 5 0 4 3 2 1];
% tone5=[3 3 0 3 6 5 5 3 2 1 0 1 2 1 2 2 5 3 0 3];
% tone6=[6 5 3 2 1 0 1 2 1 2 2 7 6 0 6 7 6];
% 
% 
% rising1=[zeros(1,21)];
% rising2=[0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% rising3=zeros(1,length(tone3));
% rising3(19)=1;
% rising4=zeros(1,length(tone4));
% rising5=zeros(1,length(tone5));
% rising6=zeros(1,length(tone6));
% 
% 
% noctave1=[0 0 1 0 1 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1];
% noctave2=[0 0 1 1 1 0 0 0 0 0 0 0 0 1 0 1 1 0 0 0 0 0 0 0 1];
% noctave3=[0 0 0 0 1 0 0 1 1 1 1 1 0 1 0 0 0 0 0 0 0 1 1 1 1 1 1];
% noctave4=[1 0 0 0 1 0 1 1 1 0 0 0 0 1 0 1 1 1 0 0 0 1 1 1 1];
% noctave5=[1 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1];
% noctave6=[1 1 1 1 1 0 1 1 1 1 1 0 0 0 0 0 0];

% Generate waveforms for each segment
music_wave1 = gen_music(tone1, rising1, noctave1, rhythm, fs, scale);
music_wave2 = gen_music(tone2, rising2, noctave2, rhythm, fs, scale);
music_wave3 = gen_music(tone3, rising3, noctave3, rhythm, fs, scale);
music_wave4 = gen_music(tone4, rising4, noctave4, rhythm, fs, scale);
music_wave5 = gen_music(tone5, rising5, noctave5, rhythm, fs, scale);
music_wave6 = gen_music(tone6, rising6, noctave6, rhythm, fs, scale);

% Concatenate all waveforms to create the full piece
full_music_wave = [music_wave1, music_wave2, music_wave3, music_wave4, music_wave5, music_wave6];
%%

% Play the sound
sound(full_music_wave, fs);

%plot the waveform:
t = 0:1/fs:(length(full_music_wave)-1)/fs; % Corrected time vector
plot(t, full_music_wave);
xlabel('Time (s)');
ylabel('Amplitude');
title('12111008屠耘诚','Final Music Waveform');

%% 
% 测试单个音符的波形

a1 = gen_wave1(6,1,0,0,rhythm,fs);

a2 = gen_wave(6,1,0,0,rhythm,fs);
t1 = 0:1/fs:(length(a1)-1)/fs
t2 = 0:1/fs:(length(a2)-1)/fs

figure
subplot (2,1,1)

plot(t1,a1);xlim([0,0.01])
xlabel('time');
ylabel('magnitude');
title('without harmonic waves ','12111008屠耘诚');
subplot (2,1,2)

plot(t2,a2);xlim([0,0.01])
xlabel('time');
ylabel('magnitude');
title('with harmonic waves ([1,0.20,0.15,0.15,0.10,0.10,0.01,0.05,0.01,0.01,0.003,0.003,0.002,0.002])','12111008屠耘诚');
%%
% 使用FFT计算频谱
N = length(full_music_wave); % 获取波形的长度
frequencies = (0:N-1) * fs / N; % 创建频率轴

% 进行FFT变换
spectrum = abs(fftshift(fft(full_music_wave, N)));

% 绘制频谱图
figure;
plot(frequencies, spectrum);
xlabel('Frequency (Hz)');
ylabel('|fft(music wave)|');
title('12111008屠耘诚','ak=[1, 0.20, 0.15, 0.15, 0.10, 0.10, 0.06, 0.01, 0.01]');

% 可能需要对频谱图进行进一步的处理和缩放以获得有用的信息
%%
N=length(full_music_wave);
Y= fft(full_music_wave)
P2=Y;
f_music = fs*(0:length(full_music_wave)-1) /length(full_music_wave)-fs/2;

figure
subplot(211),plot(f_music,abs(P2)),title({'Amplitude of music signal','12111008屠耘诚'}),xlim([-5000,5000])
xlabel('frequency'),ylabel('Amplitude')
subplot(212),plot(f_music,unwrap(angle(P2))),title({'Phase of music signal','12111008屠耘诚'})
xlabel('frequency'),ylabel('Phase')

%%



% % 进行傅里叶变换以分析频谱
% Y = fft(full_music_wave);
% P2 = abs(Y/length(full_music_wave));
% P1 = P2(1:length(full_music_wave)/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = fs*(0:(length(full_music_wave)/2))/length(full_music_wave);
% % 绘制频谱
% figure;
% plot(full_music_wave,P1) 
% title('Single-Sided Amplitude Spectrum of waves(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

 % 保存为 WAV 文件
    filename = ['music_test',  '.wav'];
    audiowrite(filename,full_music_wave, fs);
    disp(['Audio file saved as ', filename]);