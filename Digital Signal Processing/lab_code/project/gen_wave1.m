function waves = gen_wave1(tone, scale, octave, rising, rhythm, fs)
    f = tone2freq(tone, scale, octave, rising);
    t = linspace(0, rhythm, round(rhythm * fs));
    waves = sin(2 * pi * f * t);
      % 指数衰减
    decay_exp = exp(-3*t/rhythm); % 控制衰减速率
    waves = waves .* decay_exp;
end
