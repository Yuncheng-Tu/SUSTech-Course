
function waves = gen_wave(tone, scale, noctave, rising, rhythm, fs)
    %根据音符、调号、八度和升降调生成正弦波形
    % tone: 数字音符，范围1到7
    % scale: 调号，字符'A'到'G'
    % noctave: 八度
    % rising: 升降调，-1, 0, 1
    % rhythm: 节拍，即音符持续时长（秒）
    % fs: 采样频率（Hz）
    
    f = tone2freq(tone, scale, noctave, rising);% 使用tone2freq函数来计算音符基频
    t = linspace(0, rhythm, round(rhythm * fs)); % 生成对应的时间数组，考虑到音符持续时长，并且确保数组大小正确，因为rhythm * fs可能不是整数
    
    % 添加泛音系列，比如基频及其一定数目的谐波
    % 要模拟出接近某种乐器的声音，我们可以尝试调整 `harmonics` 数组中的值，这样就可以使谐波的强度为基频的倍数
    % 其中对于数组harmonics中，不同的谐波的序号，基频的序号为1

%harmonics = [1,0.20,0.15,0.15,0.10,0.10,0.01,0.05,0.01,0.01,0.003,0.003,0.002,0.002];
%harmonics = [1,0.20,0.15,0.15,0.10];
% harmonics = [1,0.75, 0.5, 0.25, 0.15];
harmonics =[1, 0.20, 0.15, 0.15, 0.10, 0.10,0.06, 0.01, 0.01];
%harmonics = [1, 0.25, 0.10, 0.10, 0.10, 0.10, 0.01, 0.05, 0.01, 0.01, 0.003, 0.003, 0.002, 0.002];
    waves = harmonics(1) * sin(2 * pi * f * t); % 基频波形
    for n = 2:length(harmonics)
        waves = waves + harmonics(n) * sin(2 * pi * n * f * t); % 添加第n个谐波
    end
    
waves=waves/max(waves);                        %幅值归一化
    
    
    
    % 对波形应用一个简单的指数衰减包络，以模拟真实乐器的声音衰减
    % 指数衰减
    decay_exp = exp(-3*t/rhythm); % 控制衰减速率
    waves = waves .* decay_exp;


%     % 线性衰减with a modified decay factor
% 
%     decay_factor = 0.95; % Adjust this factor to control the decay rate
%     decay_linear = linspace(1, decay_factor, length(waves));
%     waves = waves .* decay_linear;



%     % 平方衰减
%     decay_square = (1 - (t/rhythm)).^2; % 确保在rhythm时衰减到0
%     waves = waves .* decay_square;
        
%             % 同时，这种衰减也可以在一个节拍内的几个音符中进行，比如单个音符的波形加一个衰减函数，几个音符的波形连在一起后再加上一个衰减函数。
%             % Define the envelope decay parameters
%             envelope_rhythm = rhythm; % Adjust the envelope decay time
%             envelope_points = round(envelope_rhythm * fs); % Number of envelope points
%             envelope = exp(linspace(0, -5, envelope_points)); % Exponential decay envelope
% 
%             % Initialize the waveform
%             waves = zeros(1, length(t));
% 
%             % Add harmonics to the waveform
%             for n = 1:length(harmonics)
%                 waves = waves + harmonics(n) * sin(2 * pi * n * f * t);
%             end
% 
%             % Apply the decay envelope
%             if length(t) >= envelope_points
%                 waves(1:envelope_points) = waves(1:envelope_points) .* envelope;
%             else
%                 % If the waveform is shorter than the envelope, apply the envelope only to the available points
%                 waves = waves .* envelope(1:length(t));
%             end    

end






%是没调制泛音和衰减的版本
% function waves = gen_wave(tone, scale, noctave, rising, rhythm, fs)
%     % 根据音符、调号、八度和升降调生成正弦波形
%     % tone: 数字音符，范围1到7
%     % scale: 调号，字符'A'到'G'
%     % noctave: 八度
%     % rising: 升降调，-1, 0, 1
%     % rhythm: 节拍，即音符持续时长（秒）
%     % fs: 采样频率（Hz）
%     
%     % 使用tone2freq函数来计算音符频率
%     freq = tone2freq(tone, scale, noctave, rising);
%     
%     % 生成对应的时间数组，考虑到音符持续时长
%     t = linspace(0, rhythm, round(rhythm * fs));%确保数组大小正确，因为rhythm * fs可能不是整数
%     
%     
%     % 生成正弦波形
%     waves = sin(2 * pi * freq * t);
% end
