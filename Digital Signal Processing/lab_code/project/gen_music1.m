function music_wave = gen_music1(tone, rising, noctave, rhythm, fs, scale)
 

    % 初始化音乐波形数组
    music_wave = [];
    
    % 对每个音符进行循环，生成波形并连接
    for i = 1:length(tone)
        % 如果音符为0，代表是休止符，添加静音
        if tone(i) == 0
            silence = zeros(1, round(rhythm * fs));
            music_wave = [music_wave, silence];
        else
            % 生成当前音符的波形
            wave = gen_wave1(tone(i), scale, noctave(i), rising(i), rhythm, fs);
            music_wave = [music_wave, wave];
        end
    end
end