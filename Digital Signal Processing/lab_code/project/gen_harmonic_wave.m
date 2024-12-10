function wave = gen_harmonic_wave(tone, scale, noctave, rising, rhythm, fs, harmonics_ratios)
    % 根据音符、调号、八度和升降调生成含有谐波的波形
    % harmonics_ratios 是一个数组，包含了各个谐波的能量比例

    % 使用tone2freq函数来计算基频
    freq = tone2freq(tone, scale, noctave, rising);

    % 生成对应的时间数组
    t = linspace(0, rhythm, fs * rhythm);

    % 初始化波形
    wave = zeros(1, length(t));

    % 生成基频波形及其谐波
    for n = 1:length(harmonics_ratios)
        wave = wave + harmonics_ratios(n) * sin(2 * pi * n * freq * t);
    end

    % 添加包络衰减
    envelope = exp(-t/rhythm);
    wave = wave .* envelope;
end
