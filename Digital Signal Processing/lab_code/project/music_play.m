fs = 8192; % 采样频率
song_tones = [1, 2, 3, 4, 5, 6, 7]; % 假设的音符序列
song_rhythms = [0.25, 0.5, 0.25, 0.25, 0.5, 0.25, 1]; % 各音符的持续时间
song_waves = [];

for i = 1:length(song_tones)
    wave = gen_wave(song_tones(i), 'C', 0, 0, song_rhythms(i), fs);
    song_waves = [song_waves, wave]; % 连接波形
end

sound(song_waves, fs); % 播放音乐
%filename = 'MySong.wav';
%audiowrite(filename, song_waves, fs);