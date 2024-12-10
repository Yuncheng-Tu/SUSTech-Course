% 基础参数
fs = 8192;         % 采样频率
f = 440;           % 音符频率
rhythm = 1;        % 音符持续时间为1秒

% 生成基础正弦波形
t = linspace(0, rhythm, fs * rhythm);
y = sin(2 * pi * f * t);

% 指数衰减
exp_decay = exp(-t/rhythm);
y_exp = y .* exp_decay;

% 线性衰减
lin_decay = linspace(1, 0, length(t));
y_lin = y .* lin_decay;

% 平方衰减
sqr_decay = (1 - (t/rhythm)).^2;
y_sqr = y .* sqr_decay;

% 播放不同衰减的波形
sound(y_exp, fs);
pause(rhythm + 0.5);
sound(y_lin, fs);
pause(rhythm + 0.5);
sound(y_sqr, fs);

% 绘制波形
figure;
subplot(3,1,1);
plot(t, y_exp);
title('12111008屠耘诚','Exponential Decay');

subplot(3,1,2);
plot(t, y_lin);
title('Linear Decay');

subplot(3,1,3);
plot(t, y_sqr);
title('Square Decay');