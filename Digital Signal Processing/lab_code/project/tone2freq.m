function freq = tone2freq(tone, scale, noctave, rising)
% tone: 输入数字音符，数值范围1到7
% noctave: 高或低八度的数量，数值范围整数。0表示中音，正数表示高noctave个八度，负数为低noctave个八度
% rising: 升或降调。1为升，−1为降，0无升降调
% freq为输出的频率
% 确保输入的音符在1到7之间
if (tone < 1 || tone > 7)
    error('音符必须在1到7之间');
end
% C调中1-7的基准频率数组, 这些频率是调号scale对应的半音步数，相对于C大调而言
C_scale_base_freqs = [261.5, 293.5, 329.5, 349, 391.5, 440, 494]; % C, D, E, F, G, A, B
% scale_semitones = [0, 2, 4, 5, 7, 9, 11, 12];调号的半音间隔数数组，索引1表示C调，2表示D调，以此类推号scale对应的半音步数
% 获取调号对应的主音频率
main_f = C_scale_base_freqs(scale);

% 数字tone对应的半音数
semitone_map = [0, 2, 4, 5, 7, 9, 11];
% 计算相对主音的半音数
semitone_from_main = semitone_map(tone) + rising;

% 计算音符频率
freq = main_f * 2^(semitone_from_main/12) * 2^noctave;

end
